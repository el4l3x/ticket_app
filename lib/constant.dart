import 'package:flutter/material.dart';

const baseURL = 'http://192.168.137.1:8000/api';
const loginURL = '$baseURL/iniciar';
const registerURL = '$baseURL/registro';
const logoutURL = '$baseURL/logout';
const getUserDataURL = '$baseURL/usuario';

const indexEventURL = '$baseURL/events';
const createEventURL = '$baseURL/events';
const updateEventURL = '$baseURL/events';

const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Algo salio mal, intenta de nuevo';

InputDecoration inputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(
      color: Colors.black45,
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black26,
        width: 1,
      )
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue,
        width: 1
      )
    ),
    floatingLabelStyle: const TextStyle(
      color: Colors.black
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    border: const OutlineInputBorder(
        borderSide: BorderSide(width: 5, color: Colors.black)),
  );
}

TextButton textButton(String label, Function onPressed) {
  return TextButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.blue),
        padding: MaterialStateProperty.resolveWith(
            (states) => const EdgeInsets.symmetric(vertical: 10)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ));
}

Row textAction(String text, String label, Function ontap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        '$text ',
      ),
      GestureDetector(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
        onTap: () => ontap,
      )
    ],
  );
}
