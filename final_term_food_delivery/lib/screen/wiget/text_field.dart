import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget{
  final String hintText;
  final IconData icon;
  final Color? color;
  final bool obscureText;
  final TextEditingController controller;
  MyTextField({required this.hintText, required this.icon, this.color, required this.obscureText,required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: color),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}