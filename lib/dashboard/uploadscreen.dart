import 'dart:io' if (dart.library.html) 'dart:html';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(MaterialApp(
    title: 'PDF Upload and View',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: UploadScreen(),
  ));
}

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  Uint8List? _pdfData;
  String? _fileName;

  Future<void> _uploadPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;

      if (fileBytes != null) {
        setState(() {
          _pdfData = fileBytes;
          _fileName = fileName;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to read the file. Please try again.'),
          ),
        );
      }
    }
  }

  void _viewPdf() {
    if (_pdfData != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('PDF Viewer'),
          content: PDFViewer(pdfData: _pdfData!),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff66fcf1),
        title: Text('PDF Upload and View',
        
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,),
        
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background/background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                
                onPressed: _uploadPdf,
                child: Text('Select PDF'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xff66fcf1), backgroundColor: Colors.black, // Text color
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _viewPdf,
                child: Text('View PDF'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xff66fcf1), backgroundColor: Colors.black, // Text color
                ),
              ),
              SizedBox(height: 20),
              if (_fileName != null)
                Text(
                  'Selected File: $_fileName',
                  style: TextStyle(color: Color(0xff66fcf1)), // Text color for file name
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class PDFViewer extends StatelessWidget {
  final Uint8List pdfData;

  PDFViewer({required this.pdfData});

  @override
  Widget build(BuildContext context) {
    return PDFView(
      filePath: null,
      pdfData: pdfData,
    );
  }
}

// import 'dart:convert';
// import 'dart:io' if (dart.library.html) 'dart:html';
// import 'dart:typed_data';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

// void main() {
//   runApp(MaterialApp(
//     title: 'PDF Upload and View',
//     theme: ThemeData(
//       primarySwatch: Colors.blue,
//     ),
//     home: UploadScreen(),
//   ));
// }

// class UploadScreen extends StatefulWidget {
//   @override
//   _UploadScreenState createState() => _UploadScreenState();
// }

// class _UploadScreenState extends State<UploadScreen> {
//   Uint8List? _pdfData;
//   String? _fileName;

//   Future<void> _uploadPdf() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null) {
//       PlatformFile file = result.files.first;
//       Uint8List? fileBytes;
//       String fileName = file.name;

//       if (file.bytes != null) {
//         fileBytes = file.bytes;
//       } else if (file.path != null) {
//         fileBytes = await File(file.path!).readAsBytes();
//       }

//       if (fileBytes != null) {
//         setState(() {
//           _pdfData = fileBytes;
//           _fileName = fileName;
//         });
//         await _sendPdfToServer(fileBytes, fileName);
//       } else {
//         print('Failed to load file bytes');
//       }
//     }
  
//   }

//   Future<void> _sendPdfToServer(Uint8List fileBytes, String fileName) async {
//     try {
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse('http://localhost:5036/api/UploadFiles/upload'),
//       );

//       request.files.add(http.MultipartFile.fromBytes(
//         'file',
//         fileBytes,
//         filename: fileName,
//       ));

//       var response = await request.send();

//       if (response.statusCode == 200) {
//         print('File uploaded successfully');
//       } else {
//         print('Failed to upload file');
//       }
//     } catch (e) {
//       print('Error uploading file: $e');
//     }
//   }

//   void _viewPdf() {
//     if (_pdfData != null) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('PDF Viewer'),
//           content: PDFView(pdfData: _pdfData!),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Upload and View'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: _uploadPdf,
//               child: Text('Select PDF'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _viewPdf,
//               child: Text('View PDF'),
//             ),
//             SizedBox(height: 20),
//             if (_fileName != null) // Display the file name if it's not null
//               Text(
//                 'Selected File: $_fileName',
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


