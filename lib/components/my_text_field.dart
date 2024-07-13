import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  const MyTextField({ super.key ,required this.obscureText,required this.hintText,required this.controller});


  @override
  Widget build(BuildContext context) {
    return const TextField();
  }
}
