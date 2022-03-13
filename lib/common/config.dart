import 'dart:convert';

class Config {
  static const String password = "Cs49oupouj!";
  static const String username = "admin";
  static const String licensee = "Ramel";
  static const String host = "192.168.88.1";
  static const String email = "tearhear18@gmail.com";

  static String basicAuth() {
    return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  }
}
