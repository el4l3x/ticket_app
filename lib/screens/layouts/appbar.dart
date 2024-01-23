import 'package:flutter/material.dart';

class AppBarLayouts {
  IconButton logoutButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        },
        icon: const Icon(
          Icons.logout_outlined,
        ));
  }
}
