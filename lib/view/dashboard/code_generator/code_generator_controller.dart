import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mikrotik_manager/common/api_service.dart';
import 'package:mikrotik_manager/view/dashboard/code/code_controller.dart';
import 'package:mikrotik_manager/view/dashboard/dashboard_controller.dart';

class CodeGeneratorController {
  TextEditingController size = TextEditingController();
  TextEditingController time = TextEditingController();
  FocusNode sizeFocus = FocusNode();
  FocusNode timeFocus = FocusNode();
  List<String> codes = [];

  late Function setStateCallback;

  String generateRandomString(int length) {
    final _random = Random();
    const _availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length,
            (index) => _availableChars[_random.nextInt(_availableChars.length)])
        .join();

    return randomString;
  }

  void addUser(int hour, String user) async {
    var params = {
      "name": user,
      "profile": "1M-BAND",
      "limit-uptime": "${hour}h"
    };
    ApiService.put('rest/ip/hotspot/user', params, (response) {
      if (response.statusCode == 201) {
        setStateCallback();
      }
    });
  }

  generate() {
    codes.clear();
    int codeSize = int.parse(size.text.trim());
    int hour = int.parse(time.text.trim());
    String pattern =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

    for (int a = 1; a <= codeSize; a++) {
      String newCode = generateRandomString(8).toUpperCase();

      var params = {
        "name": newCode,
        "profile": "1M-BAND",
        "limit-uptime": "${hour}h"
      };
      print(params);
      ApiService.put('rest/ip/hotspot/user', params, (response) {
        print(response.statusCode);
        if (response.statusCode == 201) {
          // add only when code was registered to mikrotik
          codes.add(newCode);
          print(response.statusCode);
          setStateCallback();
        }
      });

    }

  }
}
