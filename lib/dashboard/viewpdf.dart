import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_pdfview/flutter_pdfview.dart';


class PdfViewScreen extends StatelessWidget {
  final Uint8List pdfData;

  PdfViewScreen({required this.pdfData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 12, 7, 110),
        title: Text(
          'View PDF',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.yellow[800],
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.yellow[800],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: PDFView(
        filePath: null,
        pdfData: pdfData,
      ),
    );
  }
}