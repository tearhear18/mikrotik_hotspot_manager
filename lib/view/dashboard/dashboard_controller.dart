import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mikrotik_manager/common/api_service.dart';
import 'package:mikrotik_manager/common/config.dart';
import 'package:mikrotik_manager/common/form_helper.dart';
import 'package:http/http.dart';

class DashboardController {
  TextEditingController codeVoucher = TextEditingController();
  FocusNode codeVoucherFocus = FocusNode();

  TextEditingController customTime = TextEditingController();
  FocusNode customTimeFocus = FocusNode();
  TextEditingController customUser = TextEditingController();
  FocusNode customUserFocus = FocusNode();

  List<String> codes = [];
  late BuildContext ctx;
  late Function setStateCallback;
  List<String> activeUsers = [];

  void addUser() async {
    int hour = int.parse(customTime.text.trim());
    String user = customUser.text.trim().toString();

    var params = {"name": user, "profile": "1M-BAND", "limit-uptime": "${hour}h"};
    ApiService.put('rest/ip/hotspot/user', params, (response){
      if(response.statusCode == 201){
        FormHelper.showAlertDialog(ctx, "Success", "User Added");
      }
    });
  }

  void getVouchers() async {
    ApiService.get('rest/ip/hotspot/user',(response) async {
      List vouchers = jsonDecode(await response.stream.bytesToString());
      for (var element in vouchers) {
        codes.add(element['name'] ?? "NULL");
      }
      setStateCallback();
    });
  }
}
