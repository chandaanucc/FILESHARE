import 'package:flutter/material.dart';
import 'package:share_plus/dashboard/AdminHomeScreen.dart';
import 'package:share_plus/dashboard/AssociateHomeScreen.dart';
import 'package:share_plus/loginscreen/login_page.dart';
import 'package:share_plus/splashscreen/splash_screen.dart';
  // Update with your actual file path

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenState(),
      routes: {
        '/AdminHomeScreen': (context) => AdminHomeScreen(),
        '/AssociateHomeScreen': (context) => AssociateHomeScreen(),
      },
    );
  }
}
