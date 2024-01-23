import 'package:flutter/material.dart';
import 'package:ticket_app/constant.dart';
import 'package:ticket_app/models/api_response.dart';
import 'package:ticket_app/services/user_service.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  /* Future<void> _loadUserInfo(BuildContext context) async {
    String token = await getToken();

    if (token == '') {
      redirectLogin();
    } else {
      ApiResponse response = await getUserData();
      if (response.error == null) {
        redirectHome();
      } else if (response.error == unauthorized) {
        redirectLogin();
      } else {
        showError(response.error);
      }
    }
  } */

  void redirectLogin() {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  void redirectHome() {
    Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
  }

  void showError(String? error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error!)));
  }

  @override
  void initState() {
    // TODO: implement initState
    /* _loadUserInfo(context); */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
