// // ignore_for_file: avoid_print, library_private_types_in_public_api, use_build_context_synchronously

// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/dashboard/shopownerscreen.dart';
//import 'package:share_plus/dashboard/uploadscreen.dart';
import 'package:share_plus/dashboard/viewpdf.dart';
import '../utils/global_var.dart' as globals;

class AssociateHomeScreen extends StatefulWidget {
  const AssociateHomeScreen({super.key});

  @override
  _AssociateHomeScreenState createState() => _AssociateHomeScreenState();
}

class _AssociateHomeScreenState extends State<AssociateHomeScreen> {


  Future<void> logout(BuildContext context) async {
    final url = Uri.parse(
        'http://10.0.2.2:5031/api/Login/logout'); // Use the correct logout API endpoint

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        globals.username = ''; // Clear global username
        Navigator.pushReplacementNamed(context, '/LoginScreen');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logout Successfully')),
        ); // Navigate to login screen after successful logout
        print('Username Logged Out:${globals.username}');
      } else {
        print('Logout failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  final List<String> images = [
    "assets/flags/plus.png",
    "assets/flags/plus.png"
  ];

  final List<String> imageData = [
    "View Pdf",
    " Clients "
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
                        top: 100, // Adjusted top padding for "ASSOCIATE" text
                        left: 30,
                        bottom: 50,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Row(
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
                          const Spacer(),
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
                                  color: const Color(0xFF66FCF1),
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
                                  MaterialPageRoute(
                                      builder: (context) => const ViewScreen()),
                                );
                              } 

                              else if (index == 1) {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ShopOwnerPage()),
                                );
                                // Call the dialog function directly
                              }
                            
                           
                            },
                            child: Container(
                              height: 250,
                              width: 10,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromARGB(255, 8, 4, 23),
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
                                    color: const Color(0xff45A29E),
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    imageData[index],
                                    style: const TextStyle(
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
            top: 25,
            right: 20,
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Color(0xFF66FCF1),
                  ),
                  onPressed: () => logout(context),
                ),
                const Text('Logout',
                    style: TextStyle(fontSize: 10, color: Color(0xFF66FCF1))),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
        
