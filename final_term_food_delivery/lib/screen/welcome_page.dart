import 'package:final_term_food_delivery/screen/signup_page.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  
  Widget button({
  required String name,
  Color? color,
  Color? textColor,
  required VoidCallback onPressed,
}) {
  return Container(
    height: 45,
    width: 300,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.redAccent, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        name,
        style: TextStyle(color: textColor),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Image.asset('images/logo.png'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Welcome To TAKFOOD",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  Column(
                    children: [
                      Text("Đặt món ăn nhanh chóng"),
                      Text("Thanh toán tiện lợi")
                    ],
                  ),
                  button(name: 'Login', color: Colors.redAccent,textColor: Colors.white, onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  }),
                  button(name: 'SignUp', color: Colors.white,textColor: Colors.redAccent, onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}