// ignore_for_file: file_names
import 'package:flutter/material.dart';

//locals
import 'LoginPage.dart';
import 'RegisterPage.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  //initially show login page
  bool showLoginPage = true;
  //toggle between the login and the register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  void Function() getTogglePages() {
    return togglePages;
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
