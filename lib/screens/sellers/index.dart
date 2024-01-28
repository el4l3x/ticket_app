import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/models/user.dart';
import 'package:ticket_app/models/user_firebase.dart';
import 'package:ticket_app/providers/users.dart';
import 'package:ticket_app/screens/layouts/appbar.dart';
import 'package:ticket_app/screens/layouts/generals.dart';
import 'package:ticket_app/screens/layouts/modals.dart';
import 'package:ticket_app/services/user_service.dart';

class SellersScreen extends StatefulWidget {
  const SellersScreen({super.key});

  @override
  State<SellersScreen> createState() => _SellersScreenState();
}

class _SellersScreenState extends State<SellersScreen> {
  AppBarLayouts appBarLayouts = AppBarLayouts();
  GeneralsLayouts generalsLayouts = GeneralsLayouts();
  Modals modals = Modals();
  bool _loading = true;
  final User _sellersProvider = User();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _sellersProvider.addListener(() {
      setState(() {
        _loading = false;
      });
    });

    _sellersProvider.loadSellers();
  }

  @override
  Widget build(BuildContext context) {
    UserAuth userAuth = Provider.of<UserAuth>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vendedores',
        ),
        actions: [
          appBarLayouts.logoutButton(context),
        ],
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _sellersProvider.sellers.length,
              itemBuilder: (BuildContext context, int index) {
                UserModel seller = _sellersProvider.sellers[index];
                return Dismissible(
                  key: Key(seller.uid!),
                  confirmDismiss: (direction) async {
                    bool result = false;

                    result = await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => modals.confirmationModal(
                          'Esta seguro de Borrar al vendedor ${seller.nombre}?',
                          context),
                    );

                    return result;
                  },
                  onDismissed: (direction) async {
                    setState(() {
                      _loading = true;
                    });
                    await destroySeller(seller.uid!).then((value) => {
                          if (value['error'])
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(value['errorMessage'])))
                            }
                          else
                            {
                              _sellersProvider.loadSellers(),
                              setState(() {
                                _loading = false;
                              }),
                            }
                        });
                  },
                  background: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.delete,
                            color: Colors.blue,
                            size: MediaQuery.of(context).size.height * 0.07),
                        Text(
                          'Borrar',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.07),
                        )
                      ],
                    ),
                  ),
                  child: generalsLayouts.listItems(
                      context, seller.nombre!, seller.username!, seller.uid!, [
                    IconButton(
                        onPressed: () async {
                          await Navigator.pushNamed(
                              context, '/vendedores/editar',
                              arguments: {
                                'seller': seller,
                              });
                          _sellersProvider.loadSellers();
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        )),
                  ]),
                );
              }),
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(),
        onPressed: () async {
          await Navigator.pushNamed(context, '/vendedores/crear');
          _sellersProvider.loadSellers();
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar:
          generalsLayouts.footer(context, 1, userAuth.isAdmin!),
    );
  }
}
