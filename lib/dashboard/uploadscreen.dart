// ignore_for_file: avoid_print, library_private_types_in_public_api, use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../utils/global_var.dart' as  globals;

class FileUploadService {
  static const String baseUrl = 'http://10.0.2.2:5031/api/UploadFiles/upload'; // for emulators
  //static const String baseUrl = 'http://localhost:5036/api/UploadFiles/upload';
  // static const String baseUrl = 'http://192.168.1.2:5036/api/UploadFiles/upload'; // for phone

  Future<String?> uploadFile(PlatformFile file) async {
    if (file.bytes == null) {
      throw Exception("File bytes are null");
    }

    var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        file.bytes!,
        filename: file.name,
        contentType: MediaType('application', 'pdf'),
      ),
    );

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Upload successful');
        print('Upload Username, ${globals.username}');
        return response.body;
      } else {
        print('Upload failed with status code: ${response.statusCode}');
        throw Exception('Failed to upload file: ${response.body}');
      }
    } catch (e) {
      print('Exception during file upload: $e');
      rethrow; 
    }
  }
}

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  PlatformFile? _file;
  bool _isLoading = false;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _file = result.files.first;
      });

      // If the file is selected on mobile, manually read the file bytes
      if (!kIsWeb && _file!.bytes == null && _file!.path != null) {
        try {
          final file = File(_file!.path!);
          final fileBytes = await file.readAsBytes();
          setState(() {
            _file = PlatformFile(
              name: _file!.name,
              size: _file!.size,
              bytes: fileBytes,
              path: _file!.path,
              
            );
          });
        } catch (e) {
          print('Error reading file bytes: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error reading file bytes: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  Future<void> _uploadFile() async {
    if (_file != null) {
      setState(() {
        _isLoading = true;
      });
      FileUploadService uploadService = FileUploadService();
      try {
        String? response = await uploadService.uploadFile(_file!);
        print('Upload response: $response');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('File Upload successful'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        print('Error uploading file: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error uploading file'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file selected'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload PDF', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFF66FCF1),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background/background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _pickFile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF66FCF1),
                ),
                child: const Text('Pick PDF', style: TextStyle(color: Colors.black)),
              ),
              _file != null ? Text('Selected file: ${_file!.name}', style: const TextStyle(color: Color(0xFF66FCF1))) : Container(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadFile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF66FCF1),
                ),
                child: const Text('Upload PDF', style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF66FCF1)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
