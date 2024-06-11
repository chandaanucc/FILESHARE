import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: UploadPdfScreen()));
}

class UploadPdfScreen extends StatefulWidget {
  const UploadPdfScreen({Key? key}) : super(key: key);

  @override
  _UploadPdfScreenState createState() => _UploadPdfScreenState();
}

class _UploadPdfScreenState extends State<UploadPdfScreen> {
  double _uploadProgress = 0.0;
  bool _uploading = false;

  Future<void> _uploadPDF(BuildContext context) async {
    setState(() {
      _uploadProgress = 0.0;
      _uploading = true;
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File pickedFile = File(result.files.single.path!);
      String fileName = result.files.single.name;

      Reference ref = FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = ref.putFile(pickedFile);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        setState(() {
          _uploadProgress = progress;
        });
      });

      await uploadTask;
      String downloadUrl = await ref.getDownloadURL();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('PDF uploaded successfully!'),
      ));
      print('File upload completed successfully. Download URL: $downloadUrl');
    }

    setState(() {
      _uploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(500.0), // Define custom height for AppBar
        child: Stack(
          children: [
            AppBar(
              backgroundColor: Color.fromARGB(255, 12, 7, 110),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(''),
                ],
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back), color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Positioned(
              left:  200,
              bottom: 05,
              child: Container(
                color: Color.fromARGB(255, 12, 7, 110),
                child: ElevatedButton(
                  onPressed: _uploading ? null : () => _uploadPDF(context),
                  child: Text(
                    'Upload PDF',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow[800]!),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_uploading) ...[
              LinearProgressIndicator(
                value: _uploadProgress / 100,
                backgroundColor: Colors.yellow[800],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow[800]!),
              ),
              SizedBox(height: 20),
              Text(
                'Uploading PDF... ${_uploadProgress.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: Colors.yellow[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}