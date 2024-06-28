// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(MaterialApp(
//     title: 'Associates List',
//     theme: ThemeData(
//       primarySwatch: Colors.blue,
//     ),
//     home: AssociatesListScreen(),
//   ));
// }

// class Associate {
//   final int id;
//   final String username;
//   final String password;
//   final bool isAuthorized;

//   Associate({
//     required this.id,
//     required this.username,
//     required this.password,
//     required this.isAuthorized,
//   });

//   factory Associate.fromJson(Map<String, dynamic> json) {
//     return Associate(
//       id: json['id'],
//       username: json['username'],
//       password: json['password'],
//       isAuthorized: json['isAuthorized'],
//     );
//   }
// }

// class AssociatesListScreen extends StatefulWidget {
//   @override
//   _AssociatesListScreenState createState() => _AssociatesListScreenState();
// }

// class _AssociatesListScreenState extends State<AssociatesListScreen> {
//   late Future<List<Associate>> futureAssociates;
//   Set<int> selectedAssociates = {};

//   Future<List<Associate>> fetchAssociates() async {
//     final response = await http.get(Uri.parse('http://10.0.2.2:5031/api/Associate/all'));

//     if (response.statusCode == 200) {
//       print('Response body: ${response.body}'); // Debug statement
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse.map<Associate>((associate) => Associate.fromJson(associate)).toList();
//     } else {
//       print('Failed to load associates: ${response.statusCode}');
//       throw Exception('Failed to load associates');
//     }
//   }


//   void sharePDF(BuildContext context) {
//     print("Sharing PDF with associates: $selectedAssociates");
//     List<bool> isCheckedList = [true, false, false, true]; 

//     bool isAnySelected = isCheckedList.contains(true);

//     if (isAnySelected) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Shared PDF with selected associates!'),
//         duration: Duration(seconds: 2),
//       ),
//     );
//     }
//     else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('No associates selected!'),
//         duration: Duration(seconds: 2),
//       ),
        
//     );
//   }

    
//     // Implement your logic to share the PDF with the selected associates.
//     // For example, you could make an API call here.
//     // Example: http.post(url, body: jsonEncode({'associateIds': selectedAssociates.toList()}));

//     // For demonstration, we'll show a snackbar message

   
//   }

//   @override
//   void initState() {
//     super.initState();
//     futureAssociates = fetchAssociates();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xff66fcf1),
//         title: Text(
//           'Associates List',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/background/background.jpeg"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: FutureBuilder<List<Associate>>(
//           future: futureAssociates,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               List<Associate> associates = snapshot.data!;
//               return ListView.builder(
//                 itemCount: associates.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     color: Colors.black.withOpacity(0.7),
//                     margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
//                     child: ListTile(
//                       contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//                       leading: CircleAvatar(
//                         backgroundColor: Color(0xff66fcf1),
//                         child: Text(
//                           associates[index].username[0].toUpperCase(),
//                           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//                         ),
//                       ),
//                       title: Text(
//                         associates[index].username,
//                         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                       ),
//                       subtitle: Text(
//                         associates[index].isAuthorized ? '' : '',
//                         style: TextStyle(color: Colors.white70),
//                       ),
//                       trailing: Checkbox(
//                         value: selectedAssociates.contains(associates[index].id),
//                         onChanged: (bool? value) {
//                           setState(() {
//                             if (value == true) {
//                               selectedAssociates.add(associates[index].id);
//                             } else {
//                               selectedAssociates.remove(associates[index].id);
//                             }
//                           });
//                         },
//                         activeColor: Color(0xff66fcf1),
//                         checkColor: Colors.black,
//                       ),
//                     ),
//                   );
//                 },
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text(
//                   'Failed to load associates',
//                   style: TextStyle(color: Colors.red),
//                 ),
//               );
//             }

//             return Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//          onPressed: () => sharePDF(context),
//         // () {
//         //   print("Selected Associates: $selectedAssociates");
//         // },
//         child: Icon(Icons.share),
//         backgroundColor: Color(0xff66fcf1),
        
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    title: 'Associates List',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: AssociatesListScreen(),
  ));
}

class Associate {
  final int id;
  final String username;
  final String password;
  final bool isAuthorized;

  Associate({
    required this.id,
    required this.username,
    required this.password,
    required this.isAuthorized,
  });

  factory Associate.fromJson(Map<String, dynamic> json) {
    return Associate(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      isAuthorized: json['isAuthorized'],
    );
  }
}

class AssociatesListScreen extends StatefulWidget {
  @override
  _AssociatesListScreenState createState() => _AssociatesListScreenState();
}

class _AssociatesListScreenState extends State<AssociatesListScreen> {
  late Future<List<Associate>> futureAssociates;
  Set<int> selectedAssociates = {};

  Future<List<Associate>> fetchAssociates() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5031/api/Associate/all'));

    if (response.statusCode == 200) {
      print('Response body: ${response.body}'); // Debug statement
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map<Associate>((associate) => Associate.fromJson(associate)).toList();
    } else {
      print('Failed to load associates: ${response.statusCode}');
      throw Exception('Failed to load associates');
    }
  }

  void sharePDF(BuildContext context) {
    // Check if at least one checkbox is selected
    bool isAnySelected = selectedAssociates.isNotEmpty;

    if (isAnySelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Shared PDF with selected associates!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No associates selected!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    futureAssociates = fetchAssociates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff66fcf1),
        title: Text(
          'Associates List',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background/background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<Associate>>(
          future: futureAssociates,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Associate> associates = snapshot.data!;
              return ListView.builder(
                itemCount: associates.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.black.withOpacity(0.7),
                    margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                      leading: CircleAvatar(
                        backgroundColor: Color(0xff66fcf1),
                        child: Text(
                          associates[index].username[0].toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      title: Text(
                        associates[index].username,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      subtitle: Text(
                        associates[index].isAuthorized ? '' : '',
                        style: TextStyle(color: Colors.white70),
                      ),
                      trailing: Checkbox(
                        value: selectedAssociates.contains(associates[index].id),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              selectedAssociates.add(associates[index].id);
                            } else {
                              selectedAssociates.remove(associates[index].id);
                            }
                          });
                        },
                        activeColor: Color(0xff66fcf1),
                        checkColor: Colors.black,
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Failed to load associates',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: Container(
        width: 150,
        height:  50,
       
      
        margin: EdgeInsets.only(
          left: 0,
          right: 100
      
        ),
        child: FloatingActionButton(
          
          
          onPressed: () => sharePDF(context),
          child: Text("SHARE", style: TextStyle(fontWeight: FontWeight.bold,
          fontSize: 20,
          ),),

          
          backgroundColor: Color(0xff66fcf1),
          
        ),
      ),
      
    );
  
  }
}

