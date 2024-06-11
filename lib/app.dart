import 'package:file_share_application/loginscreen/login_page.dart';
import 'package:file_share_application/signupscreen/signup_page.dart';
import 'package:file_share_application/splashscreen/splash_screen.dart';
import 'package:flutter/material.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Share App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
        '/splashscreen': (context) => const SplashScreenState(),
        '/signup': (context) => const SignupPage(),
        '/login': (context) => const LoginPage(),
      },
        home:  const Scaffold(
          body: Center( 
            child:SplashScreenState()
            )
              )
              );
  }
}


