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
    List<DocumentReference> listSellers =
        sellers.map((e) => db.doc('/usuarios/$e/')).toList();

    await eventReference.add({
      "name": name,
      "tickets": tickets,
      "sellers": listSellers,
    }).then((eventDocument) async {
      await Future.wait(sellers.map((uid) async {
        await userReference.doc(uid).update({
          'events': FieldValue.arrayUnion([eventDocument])
        });
      }));
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
    List sellersList = data['sellers'];

    List<UserModel> sellers = await Future.wait(sellersList.map((e) async {
      DocumentSnapshot seller = await e.get();

      return UserModel.fromReference(seller);
    }).toList());

    return EventModel.fromSnapshot(e, sellers);
  }).toList());

  return events;
}

Future<Map<String, dynamic>> updateEvent(
    String name, String tickets, String uid, List sellers) async {
  try {
    List<DocumentReference> listSellers =
        sellers.map((e) => db.doc('/usuarios/$e/')).toList();
    DocumentReference eventRef = eventReference.doc(uid);

    await eventReference.doc(uid).set({
      'name': name,
      'tickets': tickets,
      "sellers": listSellers,
    }).then((_) async {
      userReference
          .where('events', arrayContainsAny: [eventRef])
          .get()
          .then((queryUsers) async {
            await Future.wait(queryUsers.docs.map((user) async {
              await userReference.doc(user.id).update({
                'events': FieldValue.arrayRemove([eventRef])
              });
            })).then((value) async {
              await Future.wait(listSellers.map((seller) async {
                seller.update({
                  'events': FieldValue.arrayUnion([eventRef])
                });
              })).then((_) => result['error'] = false);
            });
          });
    }).onError((error, stackTrace) {
      result['errorMessage'] = error.toString();
    });
  } catch (e) {
    result['errorMessage'] = e.toString();
  }

  return result;
}

Future<Map<String, dynamic>> destroyEvent(String uid) async {
  try {
    DocumentReference eventRef = eventReference.doc(uid);

    await eventReference.doc(uid).delete().then((value) {
      userReference
          .where('events', arrayContainsAny: [eventRef])
          .get()
          .then((queryUsers) async {
            await Future.wait(queryUsers.docs.map((user) async {
              await userReference.doc(user.id).update({
                'events': FieldValue.arrayRemove([eventRef])
              });
            })).then((value) => result['error'] = false);
          });
    });
  } catch (e) {
    result['errorMessage'] = e.toString();
  }

  return result;
}
