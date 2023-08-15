import 'package:final_term_food_delivery/screen/welcome_page.dart';
import 'package:final_term_food_delivery/screen/wiget/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loadding = false;
  RegExp regExp = RegExp(LoginPage.pattern);
  late UserCredential userCredential;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future loginAuth() async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: "No user found for that email.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: "Wrong password provided for that user.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        setState(() {
          loadding = false;
        });
      }
      setState(() {
        loadding = false;
      });
    }
  }

  void validation() {
    if ((email.text.trim().isEmpty || email.text.trim() == null) &&
        (password.text.trim().isEmpty || password.text.trim() == null)) {
      Fluttertoast.showToast(
        msg: "All fields are empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else if (email.text.trim().isEmpty || email.text.trim() == null) {
      Fluttertoast.showToast(
        msg: "Email is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else if (!regExp.hasMatch(email.text)) {
      Fluttertoast.showToast(
        msg: "Please enter a valid Email",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else if (password.text.trim().isEmpty || password.text.trim() == null) {
      Fluttertoast.showToast(
        msg: "Password is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      setState(() {
        loadding = true;
      });
      loginAuth();
    }
  }

  void navigateToWelcomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              WelcomePage()), // Thay WelcomePage() bằng trang bạn muốn chuyển hướng đến
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: navigateToWelcomePage,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 170),
              child: Text(
                "Login In",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextField(
                    hintText: 'Email',
                    icon: Icons.email,
                    color: Colors.redAccent,
                    obscureText: false,
                    controller: email,
                  ),
                  MyTextField(
                    hintText: 'Password',
                    icon: Icons.lock,
                    color: Colors.redAccent,
                    obscureText: true,
                    controller: password,
                  ),
                ],
              ),
            ),
            loadding
                ? CircularProgressIndicator()
                : Container(
                    height: 60,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: validation,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Khách hàng mới?",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  "Đăng ký ngay.",
                  style: TextStyle(color: Colors.red),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
