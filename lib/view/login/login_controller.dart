import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mikrotik_manager/common/config.dart';
import 'package:http/http.dart';

class LoginController {
  TextEditingController host = TextEditingController();
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  FocusNode hostFocus = FocusNode();
  FocusNode userFocus = FocusNode();
  FocusNode passFocus = FocusNode();

  Config config = Config();

  late BuildContext ctx;

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Error"),
      content: const Text("Invalid Account"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  initLogin() async {
    String apiUrl = 'https://192.168.88.1/rest/ip/hotspot/active';
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${Config.username}:${Config.password}'));

    Response r =
        await get(Uri.parse(apiUrl), headers: {'authorization': basicAuth});
    if (r.statusCode != 200) {
      showAlertDialog(ctx);
    } else {
      Navigator.pushReplacementNamed(ctx, '/dashboard');
    }
  }
}
