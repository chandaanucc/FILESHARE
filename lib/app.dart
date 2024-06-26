import 'package:share_plus/dashboard/AdminHomeScreen.dart';
import 'package:share_plus/dashboard/AssociateHomeScreen.dart';
import 'package:share_plus/loginscreen/login_page.dart';
import 'package:share_plus/splashscreen/splash_screen.dart';
import 'package:flutter/material.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SharePlus',
        theme: ThemeData(
        ),
        home:  const Scaffold(
          body: Center( 
            child:SplashScreenState()
            )
              ),
              routes: {
        '/AdminHomeScreen': (context) => const AdminHomeScreen(),
        '/AssociateHomeScreen': (context) => const AssociateHomeScreen(),
        '/LoginScreen': (context) => const LoginScreen(),
      },
      );
  }
}


