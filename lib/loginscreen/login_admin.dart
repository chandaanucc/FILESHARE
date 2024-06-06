// ignore_for_file: library_private_types_in_public_api, unused_field

import 'package:flutter/material.dart';
import '../utils/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _isEmailLogin = true;

  String _email = '';
  String _phoneNumber = '';
  String _password = '';

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _toggleLoginMethod(bool isEmailLogin) {
    setState(() {
      _isEmailLogin = isEmailLogin;
      _email = '';
      _phoneNumber = '';
      _passwordController.clear();
    });
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged in successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in red before submitting.')),
      );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              if (_isEmailLogin)
                CustomTextField(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  validator: validateEmail,
                  onSaved: (value) {
                    _email = value ?? '';
                  },
                )
              else
                CustomTextField(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  validator: validatePhoneNumber,
                  onSaved: (value) {
                    _phoneNumber = value ?? '';
                  },
                ),
              CustomTextField(
                controller: _passwordController,
                labelText: 'Password',
                hintText: 'Enter your password',
                isPassword: !_passwordVisible,
                validator: validatePassword,
                onSaved: (value) {
                  _password = value ?? '';
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Login',
                onPressed: _login,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.email),
                      label: const Text('Login with Email'),
                      onPressed: () => _toggleLoginMethod(true),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.phone),
                      label: const Text('Login with Phone'),
                      onPressed: () => _toggleLoginMethod(false),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
