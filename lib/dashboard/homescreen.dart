import 'package:file_share_application/dashboard/uploadpdfscreen.dart';
import 'package:file_share_application/dashboard/uploadscreen.dart';
import 'package:file_share_application/dashboard/viewpdfscreen.dart';
import 'package:flutter/material.dart';


class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({Key? key}) : super(key: key);

  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  Map<String, bool> _isHovering = {
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
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 12, 7, 110),
        title: Text(
          'Share Plus',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.yellow[800],
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.menu, color: Colors.yellow[800]),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'Profile',
                child: MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _isHovering['Profile'] = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _isHovering['Profile'] = false;
                    });
                  },
                  child: Container(
                    color: _isHovering['Profile']! ? Colors.yellow : Colors.transparent,
                    child: Text('Profile'),
                  ),
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'My Uploads',
                child: MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _isHovering['My Uploads'] = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _isHovering['My Uploads'] = false;
                    });
                  },
                  child: Container(
                    color: _isHovering['My Uploads']! ? Colors.yellow : Colors.transparent,
                    child: Text('My Uploads'),
                  ),
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'Edit Pdf',
                child: MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _isHovering['Edit Pdf'] = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _isHovering['Edit Pdf'] = false;
                    });
                  },
                  child: Container(
                    color: _isHovering['Edit Pdf']! ? Colors.yellow : Colors.transparent,
                    child: Text('Edit Pdf'),
                  ),
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'Logout',
                child: MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _isHovering['Logout'] = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _isHovering['Logout'] = false;
                    });
                  },
                  child: Container(
                    color: _isHovering['Logout']! ? Colors.yellow : Colors.transparent,
                    child: Text('Logout'),
                  ),
                ),
              ),
            ],
            onSelected: (value) {
              // Handle menu item selection
              switch (value) {
                case 'Profile':
                  // Handle Profile tap
                  break;
                case 'My Uploads':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UploadScreen()),
                  );
                  break;
                case 'Edit Pdf':
                  // Handle Edit Pdf tap
                  break;
                case 'Logout':
                  // Handle Logout tap
                  break;
                default:
              }
            },
          ),
        ],
      ),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 12, 7, 110),
          image: DecorationImage(
            image: AssetImage('assets/value.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 350, // Adjusted height
              width: width,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 20,
                  right: 20,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 260, // Adjusted margin bottom
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '',
                          style: TextStyle(
                            color: Colors.yellow[800],
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: height * 0.5, // Adjusted height
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 5,
                  ),
                  padding: EdgeInsets.all(20),
                  itemCount: imageData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UploadPdfScreen()),
                          );
                        } else if (index == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ViewPdfScreen(pdfPath: 'path/to/pdf')),
                          );
                        } else if (index == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UploadScreen()),
                          );
                        }
                      },
                      child: Container(
                        height: 100,
                        width: 10,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 26, 6, 97),
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
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 10),
                            Text(
                              imageData[index],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.yellow[800],
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
