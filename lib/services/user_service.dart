import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_app/models/user.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
CollectionReference collectionReferenceUsers = db.collection('usuarios');

Map<String, dynamic> result = {"errorMessage": "", "user": null, "error": true};

Future<List> getUsers() async {
  QuerySnapshot queryUsers = await collectionReferenceUsers.get();

  List<QueryDocumentSnapshot> documents = queryUsers.docs;

  List<UserModel> users =
      documents.map((doc) => UserModel.fromSnapshot(doc)).toList();

  return users;
}

Future<List<UserModel>> getSellers() async {
  QuerySnapshot queryUsers =
      await collectionReferenceUsers.where('is_admin', isEqualTo: false).get();

  List<QueryDocumentSnapshot> documents = queryUsers.docs;

  List<UserModel> sellers =
      documents.map((doc) => UserModel.fromSnapshot(doc)).toList();

  return sellers;
}

Future<Map<String, dynamic>> loginAuth(String username, String password) async {
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
      } else {
        result['errorMessage'] = 'Clave incorrecta.';
      }
    } else {
      result['errorMessage'] = 'Este usuario no existe.';
    }
  } catch (e) {
    result['errorMessage'] = 'Fallo la consulta.';
  }

  return result;
}

Future<void> storeSeller(
    String nombre, String username, String password) async {
  await collectionReferenceUsers.add({
    "nombre": nombre,
    "username": username,
    "password": password,
    "is_admin": false,
  });
}

Future<void> updateSeller(String uid, String newNombre, String newUsername,
    String newPassword) async {
  await collectionReferenceUsers.doc(uid).set({
    "nombre": newNombre,
    "username": newUsername,
    "password": newPassword,
    "is_admin": false
  });
}

Future<Map<String, dynamic>> destroySeller(String uid) async {
  try {
    await collectionReferenceUsers
        .doc(uid)
        .delete()
        .then((value) => result['error'] = false);
  } catch (e) {
    result['errorMessage'] = e.toString();
  }

  return result;
}
