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
          primarySwatch: Colors.blue,
        ),
        home:  const Scaffold(
          body: Center( 
            child:SplashScreenState()
            )
              )
              );
  }
}


