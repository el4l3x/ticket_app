import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUsers() async {
  List users = [];

  CollectionReference collectionReferenceUsers = db.collection('usuarios');

  QuerySnapshot queryUsers = await collectionReferenceUsers.get();

  for (var document in queryUsers.docs) {
    users.add(document.data());
  }

  return users;
}

Future<Map<String, dynamic>> loginAuth(String username, String password) async {
  Map<String, dynamic> result = {
    "errorMessage": "",
    "user": null,
    "error": true
  };

  try {
    QuerySnapshot querySnapshot = await db
        .collection('usuarios')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      if (querySnapshot.docs.first['password'] == password) {
        result['error'] = false;
        result['user'] = querySnapshot.docs.first.data();
        result['uid'] = querySnapshot.docs.first.id;
      } else {
        result['errorMessage'] = 'Clave incorrecta.';
      }
    } else {
      result['errorMessage'] = 'Este usuario no existe.';
    }
  } catch (e) {
    result['errorMessage'] = 'Fallo la consulta. $e';
  }

  return result;
}
