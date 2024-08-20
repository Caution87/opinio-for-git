import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:opinio/components/settings_tile.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
    void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    // Navigate to login screen or show a message
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          "S E T T I N G S",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SettingsTile(property: 'Change Password', icon: Icon(Icons.password),onTap:(){}),
          SettingsTile(property: 'Notifications', icon: Icon(Icons.notifications),onTap:(){}),
          SettingsTile(property: 'About', icon: Icon(Icons.info),onTap:(){}),
          SettingsTile(property: 'Light Mode', icon: Icon(Icons.light_mode),onTap:(){}),
          SettingsTile(property: 'Logout', icon: Icon(Icons.logout),onTap:signUserOut),
        ],
      ),
    );
  }
}
