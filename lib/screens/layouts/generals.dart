import 'package:flutter/material.dart';
import 'package:ticket_app/models/user_firebase.dart';

class GeneralsLayouts {
  Container listItems(BuildContext context, String title, String leftSubtitle,
      String rightSubtitle, List<Widget> actions) {
    return Container(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.07,
          right: MediaQuery.of(context).size.width * 0.07,
          top: 15),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: const BorderDirectional(
              start: BorderSide(
            color: Colors.blue,
            width: 5,
          )),
          shape: BoxShape.rectangle,
          boxShadow: const [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              blurRadius: 1,
            )
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: actions),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(leftSubtitle), Text(rightSubtitle)],
          )
        ],
      ),
    );
  }

  BottomNavigationBar footer(
      BuildContext context, int currentIndex, UserAuth userAuth) {
    return BottomNavigationBar(
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: userAuth.isAdmin!
              ? const Icon(Icons.person_2_sharp)
              : const Icon(Icons.sell),
          label: userAuth.isAdmin! ? 'Vendedores' : 'Vender',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Eventos',
        ),
      ],
      currentIndex: currentIndex,
      onTap: (value) {
        switch (value) {
          case 0:
            Navigator.pushReplacementNamed(context, '/dashboard');
            break;
          case 1:
            if (userAuth.isAdmin!) {
              Navigator.pushNamed(context, '/vendedores');
            } else {
              Navigator.pushNamed(context, '/vender', arguments: {
                'userAuth': userAuth,
              });
            }
            break;
          case 2:
            if (userAuth.isAdmin!) {
              Navigator.pushNamed(context, '/eventos');
            } else {
              Navigator.pushNamed(context, '/eventos/asignados', arguments: {
                'userAuth': userAuth,
              });
            }
            break;
        }
      },
    );
  }
}
