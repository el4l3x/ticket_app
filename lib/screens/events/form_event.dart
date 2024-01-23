import 'package:flutter/material.dart';
import 'package:ticket_app/models/event.dart';
import 'package:ticket_app/providers/events.dart';
import 'package:ticket_app/screens/layouts/appbar.dart';
import 'package:ticket_app/screens/layouts/forms.dart';
import 'package:ticket_app/services/events_service.dart';

class FormEventScreen extends StatefulWidget {
  const FormEventScreen({super.key});

  @override
  State<FormEventScreen> createState() => _FormEventScreenState();
}

class _FormEventScreenState extends State<FormEventScreen> {
  final AppBarLayouts appBarLayouts = AppBarLayouts();
  final FormComponents formComponents = FormComponents();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController textName = TextEditingController();
  TextEditingController textTickets = TextEditingController();
  bool loading = false;
  bool _loadData = false;
  EventsProvider eventsProvider = EventsProvider();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final bool onEdit = arguments['edit'];
    final EventModel event =
        onEdit ? arguments['event'] : EventModel(uid: '', name: '');

    if (!_loadData && onEdit) {
      textName.text = event.name!;
      textTickets.text = event.tickets!;
      _loadData = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: onEdit
            ? Text(
                'Editar ${event.name}',
              )
            : const Text('Nuevo evento'),
        actions: [
          appBarLayouts.logoutButton(context),
        ],
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
                        ? 'Ingrese un nombre para el evento.'
                        : null,
                    decoration: formComponents.inputDecoration(
                        Icons.event_busy, 'Nombre'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: false,
                      signed: true,
                    ),
                    controller: textTickets,
                    validator: (val) => val!.isEmpty
                        ? 'Ingrese la cantidad de entradas para el evento.'
                        : null,
                    decoration: formComponents.inputDecoration(
                        Icons.card_giftcard, 'Entradas'),
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

                            if (onEdit) {
                              await updateEvent(textName.text, textTickets.text,
                                      event.uid!)
                                  .then((value) => Navigator.pop(context));
                            } else {
                              await storeEvent(textName.text, textTickets.text)
                                  .then((value) {
                                Navigator.pop(context);
                              });
                            }
                          }
                        })
                ],
              )),
        ),
      ),
    );
  }
}
