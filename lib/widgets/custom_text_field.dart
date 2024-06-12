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
    super.key,
    required this.labelText,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.onSaved,
    this.suffixIcon,
    this.prefixWidget, required TextStyle labelStyle, required TextStyle textStyle, required UnderlineInputBorder enabledBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: validator,
        onSaved: onSaved,
        style: const TextStyle(color: Color(0xFF66FCF1)), // Text color of the typed text
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: const TextStyle(color: Color(0xFF66FCF1)), // Label color
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF66FCF1)), // Border color
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixWidget,
        ),
      ),
    );
  }
}
