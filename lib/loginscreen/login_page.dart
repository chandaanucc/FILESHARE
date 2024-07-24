// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   Future<void> _login() async {
//   final response = await http.post(
//     Uri.parse('http://localhost:5036/api/Login/login'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'Username': _usernameController.text,
//       'Password': _passwordController.text,
//     }),
//   );

//   if (response.statusCode == 200) {
//     final responseData = jsonDecode(response.body);
//     final role = responseData['role'];
//     final message = responseData['message'];

//     if (role == 'Admin') {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(message)),
//       );
//       Navigator.pushReplacementNamed(context, '/homeScreen1');
//     } else if (role == 'Associate') {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(message)),
//       );
//       Navigator.pushReplacementNamed(context, '/splashScreen');
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Unknown Role')),
//       );
//     }
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Login Failed')),
//     );
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _login,
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/dashboard/AdminHomeScreen.dart';
import 'dart:convert';

import 'package:share_plus/signupscreen/signup.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../utils/global_var.dart' as globals;

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

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      setState(() {
        _isLoading = true;
      });

      final response = await http.post(
         //Uri.parse('http://localhost:5036/api/Login/login'),
        Uri.parse('http://10.0.2.2:5031/api/Login/login'),
        // Uri.parse('http://192.168.1.2:5036/api/Login/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'Username': _usernameController.text,
          'Password': _passwordController.text,
          'Role':'User',
        }),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        globals.username = _usernameController.text;
        print('Login Username: ${globals.username}');
        final responseData = jsonDecode(response.body);
        final role = responseData['role'];
        final message = responseData['message'];

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        

        if (role == 'Admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
            );
            print('Navigating as admin: ${globals.username}');
        } else if (role == 'Associate') {
          Navigator.pushReplacementNamed(context, '/AssociateHomeScreen');
          print("Navigating as Associate:${globals.username}");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Unknown Role')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Failed')),
        );
      }
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a username or email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: 'Enter your password',
                            isPassword: !_passwordVisible,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
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

