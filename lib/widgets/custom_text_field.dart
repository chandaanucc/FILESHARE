import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final Widget? suffixIcon;
  final Widget? prefixWidget;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.onSaved,
    this.suffixIcon,
    this.prefixWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: validator,
        onSaved: onSaved,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          
          suffixIcon: suffixIcon,
          prefixIcon: prefixWidget,
        ),
      ),
    );
  }
}
