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
  List<Client> _filteredClients = [];
  Map<int, bool> _sharedStatus = {}; // To track share/unshare state
  String? _selectedRegion;
  final List<String> _regions = [

    'Kochi',
    'Delhi',
    'Pune',
    'KolKata',
    'Bangalore',
    'Mumbai',



    

  ];

  @override
  void initState() {
    super.initState();
    _fetchClients();
  }

  Future<void> _fetchClients() async {
    final url = 'http://10.0.2.2:5031/api/Clients/get-clients'; // Replace with your API endpoint

    try {
      final response = await http.get(Uri.parse(url));

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('Fetched Client Data: $data');
        setState(() {
          _clients = data.map((json) => Client.fromJson(json as Map<String, dynamic>)).toList();
          _filteredClients = _clients;
          _sharedStatus = {for (var client in _clients) client.id: false}; // Initialize share status
          final _regions = _clients.map((client) => client.region).toSet().where((region) => region != null).cast<String>().toList();
          print('Available Regions: $_regions');
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

  void _filterByRegion(String? region) async {
    setState(() {
      _selectedRegion = region;
    });

    print('Selected Region: $region');

    if (region == null || region.isEmpty) {
      setState(() {
        _filteredClients = _clients;
      });
      print('No region selected, displaying all clients');
    } else {
      // Construct URL with region in the path
      final url = 'http://10.0.2.2:5031/api/Clients/region/${Uri.encodeComponent(region)}';
      print('Fetching clients from URL: $url');
      
      final response = await http.get(Uri.parse(url));

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('Filtered Client Data: $data');
        final List<Client> clients = data.map((json) => Client.fromJson(json as Map<String, dynamic>)).toList();

        setState(() {
          _filteredClients = clients;
          print('Filtered Clients: $_filteredClients');
        });
      } else {
        print('Failed to load clients: ${response.statusCode}');
        setState(() {
          _filteredClients = [];
        });
      }
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
   // Replace with the actual PDF ID you want to share

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'ClientIds': [clientId],
          
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
          DropdownButton<String>(
            value: _selectedRegion,
            hint: const Text('Select Region', style: TextStyle(color: Colors.white)),
            dropdownColor: Colors.white,
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
                      itemCount: _filteredClients.length,
                      itemBuilder: (context, index) {
                        final client = _filteredClients[index];
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
