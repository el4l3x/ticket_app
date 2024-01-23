import 'package:flutter/material.dart';
import 'package:ticket_app/models/user.dart';
import 'package:ticket_app/services/user_service.dart';

class User extends ChangeNotifier {
  Map<String, dynamic> userAuth = {};
  List<UserModel> _sellers = [];

  List<UserModel> get sellers => _sellers;

  void setUser(Map<String, dynamic> user) {
    userAuth = user;
    notifyListeners();
  }

  void loadSellers() async {
    _sellers = await getSellers();
    notifyListeners();
  }
}
