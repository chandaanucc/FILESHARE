import 'dart:io' if (dart.library.html) 'dart:html';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// void main() {
//   runApp(MaterialApp(
//     title: 'PDF Upload and View',
//     theme: ThemeData(
//       primarySwatch: Colors.blue,
//     ),
//     home: UploadScreen(),
//   ));
// }

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
      Uint8List fileBytes = await result.files.first.bytes!;
      String fileName = result.files.first.name ?? '';

      setState(() {
        _pdfData = fileBytes;
        _fileName = fileName;
      });
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
        title: Text('PDF Upload and View'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _uploadPdf,
              child: Text('Select PDF'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _viewPdf,
              child: Text('View PDF'),
            ),
            SizedBox(height: 20),
            if (_fileName != null) // Display the file name if it's not null
              Text(
                'Selected File: $_fileName',
              ),
          ],
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