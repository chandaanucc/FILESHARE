import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool isPassword;
  final String? Function(String?) validator;
  final void Function(String?) onSaved;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.isPassword = false,
    required this.validator,
    required this.onSaved,
    this.controller,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
      obscureText: isPassword,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
