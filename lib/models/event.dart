import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_app/models/user.dart';

class EventModel {
  String? uid;
  String? name;
  String? tickets;
  List<UserModel>? sellers;

  EventModel({
    required this.uid,
    required this.name,
    this.tickets = '0',
    this.sellers,
  });

  factory EventModel.fromSnapshot(
      QueryDocumentSnapshot snapshot, List<UserModel> sellers) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return EventModel(
      uid: snapshot.id,
      name: data['name'] ?? '',
      tickets: data['tickets'] ?? '0',
      sellers: sellers,
    );
  }
}
