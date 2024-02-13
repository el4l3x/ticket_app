import 'package:flutter/material.dart';

class UserAuth extends ChangeNotifier {
  Map<String, dynamic> userAuth = {};
  String? nombre;
  String? username;
  String? password;
  bool? isAdmin;
  String? uid;

  /* User({
    this.nombre,
    this.username,
    this.password,
    this.isAdmin,
  }); */

  void setUser(Map<String, dynamic> user, String uid) {
    userAuth = user;
    nombre = user['nombre'];
    username = user['username'];
    password = user['password'];
    isAdmin = user['is_admin'];
    uid = uid;
    notifyListeners();
  }

  /* factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      nombre: data?['nombre'],
      username: data?['username'],
      password: data?['password'],
      isAdmin: data?['is_admin'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) 'nombre': nombre,
      if (nombre != null) 'username': username,
      if (nombre != null) 'password': password,
      if (nombre != null) 'is_admin': isAdmin,
    };
  } */
}
