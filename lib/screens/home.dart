import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/models/user_firebase.dart';
import 'package:ticket_app/screens/layouts/appbar.dart';
import 'package:ticket_app/screens/layouts/generals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AppBarLayouts appBarLayouts = AppBarLayouts();
    GeneralsLayouts generalsLayouts = GeneralsLayouts();
    UserAuth userAuth = Provider.of<UserAuth>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inicio',
        ),
        actions: [
          appBarLayouts.logoutButton(context),
        ],
      ),
      bottomNavigationBar: generalsLayouts.footer(context, 0, userAuth),
    );
  }
}
