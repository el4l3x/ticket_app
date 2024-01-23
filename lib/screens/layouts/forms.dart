import 'package:flutter/material.dart';

class FormComponents {
  InputDecoration inputDecoration(IconData? icon, String label) {
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

  TextButton buttonAction(String label, IconData? icon, Function action) {
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
}
