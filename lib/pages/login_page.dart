// ignore_for_file: unused_catch_clause, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:opinio/components/my_button.dart';
import 'package:opinio/components/my_text_field.dart';
import 'package:opinio/components/square_tile.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  void signUserIn() async {
    // Loading circle
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Popping the loading screen if there is no error
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Pop loading circle
      Navigator.pop(context);
      // Error message
      displayMessage(e.code);
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      //show error
      displayMessage(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Don't Worry Container or Logo Container
            Container(
                color: Theme.of(context).colorScheme.secondary,
                height: 320,
                width: screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      // ignore: prefer_const_constructors
                      child: Text(
                        "Don't Worry You're",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 42,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Anonymous",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 42,
                            fontWeight: FontWeight.w100),
                      ),
                    )
                  ],
                )),
            //Login and Signin Buttons
            Row(
              children: [
                //Login Button
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: 40,
                          width: screenWidth / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20)),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          child: Center(
                              child: Text(
                            "Login",
                            style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,),
                          )),
                        ),
                      ),
                      //Red Line
                      Container(
                        color: Colors.red,
                        height: 3,
                        width: 130,
                      )
                    ]),
                //Signin button
                GestureDetector(
                  onTap: widget.onTap,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: Theme.of(context).colorScheme.surface,
                          height: 40,
                          width: screenWidth / 2,
                          child: Center(
                              child: Text(
                            "Sign-in",
                            style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,),
                          )),
                        ),
                      ]),
                ),
              ],
            ),
            //For gap between TextField and Login button
            SizedBox(
              height: 40,
            ),
            //Email TextField
            MyTextField(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
            ),
            SizedBox(
              height: 20,
            ),
            //Password TextField
            MyTextField(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
            ),
            SizedBox(
              height: 20,
            ),
            //Forgot password
            Text(
              "Forgot Password?",
              style: TextStyle(
                  color: Color.fromRGBO(16, 245, 245, 1),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            //Login button
            MyButton(
              onTap: signUserIn,
            ),
            SizedBox(
              height: 15,
            ),
            //Or continue with
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  "Or Continue with",
                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,),
                ),
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            //Google and Apple
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareTile(imagePath: 'lib/Opinio_Images/google_PNG19635.png'),
                SizedBox(
                  width: 20,
                ),
                SquareTile(imagePath: 'lib/Opinio_Images/logo-apple-1536.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
