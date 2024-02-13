import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/models/event.dart';
import 'package:ticket_app/models/user.dart';
import 'package:ticket_app/models/user_firebase.dart';
import 'package:ticket_app/providers/events.dart';
import 'package:ticket_app/screens/layouts/appbar.dart';
import 'package:ticket_app/screens/layouts/generals.dart';
import 'package:ticket_app/screens/layouts/modals.dart';

class EventsSellerScreen extends StatefulWidget {
  const EventsSellerScreen({super.key});

  @override
  State<EventsSellerScreen> createState() => _EventsSellerScreenState();
}

class _EventsSellerScreenState extends State<EventsSellerScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    UserAuth userAuth = Provider.of<UserAuth>(context);

    if (userAuth.uid != null) {
      eventsProvider.loadEventsSeller(userAuth.uid!);
      _loading = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos Asignados'),
        actions: [appBarLayouts.logoutButton(context)],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: eventsProvider.events.length,
              itemBuilder: (context, index) {
                EventModel event = eventsProvider.events[index];
                List<UserModel> sellers = event.sellers ?? [];

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
                  onDismissed: (direction) {
                    eventsProvider.deleteEvent(event.uid!);
                    setState(() {
                      eventsProvider.events.removeAt(index);
                    });
                  },
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
                  child: generalsLayouts.listItems(
                      context,
                      event.name!,
                      'Vendedores: ${sellers.length}',
                      'Entradas: ${event.tickets!}', [
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
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/eventos/ver',
                            arguments: {
                              'event': event,
                            });
                      },
                      icon: const Icon(
                        Icons.remove_red_eye,
                        color: Colors.blue,
                      ),
                    ),
                  ]),
                );
              },
            ),
      bottomNavigationBar: generalsLayouts.footer(context, 2, userAuth),
    );
  }
}
