// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';


// Future<void> _uploadPdf() async {
//     if (_filePickerResult == null) {
//       // No file selected
//       return;
//     }

//     File file = File(_filePickerResult!.files.single.path!);
//     String fileName = _filePickerResult!.files.single.name;

//     // Create multipart request for POST
//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse('http://your_api_base_url/api/uploadfiles/upload'),
//     );

//     // Add file to multipart
//     request.files.add(await http.MultipartFile.fromPath(
//       'file',
//       file.path,
//       filename: fileName,
//     ));

//     // Send request
//     try {
//       var response = await request.send();
//       if (response.statusCode == 200) {
//         // Successful upload
//         var responseData = await response.stream.bytesToString();
//         print('File uploaded: $responseData');
//         // Handle success (e.g., show a success message)
//       } else {
//         // Error uploading
//         print('Error uploading file: ${response.reasonPhrase}');
//         // Handle error (e.g., show an error message)
//       }
//     } catch (e) {
//       print('Error uploading file: $e');
//       // Handle network or other errors
//     }
//   }