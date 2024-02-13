import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/models/user_firebase.dart';
import 'package:ticket_app/providers/events.dart';
import 'package:ticket_app/screens/layouts/appbar.dart';
import 'package:ticket_app/screens/layouts/generals.dart';
import 'package:ticket_app/screens/layouts/modals.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
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
        title: const Text('Eventos'),
        actions: [appBarLayouts.logoutButton(context)],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : const Center(
              child: Text('vender'),
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
      bottomNavigationBar: generalsLayouts.footer(context, 2, userAuth),
    );
  }
}
