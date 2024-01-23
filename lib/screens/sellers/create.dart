import 'package:flutter/material.dart';
import 'package:ticket_app/screens/layouts/forms.dart';
import 'package:ticket_app/services/user_service.dart';

class CreateSellerScreen extends StatefulWidget {
  const CreateSellerScreen({super.key});

  @override
  State<CreateSellerScreen> createState() => _CreateSellerScreenState();
}

class _CreateSellerScreenState extends State<CreateSellerScreen> {
  final FormComponents formComponents = FormComponents();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController textName = TextEditingController();
  TextEditingController textUsername = TextEditingController();
  TextEditingController textPassword = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Vendedor'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.05,
              horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: textName,
                    validator: (val) => val!.isEmpty
                        ? 'Ingrese un nombre para el vendedor.'
                        : null,
                    decoration: formComponents.inputDecoration(
                        Icons.contact_phone, 'Nombre'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: textUsername,
                    validator: (val) => val!.isEmpty
                        ? 'Ingrese un usuario para el vendedor.'
                        : null,
                    decoration: formComponents.inputDecoration(
                        Icons.account_circle, 'Usuario'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: textPassword,
                    validator: (val) => val!.isEmpty
                        ? 'Ingrese una clave para el vendedor.'
                        : null,
                    decoration:
                        formComponents.inputDecoration(Icons.vpn_key, 'Clave'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  loading
                      ? const CircularProgressIndicator()
                      : formComponents.buttonAction('Guardar', Icons.save,
                          () async {
                          if (formkey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            await storeSeller(textName.text, textUsername.text,
                                    textPassword.text)
                                .then((value) => {
                                      setState(() {
                                        loading = false;
                                      }),
                                      Navigator.pop(context)
                                    });
                          }
                        })
                ],
              )),
        ),
      ),
    );
  }
}
