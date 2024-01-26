import 'package:flutter/material.dart';
import 'package:ticket_app/models/event.dart';
import 'package:ticket_app/providers/events.dart';
import 'package:ticket_app/screens/layouts/appbar.dart';
import 'package:ticket_app/screens/layouts/generals.dart';
import 'package:ticket_app/screens/layouts/modals.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  bool _loading = true;
  AppBarLayouts appBarLayouts = AppBarLayouts();
  GeneralsLayouts generalsLayouts = GeneralsLayouts();
  Modals modalsLayout = Modals();
  EventsProvider eventsProvider = EventsProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    eventsProvider.addListener(() {
      setState(() {
        _loading = false;
      });
    });

    eventsProvider.loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
        actions: [appBarLayouts.logoutButton(context)],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: eventsProvider.events.length,
              itemBuilder: (context, index) {
                EventModel event = eventsProvider.events[index];
                Map sellers = event.sellers != null ? event.sellers! : {};
                String sellersCount = event.sellers != null
                    ? event.sellers!.length.toString()
                    : '0';
                return Dismissible(
                  key: Key(event.uid!),
                  confirmDismiss: (direction) async {
                    bool result = false;

                    result = await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => modalsLayout.confirmationModal(
                          'Esta seguro de eliminar el evento ${event.name}?.',
                          context),
                    );

                    return result;
                  },
                  onDismissed: (direction) =>
                      eventsProvider.deleteEvent(event.uid!),
                  background: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.delete,
                            color: Colors.blue,
                            size: MediaQuery.of(context).size.height * 0.07),
                        Text(
                          'Borrar',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.07),
                        )
                      ],
                    ),
                  ),
                  child: generalsLayouts.listItems(context, event.name!,
                      'Vendedores: $sellersCount', event.tickets!, [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/eventos/editar',
                          arguments: {
                            'event': event,
                            'edit': true,
                            'sellers': sellers,
                          },
                        ).then((value) => eventsProvider.loadEvents());
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                  ]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/eventos/crear', arguments: {
            'edit': false,
            'sellers': {},
          }).then((value) => eventsProvider.loadEvents());
        },
        shape: const StadiumBorder(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: generalsLayouts.footer(context, 2),
    );
  }
}
