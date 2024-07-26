// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/dashboard/clientalert.dart';
import '../utils/global_var.dart' as globals;

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

class ShopOwnerPage extends StatefulWidget {
  const ShopOwnerPage({super.key});

  @override
  State<ShopOwnerPage> createState() => _ShopOwnerPageState();
}

class _ShopOwnerPageState extends State<ShopOwnerPage> {
  List<Client> _clients = [];
  List<Client> _filteredClients = [];
  Map<int, bool> _checkboxStatus = {}; // To track share/unshare state
  String? _selectedRegion;
   bool _isLoading = false;
  final List<String> _regions = [
    'Kochi',
    'Delhi',
    'Pune',
    'Kolkata',
    'Bangalore',
    'Mumbai',
  ];

  @override
  void initState() {
    super.initState();
    _fetchClients();
  }

  Future<void> _fetchClients() async {

    print('Region, ${globals.region}');
    final url = 'http://10.0.2.2:5031/api/Clients/region?region=${Uri.encodeComponent(globals.region)}'; // Replace with your API endpoint

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _clients = data.map((json) => Client.fromJson(json as Map<String, dynamic>)).toList();
          _filteredClients = _clients;
          _checkboxStatus = {for (var client in _clients) client.id: false};
        });
      } else {
        throw Exception('Failed to load clients');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch clients: $e')),
      );
    }
  }
    

  void _filterByRegion(String? region) async {

    setState(() {
      _selectedRegion = region;
    });

    if (region == null || region.isEmpty) {
      setState(() {
        _filteredClients = _clients;
      });
    } else {
      
      final url = 'http://10.0.2.2:5031/api/Clients/region?region=${Uri.encodeComponent(region)}';
      print('Fetching clients from URL: $url');
      
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Client> clients = data.map((json) => Client.fromJson(json as Map<String, dynamic>)).toList();

        setState(() {
          _filteredClients = clients;
        });
      }
      else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Client not found.')),
        );
        setState(() {
          _filteredClients = [];
        });
      }
      else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Client not found.')),
        );
        setState(() {
          _filteredClients = [];
        });
      } else {
        setState(() {
          _filteredClients = [];
        });
      }
    }
  }

  Future<void> _showShareConfirmationDialog(List<Client> clients) async {
    final clientCount = clients.length;
    final clientEmails = clients.map((client) => client.mail).whereType<String>().join(', ');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: const Color.fromARGB(255, 209, 246, 243),
          title: Text('Share Confirmation'),
          content: Text('Do you want to share the PDF with $clientCount client${clientCount > 1 ? 's' : ''}?'),
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
                _shareWithClients(clients); // Call the share function for the selected clients
              },
              child: const Text('Yes', style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _shareWithClients(List<Client> clients) async {
    final clientIds = clients.map((client) => client.id).toList();
    final url = 'http://10.0.2.2:5031/api/Mail/SendPdf';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'ClientIds': clientIds,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          for (var clientId in clientIds) {
            _checkboxStatus[clientId] = false; // Uncheck the selected clients
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Shared successfully with the clients.')),
        );
      }
       else {
        print('Failed to share, Status Code: ${response.statusCode}');
        throw Exception('Failed to share');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to share: $e')),
      );
    }
  }

  void _selectAllClients(bool selectAll) {
    setState(() {
      _checkboxStatus = {
        for (var client in _filteredClients)
          client.id: selectAll,
      };
    });
     
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF66FCF1),
      appBar: AppBar(
        title: const Text('Client Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          DropdownButton<String>(
            value: _selectedRegion,
            hint: const Center(child: Text('Region', style: TextStyle(color: Colors.black))),
            dropdownColor: const Color(0xFF66FCF1),
            items: _regions.map((String region) {
              return DropdownMenuItem<String>(
                value: region,
                child: Text(region, style: const TextStyle(color: Colors.black)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              _filterByRegion(newValue);
            },
            iconEnabledColor: Colors.grey,
          ),

          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context, 
                builder: (context) => const ShopOwnerDialog()
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
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _selectAllClients(true);
                      },
                      child: const Text('Select All'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _selectAllClients(false);
                      },
                      child: const Text('Deselect All'),
                    ),
                    if (_checkboxStatus.containsValue(true)) // Show Share button if any client is selected
                      ElevatedButton(
                        onPressed: () {
                          final selectedClients = _clients.where((client) => _checkboxStatus[client.id] ?? false).toList();
                          _showShareConfirmationDialog(selectedClients);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          'Share',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredClients.length,
                    itemBuilder: (context, index) {
                      final client = _filteredClients[index];
                      final isChecked = _checkboxStatus[client.id] ?? false;

                      return Card(
                        color: Colors.black.withOpacity(0.7),
                        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                        child: ListTile(
                          title: Text(
                            client.clientName ?? 'No Name',
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            client.mail ?? 'No Email',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _checkboxStatus[client.id] = value ?? false;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

