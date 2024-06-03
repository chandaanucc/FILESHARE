import 'package:file_share_application/signupscreen/signup_page.dart';
import 'package:flutter/material.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  const Scaffold(
          body: Center( 
            child:SignupPage()
            )
              )
              );
  }
}
