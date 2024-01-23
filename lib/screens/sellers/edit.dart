import 'package:flutter/material.dart';
import 'package:ticket_app/models/user.dart';
import 'package:ticket_app/screens/layouts/forms.dart';
import 'package:ticket_app/services/user_service.dart';

class EditSellerScreen extends StatefulWidget {
  const EditSellerScreen({super.key});

  @override
  State<EditSellerScreen> createState() => _EditSellerScreenState();
}

class _EditSellerScreenState extends State<EditSellerScreen> {
  final FormComponents formComponents = FormComponents();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController textName = TextEditingController();
  TextEditingController textUsername = TextEditingController();
  TextEditingController textPassword = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final UserModel seller = arguments['seller'];
    if (!loading) {
      textName.text = seller.nombre!;
      textUsername.text = seller.username!;
      textPassword.text = seller.password!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Vendedor'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.05,
            horizontal: MediaQuery.of(context).size.width * 0.1,
          ),
          child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: textName,
                    validator: (value) => value!.isEmpty
                        ? 'Ingrese un nombre para el vendedor'
                        : null,
                    decoration: formComponents.inputDecoration(
                        Icons.contact_phone, 'Nombre'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: textUsername,
                    validator: (value) => value!.isEmpty
                        ? 'Ingrese un nombre de usuario para el vendedor'
                        : null,
                    decoration: formComponents.inputDecoration(
                        Icons.account_circle, 'Usuario'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: textPassword,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => value!.isEmpty
                        ? 'Ingrese una clave para el vendedor'
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
                            await updateSeller(seller.uid!, textName.text,
                                    textUsername.text, textPassword.text)
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
