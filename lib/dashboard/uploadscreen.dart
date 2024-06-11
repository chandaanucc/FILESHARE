import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(MaterialApp(
    title: 'Image Upload and View',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: UploadScreen(),
  ));
}

// class UploadScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
     
//       body: Container(
//         color: Color.fromARGB(255, 12, 7, 110),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => MyHomePage()),
//                   );
//                 },
//                 child: Text('Upload Image'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.yellow[800],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  Uint8List? _imageData;

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageData = await pickedFile.readAsBytes();
      setState(() {
        _imageData = imageData;
      });
    }
  }

  void _viewImage() {
  if (_imageData != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor:  Color.fromARGB(255, 12, 7, 110),
            title: Text('View Image',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow[800]), ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.yellow[800],),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
            
            body: Container(
              
              color: Color.fromARGB(255, 12, 7, 110),
              child: Center(
                
                child: kIsWeb
                    ? Image.memory(_imageData!)
                    : Image.memory(_imageData!),
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        color: Color.fromARGB(255, 12, 7, 110),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _uploadImage,
                child: Text('Select pdf'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[800],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _viewImage,
                child: Text('View pdf'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
