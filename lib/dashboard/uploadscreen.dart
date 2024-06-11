import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Uploads'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('uploads').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var document = snapshot.data!.docs[index];
                var data = document.data() as Map<String, dynamic>; // Cast to Map

                return InkWell(
                  onTap: () {
                    // Handle tap event
                  },
                  child: GridTile(
                    child: Image.network(
                      data['downloadUrl'] ?? '', // Accessing 'downloadUrl' field safely
                      fit: BoxFit.cover,
                    ),
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(
                        data['fileName'] ?? '', // Accessing 'fileName' field safely
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
