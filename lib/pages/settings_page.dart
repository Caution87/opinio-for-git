// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opinio/components/settings_tile.dart';
import 'package:opinio/components/settings_tile_with_cupertino.dart';
import 'package:opinio/pages/home_page.dart';
import 'package:opinio/pages/login_page.dart';
import 'package:opinio/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => LoginPage(
                onTap: () {},
              )), // Navigate to login page
    );
    // Navigate to login screen or show a message
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: null,

        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Text(
          "S E T T I N G S",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // backgroundColor: Color.fromRGBO(32, 32, 32, 1),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SettingsTile(
                property: 'Logout',
                icon: Icon(Icons.logout),
                onTap: signUserOut),
            SettingsTile(
                property: 'Change Password',
                icon: Icon(Icons.password),
                onTap: () {}),
            SettingsTileWithCupertino(
              property: 'Light Mode',
              onTap: () {},
              cupertinoSwitch: CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context, listen: false)
                    .isLightMode,
                onChanged: (value) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme(),
              ),
            ),
            SettingsTile(
              property: 'Notifications',
              onTap: () {},
              icon: Icon(Icons.notification_important),
            ),
            SettingsTile(
                property: 'Help us improve',
                icon: Icon(Icons.info),
                onTap: () {}),
          ],
        ),
      ),
    );
  }
}
