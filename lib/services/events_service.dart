import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_app/models/event.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
CollectionReference eventReference = db.collection('events');

Map<String, dynamic> result = {"error": true, "errorMessage": ""};

Future<Map<String, dynamic>> storeEvent(String name, String tickets) async {
  try {
    await eventReference.add({
      "name": name,
      "tickets": tickets,
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

  List<EventModel> events =
      documents.map((e) => EventModel.fromSnapshot(e)).toList();

  return events;
}

Future<Map<String, dynamic>> updateEvent(
    String name, String tickets, String uid) async {
  try {
    await eventReference
        .doc(uid)
        .set({
          'name': name,
          'tickets': tickets,
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
