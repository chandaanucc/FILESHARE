// ignore_for_file: unused_field, library_private_types_in_public_api

import 'package:flutter/material.dart';
// import '../utils/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../loginscreen/login_page.dart';

class AdminSignupScreen extends StatefulWidget {
  const AdminSignupScreen({super.key});

  @override
  _AdminSignupScreenState createState() => _AdminSignupScreenState();
}

class _AdminSignupScreenState extends State<AdminSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _isLoading = false;

  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _role = 'Admin';

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _signup() {
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
          const SnackBar(content: Text('User created successfully!')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fix the errors in red before submitting.')),
      );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
            image: AssetImage(
                "assets/background/background.jpeg"), // Replace with your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/flags/homelogo.png", // Replace with your logo image
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            labelText: 'Username',
                            hintText: 'Enter your Username',
                            // validator: validateUsername,
                            onSaved: (value) {
                              _username = value ?? '';
                            },
                            labelStyle:
                                const TextStyle(color: Color(0xFF66FCF1)),
                            textStyle:
                                const TextStyle(color: Color(0xFF66FCF1)),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF66FCF1)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            labelText: 'Email',
                            hintText: 'Enter your Email',
                            // validator: validateEmail,
                            onSaved: (value) {
                              _email = value ?? '';
                            },
                            labelStyle:
                                const TextStyle(color: Color(0xFF66FCF1)),
                            textStyle:
                                const TextStyle(color: Color(0xFF66FCF1)),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF66FCF1)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: _passwordController,
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            isPassword: !_passwordVisible,
                            // validator: validatePassword,
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
                            labelStyle:
                                const TextStyle(color: Color(0xFF66FCF1)),
                            textStyle:
                                const TextStyle(color: Color(0xFF66FCF1)),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF66FCF1)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: _confirmPasswordController,
                            labelText: 'Confirm Password',
                            hintText: 'Confirm your password',
                            isPassword: !_passwordVisible,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please confirm your password';
                            //   }
                            //   if (value != _passwordController.text) {
                            //     return 'Passwords do not match';
                            //   }
                            //   return null;
                            // },
                            onSaved: (value) {
                              _confirmPassword = value ?? '';
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: const Color(0xFF66FCF1)),
                              onPressed: _togglePasswordVisibility,
                            ),
                            labelStyle:
                                const TextStyle(color: Color(0xFF66FCF1)),
                            textStyle:
                                const TextStyle(color: Color(0xFF66FCF1)),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF66FCF1)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: const Text(
                                    'Admin',
                                    style: TextStyle(color: Color(0xFF66FCF1)),
                                  ),
                                  leading: Radio<String>(
                                    value: 'Admin',
                                    groupValue: _role,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _role = value!;
                                      });
                                    },
                                    fillColor: MaterialStateColor.resolveWith(
                                        (states) => const Color(0xFF66FCF1)),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: const Text(
                                    'Associate',
                                    style: TextStyle(color: Color(0xFF66FCF1)),
                                  ),
                                  leading: Radio<String>(
                                    value: 'Associate',
                                    groupValue: _role,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _role = value!;
                                      });
                                    },
                                    fillColor: MaterialStateColor.resolveWith(
                                        (states) => const Color(0xFF66FCF1)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            text: 'Sign Up',
                            onPressed: _signup,
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
                                          const LoginScreen()),
                                );
                              },
                              child: const Text(
                                'Already a User? Login',
                                style: TextStyle(
                                  color: Color(0xFF66FCF1),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_isLoading)
                    const CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFF66FCF1)),
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
