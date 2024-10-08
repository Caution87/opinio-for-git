import 'package:flutter/material.dart';
import 'package:opinio/pages/login_page.dart';
import 'package:opinio/pages/signin_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage = true;
  //toggle between login and register(signin)
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(onTap: togglePages);
    }
    else{
      return SigninPage(onTap: togglePages);
    }
  }
}
