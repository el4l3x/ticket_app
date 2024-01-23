import 'package:flutter/material.dart';
import 'package:ticket_app/models/event.dart';
import 'package:ticket_app/services/events_service.dart';

class EventsProvider extends ChangeNotifier {
  List<EventModel> _events = [];
  List<EventModel> get events => _events;
  bool result = false;

  void loadEvents() async {
    _events = await getEvents();
    notifyListeners();
  }

  void deleteEvent(String uid) async {
    destroyEvent(uid).then((value) {
      if (value['error']) {
        return result;
      } else {
        loadEvents();
        return result = true;
      }
    });
  }
}
