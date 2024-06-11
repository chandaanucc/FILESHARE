// ignore_for_file: camel_case_types

import 'package:file_share_application/signupscreen/signup_page.dart';
import 'package:flutter/material.dart';

class SplashScreenState extends StatefulWidget {
  const SplashScreenState({super.key});

  @override
  State<SplashScreenState> createState() => _splashScreenStateState();
}

class _splashScreenStateState extends State<SplashScreenState> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SignupPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromARGB(255, 39, 0, 156), Colors.white],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text('Welcome',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                )),
          ],
        ),
      ),
    );
  }
}
