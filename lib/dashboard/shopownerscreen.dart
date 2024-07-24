
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/dashboard/clientalert.dart';

// Define the Client class
class Client {
  final int id;
  final String? clientName;
  final String? mail;
  final int? phone;
  final String? region;

  Client({
    required this.id,
    this.clientName,
    this.mail,
    this.phone,
    this.region,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      clientName: json['clientName'],
      mail: json['mail'],
      phone: json['phone'],
      region: json['region'],
    );
  }
}

// ShopOwnerPage Widget
class ShopOwnerPage extends StatefulWidget {
  const ShopOwnerPage({super.key});

  @override
  State<ShopOwnerPage> createState() => _ShopOwnerPageState();
}

class _ShopOwnerPageState extends State<ShopOwnerPage> {
  List<Client> _clients = [];
  Map<int, bool> _sharedStatus = {}; // To track share/unshare state

  @override
  void initState() {
    super.initState();
    _fetchClients();
  }

  Future<void> _fetchClients() async {
    final url = 'http://10.0.2.2:5031/api/Clients'; // Replace with your API endpoint

    try {
      final response = await http.get(Uri.parse(url));

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _clients = data.map((json) => Client.fromJson(json as Map<String, dynamic>)).toList();
          _sharedStatus = {for (var client in _clients) client.id: false}; // Initialize share status
        });
      } else {
        print('Failed to load clients, Status Code: ${response.statusCode}');
        throw Exception('Failed to load clients');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch clients: $e')),
      );
    }
  }

  Future<void> _showShareConfirmationDialog(int clientId) async {
    final client = _clients.firstWhere((client) => client.id == clientId);
    final isShared = _sharedStatus[clientId] ?? false;

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: const Color.fromARGB(255, 209, 246, 243),
          title: const Text('Share Confirmation'),
          content: Text('Do you want to share this with ${client.mail}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No', style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _shareWithClient(client.id); // Call the share function
              },
              child: const Text('Yes', style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _shareWithClient(int clientId) async {
    final url = 'http://10.0.2.2:5031/api/Mail/SendPdf'; // Replace with your API endpoint
    final pdfId = 1; // Replace with the actual PDF ID you want to share

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'ClientIds': [clientId],
          'PdfId': pdfId,
        }),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          _sharedStatus[clientId] = true; // Set the client as shared
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Shared successfully with the client.')),
        );
      } else {
        print('Failed to share, Status Code: ${response.statusCode}');
        throw Exception('Failed to share');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to share: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF66FCF1),
      appBar: AppBar(
        title: const Center(child: Text('Shop Owner Details')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.local_hospital),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const ShopOwnerDialog(),
              );
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: screenSize.width,
              height: screenSize.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background/background.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _clients.length,
                      itemBuilder: (context, index) {
                        final client = _clients[index];
                        final isShared = _sharedStatus[client.id] ?? false;

                        return Card(
                          color: Colors.black.withOpacity(0.7),
                          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFF66FCF1),
                            ),
                            title: Text(
                              client.clientName ?? 'No Name', 
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            subtitle: Text(client.mail ?? 'No Email', style: const TextStyle(color: Colors.white)),
                            trailing: ElevatedButton(
                              onPressed: () => _showShareConfirmationDialog(client.id),
                              child: Text(isShared ? 'Unshare' : 'Share'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: isShared ? Colors.red : Colors.green,  // text color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12), // rounded corners
                                ),
                                fixedSize: const Size(100, 40),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // padding
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

