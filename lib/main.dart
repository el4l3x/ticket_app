import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/models/user_firebase.dart';
import 'package:ticket_app/screens/events/events_seller.dart';
import 'package:ticket_app/screens/events/form_event.dart';
import 'package:ticket_app/screens/events/events.dart';
import 'package:ticket_app/screens/events/show.dart';
import 'package:ticket_app/screens/home.dart';
import 'package:ticket_app/screens/login.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:ticket_app/screens/sellers/create.dart';
import 'package:ticket_app/screens/sellers/edit.dart';
import 'package:ticket_app/screens/sellers/index.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserAuth>(
        create: (context) => UserAuth(),
      )
    ],
    child: const App(),
  ));
  /* runApp(const App()); */
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 233, 236, 239),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
            backgroundColor: Colors.blue,
            actionsIconTheme: IconThemeData(
              color: Colors.white,
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            )),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        primaryColor: Colors.blue,
      ),
      home: const LoginScreen(),
      routes: {
        '/dashboard': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/eventos': (context) => const EventsScreen(),
        '/eventos/crear': (context) => const FormEventScreen(),
        '/eventos/editar': (context) => const FormEventScreen(),
        '/eventos/ver': (context) => const ShowEventScreen(),
        '/eventos/asignados': (context) => EventsSellerScreen(
            userAuth: ModalRoute.of(context)!.settings.arguments as Map),
        '/vendedores': (context) => const SellersScreen(),
        '/vendedores/crear': (context) => const CreateSellerScreen(),
        '/vendedores/editar': (context) => const EditSellerScreen(),
      },
    );
  }
}
