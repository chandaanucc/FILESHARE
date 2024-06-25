// ignore_for_file: avoid_print

import 'package:flutter/material.dart'; // Add this import
import 'package:http/http.dart' as http;
import 'package:share_plus/dashboard/uploadscreen.dart';

class AssociateHomeScreen extends StatefulWidget {
  const AssociateHomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<AssociateHomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   disableScreenshots();
  // }

  // @override
  // void dispose() {
  //   enableScreenshots();
  //   super.dispose();
  // }

  // void disableScreenshots() async {
  //   await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  // }

  // void enableScreenshots() async {
  //   await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  // }

  Future<void> logout(BuildContext context) async {
    //final url = Uri.parse('http://10.0.2.2:5036/api/Login/logout'); // Use the correct logout API endpoint
    final url = Uri.parse('http://localhost:5036/api/Login/logout');

    try {
      final response = await http.post(url);

      if (response.statusCode == 302) {
        Navigator.pushReplacementNamed(context, '/LoginScreen');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logout Successfully')),
        ); // Navigate to login screen after successful logout
      } else {
        // Handle other status codes, if needed
        print('Logout failed with status code: ${response.statusCode}');
        // Show an error dialog or message to the user
      }
    } catch (e) {
      print('Error during logout: $e');
      // Handle network errors or exceptions
      // Show an error dialog or message to the user
    }
  }

  final List<String> images = [
    "assets/flags/plus.png",
  
  ];

  final List<String> imageData = [
   
    "View Pdf",

   
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background/background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  Container(
                    height: 400,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 70, // Adjusted top padding for "ADMIN" text
                        left: 30,
                        bottom: 100,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ASSOCIATE',
                                style: TextStyle(
                                  color: Color(0xff66fcf1),
                                  fontSize: 45,
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 0,
                              bottom: 15, // Slightly reduced bottom padding
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/flags/homelogo.png",
                                  color: Color(0xFF66FCF1),
                                  width: 140,
                                  height: 140,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: height * 0.7,
                      decoration: const BoxDecoration(
                        color: Color(0xffC5C6C7),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 30,
                        ),
                        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                        itemCount: imageData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (index == 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => UploadScreen()),
                                );
                            //   } else if (index == 1) {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(builder: (context) => UploadScreen()),
                            //     );
                            //   } else if (index == 2) {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(builder: (context) => AssoHomeScreen()),
                            //     );
                            //   }
                            // },
                              }
                            },
                            child: Container(
                              height: 250,
                              width: 10,
                              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromARGB(255, 8, 4, 23),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    images[index],
                                    width: 50,
                                    height: 50,
                                    color: Color(0xff45A29E),
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    imageData[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xffC5C6C7),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 30,
              right: 20,
              child: IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Color(0xFF66FCF1),
                ),
                onPressed: () => logout(context),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
//associateHomeScreen.dart