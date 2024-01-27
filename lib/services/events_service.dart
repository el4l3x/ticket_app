import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_app/models/event.dart';
import 'package:ticket_app/models/user.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
CollectionReference eventReference = db.collection('events');
CollectionReference userReference = db.collection('usuarios');

Map<String, dynamic> result = {"error": true, "errorMessage": ""};

Future<Map<String, dynamic>> storeEvent(
    String name, String tickets, List sellers) async {
  try {
    Map<String, DocumentReference> mapSellers = {
      for (var item in sellers)
        sellers.indexOf(item).toString(): db.doc('/usuarios/$item/')
    };

    await eventReference.add({
      "name": name,
      "tickets": tickets,
      "sellers": mapSellers,
    });

    result['error'] = false;
  } catch (e) {
    result['errorMessage'] = e.toString();
  }

  return result;
}

Future<List<EventModel>> getEvents() async {
  QuerySnapshot queryEvents = await eventReference.get();

  List<QueryDocumentSnapshot> documents = queryEvents.docs;

  List<EventModel> events = await Future.wait(documents.map((e) async {
    Map<String, dynamic> data = e.data() as Map<String, dynamic>;
    Map<String, dynamic> sellersMap = data['sellers'];

    List<UserModel> sellers =
        await Future.wait(sellersMap.entries.map((e) async {
      DocumentSnapshot seller = await e.value.get();

      return UserModel.fromReference(seller);
    }).toList());

    return EventModel.fromSnapshot(e, sellers);
  }).toList());

  return events;
}

Future<Map<String, dynamic>> updateEvent(
    String name, String tickets, String uid, List sellers) async {
  try {
    Map<String, DocumentReference> mapSellers = {
      for (var item in sellers)
        sellers.indexOf(item).toString(): db.doc('/usuarios/$item/')
    };

    await eventReference
        .doc(uid)
        .set({
          'name': name,
          'tickets': tickets,
          "sellers": mapSellers,
        })
        .then((value) => result['error'] = false)
        .onError((error, stackTrace) {
          result['errorMessage'] = error.toString();
          return false;
        });
  } catch (e) {
    result['errorMessage'] = e.toString();
  }

  return result;
}

Future<Map<String, dynamic>> destroyEvent(String uid) async {
  try {
    await eventReference
        .doc(uid)
        .delete()
        .then((value) => result['error'] = false);
  } catch (e) {
    result['errorMessage'] = e.toString();
  }

  return result;
}
