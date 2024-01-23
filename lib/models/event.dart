import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? uid;
  String? name;
  String? tickets;

  EventModel({
    required this.uid,
    required this.name,
    this.tickets = '0',
  });

  factory EventModel.fromSnapshot(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return EventModel(
        uid: snapshot.id,
        name: data['name'] ?? '',
        tickets: data['tickets'] ?? '0');
  }
}
