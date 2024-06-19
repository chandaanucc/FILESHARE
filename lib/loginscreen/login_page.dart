// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:share_plus/dashboard/homescreen.dart';
import 'package:share_plus/signupscreen/signup.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _isLoading = false;

  String _username = '';
  String _password = '';

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      setState(() {
        _isLoading = true;
      });

      // Simulate a delay for the loading indicator
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen1()),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors in red before submitting.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background/background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/flags/homelogo.png',
                    height: 100,
                    color: const Color(0xFF66FCF1),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _usernameController,
                            hintText: 'Enter your username or email',
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter a username or email';
                            //   }
                            //   return null;
                            // },
                            onSaved: (value) {
                              _username = value ?? '';
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: 'Enter your password',
                            isPassword: !_passwordVisible,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter a password';
                            //   }
                            //   return null;
                            // },
                            onSaved: (value) {
                              _password = value ?? '';
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color(0xFF66FCF1),
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            text: 'Login',
                            onPressed: _login,
                            color: const Color(0xFF1F2833),
                            textColor: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AdminSignupScreen()),
                                );
                              },
                              child: const Text(
                                'Don\'t have an account? Sign Up',
                                style: TextStyle(
                                  color: Color(0xFF66FCF1),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_isLoading)
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF66FCF1)),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
