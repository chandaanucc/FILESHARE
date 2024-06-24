// ignore_for_file: avoid_print, library_private_types_in_public_api, use_super_parameters
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewScreen extends StatefulWidget {
  final int fileId;

  const PdfViewScreen({Key? key, required this.fileId}) : super(key: key);

  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  String? localFilePath;
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _fetchPdf(widget.fileId);
  }

Future<void> _fetchPdf(int fileId) async {
  var url = Uri.parse('http://10.0.2.2:5036/api/ViewFiles/view/$fileId');

  
  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var bytes = response.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/Document.pdf');
      await file.writeAsBytes(bytes, flush: true);

      setState(() {
        localFilePath = file.path;
        isLoading = false;
      });
    } else {
      print('Failed to load PDF: ${response.statusCode}');
      setState(() {
        isLoading = false;
      });
    }
  } catch (e) {
    print('Error fetching PDF: $e');
    setState(() {
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View PDF'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : localFilePath != null
              ? PDFView(
                  filePath: localFilePath!,
                )
              : const Center(
                  child: Text('Failed to load PDF'),
                ),
    );
  }
}


class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View PDF',style: TextStyle( color:Colors.black)),
        backgroundColor: const Color(0xFF66FCF1),
        elevation: 0,
      ),
      body:Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background/background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
        child: ElevatedButton(
          onPressed: () {
            // Replace 1 with the actual file ID you want to fetch
            int fileId = 1; // Replace with your actual file ID
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfViewScreen(fileId: fileId),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:  const Color(0xFF66FCF1),
        ),
          child: const Text('View PDF', style: TextStyle( color:Colors.black)),
      ),
    ),),);
  }
}
