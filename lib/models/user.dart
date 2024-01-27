import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? nombre;
  String? password;
  String? username;
  bool? isAdmin;

  UserModel({
    required this.uid,
    required this.nombre,
    required this.password,
    required this.username,
    this.isAdmin = false,
  });

  factory UserModel.fromSnapshot(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot.id,
      nombre: data['nombre'] ?? '',
      password: data['password'] ?? '',
      username: data['username'] ?? '',
      isAdmin: data['id_admin'],
    );
  }

  factory UserModel.fromReference(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      uid: snapshot.id,
      nombre: data['nombre'] ?? '',
      password: data['password'] ?? '',
      username: data['username'] ?? '',
      isAdmin: data['id_admin'],
    );
  }
}
