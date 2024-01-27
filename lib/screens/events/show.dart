import 'package:flutter/material.dart';
import 'package:ticket_app/models/event.dart';
import 'package:ticket_app/models/user.dart';
import 'package:ticket_app/screens/layouts/appbar.dart';

class ShowEventScreen extends StatefulWidget {
  const ShowEventScreen({super.key});

  @override
  State<ShowEventScreen> createState() => _ShowEventScreenState();
}

class _ShowEventScreenState extends State<ShowEventScreen> {
  AppBarLayouts appBarLayouts = AppBarLayouts();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final EventModel event = arguments['event'];

    return Scaffold(
      appBar: AppBar(
        title: Text(event.name!),
        actions: [
          appBarLayouts.logoutButton(context),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Entradas totales: ${event.tickets}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Vendedores Asignados: ${event.sellers!.length}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: event.sellers!.length,
            itemBuilder: (BuildContext context, int index) {
              UserModel seller = event.sellers![index];
              return ListTile(
                title: Text('${seller.nombre}'),
                subtitle: Text('${seller.username}'),
              );
            },
          ),
        ],
      ),
    );
  }
}
