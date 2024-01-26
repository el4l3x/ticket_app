import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:ticket_app/models/event.dart';
import 'package:ticket_app/providers/events.dart';
import 'package:ticket_app/providers/users.dart';
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
  final User _sellersProvider = User();
  List _selectedSellers = [];
  List<String> sellersInit = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _sellersProvider.addListener(() {
      setState(() {
        loading = false;
      });
    });

    _sellersProvider.loadSellers();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final bool onEdit = arguments['edit'];
    final EventModel event =
        onEdit ? arguments['event'] : EventModel(uid: '', name: '');
    final Map initSellersMap = onEdit ? arguments['sellers'] : {};

    if (!_loadData && onEdit) {
      textName.text = event.name!;
      textTickets.text = event.tickets!;

      initSellersMap.forEach((key, value) {
        sellersInit.add(value);
      });

      _loadData = true;
    }

    final sellersSelect = _sellersProvider.sellers
        .map((seller) => MultiSelectItem(seller.uid, seller.nombre!))
        .toList();

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
                  MultiSelectBottomSheetField(
                    initialChildSize: 0.4,
                    listType: MultiSelectListType.CHIP,
                    searchable: true,
                    buttonText: const Text("Vendedores"),
                    title: const Text("Vendedores"),
                    cancelText: const Text('Cancelar'),
                    confirmText: const Text('Guardar'),
                    items: sellersSelect,
                    initialValue: sellersInit,
                    isDismissible: false,
                    onConfirm: (values) {
                      _selectedSellers = values;
                    },
                    chipDisplay: MultiSelectChipDisplay(
                      onTap: (value) {
                        setState(() {
                          _selectedSellers.remove(value);
                        });
                      },
                    ),
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
                                      event.uid!, _selectedSellers)
                                  .then((value) => Navigator.pop(context));
                            } else {
                              await storeEvent(textName.text, textTickets.text,
                                      _selectedSellers)
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
