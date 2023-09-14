import 'package:flutter/material.dart';

class ConnectionProvider extends ChangeNotifier {
  bool isConnection = false;

  void connectionChange(bool connection) {
    isConnection = connection;
    notifyListeners();
  }
}
