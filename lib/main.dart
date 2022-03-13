import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mikrotik_manager/view/dashboard/active_users/active_user_view.dart';
import 'package:mikrotik_manager/view/dashboard/code/code_view.dart';
import 'package:mikrotik_manager/view/dashboard/code_generator/code_generator_view.dart';
import 'package:mikrotik_manager/view/dashboard/dashboard_view.dart';
import 'package:mikrotik_manager/view/login/login_view.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotspot Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginView(),
        '/dashboard': (context) => const DashboardView(),
        '/code': (context) => const CodeView(),
        '/active_users': (context) => const ActiveUserView(),
        '/code_generator': (context) => const CodeGeneratorView(),
      },
    );
  }
}
