// ignore_for_file: library_private_types_in_public_api

import 'package:share_plus/dashboard/uploadscreen.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/dashboard/viewpdf.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  final Map<String, bool> _isHovering = {
    'Profile': false,
    'My Uploads': false,
    'Edit Pdf': false,
    'Logout': false,
  };

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    List<String> images = [
      "assets/flags/plus.png",
      "assets/flags/view.png",
      "assets/flags/listfolder.png",
      "assets/flags/contacts.png",
    ];

    List<String> imageData = [
      "Upload Pdf",
      "View Pdf",
      "My Uploads",
      "Edit Pdf",
    ];

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
        child: Column(
          children: [
            Container(
              height: 400,
              width: width,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 90,
                  left: 120,
                  right: 10,
                  bottom: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'SHAREPLUS',
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
                        left: 20,
                        
                        bottom: 50,
                        
                        
                        ),
                      child: Row(
                        
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/flags/homelogo.png",
                            color:const Color(0xFF66FCF1),
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
                            MaterialPageRoute(builder: (context) => const UploadScreen()),
                          );
                        } else if (index == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>const ViewScreen()),
                          );
                        } else if (index == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen1()),
                          );
                        }
                      },
                      child: Container(
                        height: 250,
                        width: 10,
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
    );
  }
}