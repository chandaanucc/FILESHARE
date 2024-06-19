import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final Widget? suffixIcon;
  final Widget? prefixWidget;

  const CustomTextField({
    Key? key,
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
        style: const TextStyle(color: Color(0xFF66FCF1)), // Text color of the typed text
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFF66FCF1)), // Hint text color
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 194, 208, 207),width:1,strokeAlign : BorderSide.strokeAlignInside), // Border color
            gapPadding: 3,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixWidget,
        ),
      ),
    );
  }
}
