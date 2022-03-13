  import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mikrotik_manager/common/api_service.dart';
import 'package:mikrotik_manager/common/config.dart';
import 'package:mikrotik_manager/common/form_helper.dart';
import 'package:mikrotik_manager/common/time_parser.dart';
import 'package:mikrotik_manager/model/code.dart';
import 'package:http/http.dart';

class CodeController {
  late Function setStateCallback;
  late Code userInfo;
  late BuildContext context;

  TextEditingController customTime = TextEditingController();
  FocusNode customTimeFocus = FocusNode();

  subCredit(int hour) async {
    TimeParser tp = TimeParser(userInfo.uptimeLimit);
    var params = {"limit-uptime": tp.subHour(hour)};
    ApiService.patch('rest/ip/hotspot/user/${userInfo.username}', params,
        (StreamedResponse response) {
      if (response.statusCode == 201) {
        FormHelper.showAlertDialog(context, "Success", "Time Updated");
      }
    });
  }

  disable() {
    var params = {"disabled": "true"};
    ApiService.patch('rest/ip/hotspot/user/${userInfo.username}', params,
        (StreamedResponse response) {
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        FormHelper.showAlertDialog(context, "Success", "Account Disabled!");
      }
    });
  }

  removeMac() {
    var params = {"mac-address": "00:00:00:00:00:00"};
    ApiService.patch('rest/ip/hotspot/user/${userInfo.username}', params,
        (StreamedResponse response) {
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        FormHelper.showAlertDialog(
            context, "Success", "Account Mac Address removed!");
      }
    });
  }

  addCredit(int hour) async {
    TimeParser tp = TimeParser(userInfo.uptimeLimit);
    log(tp.subHour(hour));
    var params = {"limit-uptime": tp.addHour(hour)};
    ApiService.patch('rest/ip/hotspot/user/${userInfo.username}', params,
        (StreamedResponse response) {
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        FormHelper.showAlertDialog(context, "Success", "Time Updated");
      }
    });
  }

  getUserInfo(voucherCode){
    ApiService.get('rest/ip/hotspot/user/$voucherCode', (response) async {

      var user = jsonDecode(await response.stream.bytesToString());
      String limitUptime = user['limit-uptime'] ?? 'Unlimited';
      String timeConsumed = user['uptime'] ?? 'Unlimited';
      String status = (user['disabled'] == 'true') ? "Disabled" : "Active";
      String macAddress = user['mac-address'] ?? "Not Set";
      String profile = (user['profile'] =='default') ? 'Unlimitted' : user['profile'];
      userInfo = Code(
          user['.id'],user['name'], profile , limitUptime, timeConsumed, status, macAddress);
      setStateCallback();
    });
  }
}
