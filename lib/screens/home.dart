import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/models/user_firebase.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    User userAuth = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ))
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlutterLogo(
                  size: 40,
                ),
                Text(
                  'Bienvenido/a',
                  style: TextStyle(fontSize: 40),
                ),
              ],
            )),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Eventos'),
              onTap: () {
                Navigator.pushNamed(context, '/eventos');
              },
            ),
            userAuth.isAdmin!
                ? ListTile(
                    leading: const Icon(Icons.people),
                    title: const Text('Vendedores'),
                    onTap: () {
                      Navigator.pushNamed(context, '/vendedores');
                    },
                  )
                : ListTile(
                    leading: const Icon(Icons.calculate),
                    title: const Text('Pendientes'),
                    onTap: () {},
                  )
          ],
        ),
      ),
      body: Center(
        child: userAuth.isAdmin!
            ? const Text(
                'Bienvenido Administrador',
              )
            : Text(
                'Bienvenido/a ${userAuth.nombre}',
              ),
      ),
    );
  }
}
