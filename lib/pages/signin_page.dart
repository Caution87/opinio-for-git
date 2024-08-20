import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:opinio/components/my_button.dart';
import 'package:opinio/components/my_text_field.dart';
import 'package:opinio/components/square_tile.dart';

class SigninPage extends StatefulWidget {
  final Function()? onTap;
  const SigninPage({super.key, required this.onTap});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final confirmPasswordController = TextEditingController();
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
    //make sure passwords match
    if (passwordController.text != confirmPasswordController.text) {
      //pop loading circle
      Navigator.pop(context);
      //show error to user
      displayMessage("Passwords don't match");
      return;
    }
    //try creting account
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      //show error to user
      displayMessage(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Don't Worry Container or Logo Container
            Container(
                color: Color.fromRGBO(32, 32, 32, 1),
                height: 320,
                width: screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Don't Worry You're",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 42,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Anonymous",
                        style: TextStyle(
                            color: Colors.white,
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
                GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    child: Center(
                        child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    )),
                    height: 40,
                    width: screenWidth / 2,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(20)),
                      color: Colors.black,
                    ),
                  ),
                ),
                //Signin button
                GestureDetector(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Center(
                              child: Text(
                            "Sign-in",
                            style: TextStyle(color: Colors.white),
                          )),
                          height: 40,
                          width: screenWidth / 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20)),
                              color: Color.fromRGBO(32, 32, 32, 1)),
                        ),
                        //Red Line
                        Container(
                          color: Colors.red,
                          height: 3,
                          width: 130,
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
            MyTextField(
                controller: confirmPasswordController,
                hintText: "Confirm Password",
                obscureText: true),
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
                    color: Colors.grey.shade700,
                  ),
                ),
                Text(
                  "Or Continue with",
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: Colors.grey.shade700,
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
