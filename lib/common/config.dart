import 'dart:convert';

class Config {
  static const String password = "Cs49oupouj!";
  static const String username = "admin";
  static const String licensee = "Ramel";
  static const String host = "10.0.0.1";
  static const String email = "tearhear18@gmail.com";

  static const List<int> timeSettings = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  static String basicAuth() {
    return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  }
}
