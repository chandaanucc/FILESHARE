// ignore_for_file: library_private_types_in_public_api, unused_field

import 'package:flutter/material.dart';
import '../utils/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../utils/countries.dart';
import '../models/country.dart';

class AdminSignupScreen extends StatefulWidget {
  const AdminSignupScreen({super.key});

  @override
  _AdminSignupScreenState createState() => _AdminSignupScreenState();
}

class _AdminSignupScreenState extends State<AdminSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isEmailSignup = true;
  bool _passwordVisible = false;

  String _username = '';
  String _email = '';
  String _phoneNumber = '';
  Country? _selectedCountry;

  void _toggleSignupMethod(bool isEmailSignup) {
    setState(() {
      _isEmailSignup = isEmailSignup;
      _selectedCountry = null; // Clear selected country
      _phoneNumber = ''; // Clear phone number
      _email = ''; // Clear email
      _username = ''; // Clear username
      _passwordController.clear(); // Clear password
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _signup() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User created successfully!')),
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
      appBar: AppBar(title: Text('Admin Signup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              if (_isEmailSignup)
                CustomTextField(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  validator: validateEmail,
                  onSaved: (value) {
                    _email = value ?? '';
                  },
                )
              else
                Column(
                  children: [
                    DropdownButtonFormField<Country>(
                      decoration: const InputDecoration(
                        labelText: 'Country Code',
                        hintText: 'Select your country code',
                      ),
                      items: countries.map((Country country) {
                        return DropdownMenuItem<Country>(
                          value: country,
                          child: Row(
                            children: [
                              Image.asset(
                                country.flagPath,
                                width: 24,
                                height: 24,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 8),
                              Text('${country.name} (${country.code})'),
                            ],
                          ),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a country code';
                        }
                        return null;
                      },
                      onChanged: (Country? newValue) {
                        setState(() {
                          _selectedCountry = newValue;
                        });
                      },
                      onSaved: (value) {
                        _selectedCountry = value;
                      },
                    ),
                    CustomTextField(
                      labelText: 'Phone Number',
                      hintText: 'Enter your phone number',
                      validator: validatePhoneNumber,
                      onSaved: (value) {
                        _phoneNumber = value ?? '';
                      },
                    ),
                  ],
                ),
              CustomTextField(
                labelText: 'Username',
                hintText: 'Enter your username',
                validator: validateUsername,
                onSaved: (value) {
                  _username = value ?? '';
                },
              ),
              CustomTextField(
                controller: _passwordController,
                labelText: 'Password',
                hintText: 'Enter your password',
                isPassword: !_passwordVisible,
                validator: validatePassword,
                onSaved: (value) {
                  // This saves the password to a variable if needed
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
                text: 'Create Account',
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    _signup();
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.email),
                      label: const Text('Signup with Email'),
                      onPressed: () => _toggleSignupMethod(true),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.phone),
                      label: const Text('Signup with Phone'),
                      onPressed: () => _toggleSignupMethod(false),
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
