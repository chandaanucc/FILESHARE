// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'signup_admin.dart';
import 'signup_associate.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Associate'),
            Tab(text: 'Admin'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const AssociateSignupScreen(),
          AdminSignupScreen(),
        ],
      ),
    );
  }
}
