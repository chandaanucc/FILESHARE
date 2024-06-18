import 'package:share_plus/signupscreen/signup.dart';
import 'package:flutter/material.dart';

class SplashScreenState extends StatefulWidget {
  const SplashScreenState({super.key});

  @override
  State<SplashScreenState> createState() => _SplashScreenStateState();
}

class _SplashScreenStateState extends State<SplashScreenState> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay for splash screen, then navigate to signup screen
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminSignupScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/background.jpeg'),  // Replace with your image path
            fit: BoxFit.cover,
          ),
        
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Color(0xFF66FCF1)),
            SizedBox(height: 20),
            Text(
              'SHAREPLUS',
              style: TextStyle(
                color: Color(0xFF66FCF1),
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
