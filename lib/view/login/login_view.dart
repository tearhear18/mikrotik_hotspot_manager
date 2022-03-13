import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mikrotik_manager/common/config.dart';
import 'package:mikrotik_manager/common/form_helper.dart';
import 'package:mikrotik_manager/view/login/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // ignore: prefer_typing_uninitialized_variable
  LoginController login = LoginController();

  bool obscureText = true;
  void onIconTap() {
    obscureText = !obscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    login.ctx = context;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "HOTSPOT MANAGER",
                style: TextStyle(fontSize: 20, color: Colors.indigo),
              ),
              const Text(
                "DEVELOPER: RAMEL CABUG-OS",
                style: TextStyle(fontSize: 10, color: Colors.black26),
              ),
              const SizedBox(
                height: 50.0,
              ),
              FormHelper.button("Connect to ${Config.licensee}", login.initLogin)
            ],
          ),
        ),
      ),
    );
  }
}
