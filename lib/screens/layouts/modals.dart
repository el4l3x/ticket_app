import 'package:flutter/material.dart';

class Modals {
  AlertDialog confirmationModal(String question, BuildContext context) {
    return AlertDialog(
      title: Text(question),
      actions: [
        TextButton(
            onPressed: () {
              return Navigator.pop(context, false);
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.blue),
            )),
        TextButton(
            onPressed: () {
              return Navigator.pop(context, true);
            },
            child: const Text(
              'Si, estoy seguro.',
              style: TextStyle(color: Colors.red),
            ))
      ],
    );
  }
}
