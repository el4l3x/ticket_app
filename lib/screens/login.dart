import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/models/user_firebase.dart';
import 'package:ticket_app/services/firebase_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController textUser = TextEditingController();
  TextEditingController textPassword = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    await loginAuth(textUser.text, textPassword.text).then((value) => {
          if (value['error'])
            {showError(value['errorMessage'])}
          else
            {
              Provider.of<UserAuth>(context, listen: false)
                  .setUser(value['user']),
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/dashboard',
                (_) => false,
              ),
            },
        });
    setState(() {
      loading = false;
    });
  }

  void showError(String? error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error!)));
  }

  void redirectHome() {
    Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 236, 239),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterLogo(
                  size: 50,
                ),
                Text(
                  'TicketApp',
                  style: TextStyle(fontSize: 50),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Container(
              padding: const EdgeInsets.only(
                  top: 15, left: 15, right: 15, bottom: 30),
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: const BorderDirectional(
                      top: BorderSide(
                    color: Colors.blue,
                    width: 5,
                  )),
                  shape: BoxShape.rectangle,
                  boxShadow: const [
                    BoxShadow(
                      blurStyle: BlurStyle.outer,
                      blurRadius: 1,
                    ),
                  ]),
              child: Column(
                children: [
                  const Text(
                    'Autenticarse para iniciar sesión',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                      key: formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: textUser,
                            validator: (val) =>
                                val!.isEmpty ? 'Ingrese un usuario' : null,
                            decoration:
                                inputDecoration(Icons.person, 'Usuario'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: textPassword,
                            obscureText: true,
                            validator: (val) =>
                                val!.isEmpty ? 'Ingrese una clave' : null,
                            decoration: inputDecoration(Icons.key, 'Clave'),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          loading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buttonAction(
                                        'Crear Cuenta', Icons.person_add, () {
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          '/registrarse', (route) => false);
                                    }),
                                    buttonAction('Iniciar', Icons.login, () {
                                      if (formkey.currentState!.validate()) {
                                        setState(() {
                                          loading = true;
                                          _loginUser();
                                        });
                                      }
                                    }),
                                  ],
                                ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextButton buttonAction(String label, IconData icon, Function action) {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                /* const Color.fromARGB(255, 233, 236, 239), */
                Colors.blue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(color: Colors.blue)))),
        onPressed: () => action(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ));
  }

  InputDecoration inputDecoration(IconData icon, String label) {
    return InputDecoration(
      suffixIcon: Icon(icon),
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.black45,
      ),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
        color: Colors.black26,
        width: 1,
      )),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1)),
      floatingLabelStyle: const TextStyle(color: Colors.black),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      border: const OutlineInputBorder(
          borderSide: BorderSide(width: 5, color: Colors.black)),
    );
  }
}
