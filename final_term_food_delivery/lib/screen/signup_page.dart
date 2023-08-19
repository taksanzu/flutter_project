import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_term_food_delivery/screen/login_page.dart';
import 'package:final_term_food_delivery/screen/wiget/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  static String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading=false;
  late UserCredential userCredential;
  RegExp regExp = RegExp(SignUp.pattern);
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future sendData() async {
  try {
    userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
    await FirebaseFirestore.instance.collection('userData').doc(userCredential.user!.uid).set({
      "firstName": firstName.text.trim(),
      "lastName": lastName.text.trim(),
      "email": email.text.trim(),
      "userid": userCredential.user!.uid,
      "password": password.text.trim(),
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
    Fluttertoast.showToast(
      msg: "Tạo tài khoản thành công",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      Fluttertoast.showToast(
        msg: "Mật khẩu quá yếu",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else if (e.code == 'email-already-in-use') {
      Fluttertoast.showToast(
        msg: "Email đã được sử dụng",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  } catch (e) {
    Fluttertoast.showToast(
      msg: e.toString(), // Hiển thị chi tiết lỗi
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
    setState(() {
      loading = false;
    });
  }
  setState(() {
    loading = false;
  });
}

  void validation() {
  if (firstName.text.trim().isEmpty || firstName.text.trim() == null) {
    Future.delayed(Duration(milliseconds: 100), () {
      Fluttertoast.showToast(
        msg: "Họ không được để trống",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
    });
    return;
  }
  if (lastName.text.trim().isEmpty || lastName.text.trim() == null) {
    Future.delayed(Duration(milliseconds: 100), () {
      Fluttertoast.showToast(
        msg: "Tên không được để trống",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
    });
    return;
  }
  if (email.text.trim().isEmpty || email.text.trim() == null) {
    Future.delayed(Duration(milliseconds: 100), () {
      Fluttertoast.showToast(
        msg: "Email không được để trống",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
    });
    return;
  }else if (!regExp.hasMatch(email.text)) {
    Future.delayed(Duration(milliseconds: 100), () {
      Fluttertoast.showToast(
        msg: "Email không hợp lệ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
    });
    return;
    }else if (password.text.trim().isEmpty || password.text.trim() == null) {
    Future.delayed(Duration(milliseconds: 100), () {
      Fluttertoast.showToast(
        msg: "Mật khẩu không được để trống",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
    });
    }else {
      setState(() {
        loading=true;
      });
      sendData();
    }
}

  Widget button({
    required String name,
    Color? color,
    Color? textColor,
    required VoidCallback ontap,
  }) {
    return Container(
      height: 60,
      width: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
          ),
        ),
        onPressed: ontap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 150),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextField(
                    hintText: 'First Name',
                    icon: Icons.person,
                    color: Colors.redAccent,
                    obscureText: false,
                    controller: firstName,
                  ),
                  MyTextField(
                    hintText: 'Last Name',
                    icon: Icons.person_2,
                    color: Colors.redAccent,
                    obscureText: false,
                    controller: lastName,
                  ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button(
                  name: "Cancel",
                  color: Colors.grey,
                  textColor: Colors.white,
                  ontap: () {},
                ),
            loading
                ? CircularProgressIndicator()
                : Container(
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: validation,
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
