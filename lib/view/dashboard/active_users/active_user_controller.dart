import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mikrotik_manager/common/api_service.dart';
import 'package:mikrotik_manager/common/form_helper.dart';
import 'package:http/http.dart';

class ActiveCode {
  String code;
  String macAddress;
  String id;
  ActiveCode(this.id, this.code, this.macAddress);
}

class ActiveUserController {
  late Function setStateCallback;
  List<ActiveCode> activeUsers = [];
  late BuildContext context;

  disconnect(user) {
    ApiService.delete('rest/ip/hotspot/active/${user.id}',
        (StreamedResponse response) {
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        FormHelper.showAlertDialog(
            context, "Success", "Account locked to Mac Address!");
      }
    });
  }

  lock(ActiveCode user) {
    var params = {"mac-address": user.macAddress};
    ApiService.patch('rest/ip/hotspot/user/${user.code}', params,
        (StreamedResponse response) {
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        FormHelper.showAlertDialog(
            context, "Success", "Account locked to Mac Address!");
      }
    });
  }

  getActiveUsers() {
    activeUsers.clear();
    ApiService.get('rest/ip/hotspot/active', (response) async {
      List data = jsonDecode(await response.stream.bytesToString());
      for (var user in data) {
        activeUsers
            .add(ActiveCode(user['.id'], user['user'], user['mac-address']));
      }
      setStateCallback();
    });
  }
}
