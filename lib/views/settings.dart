import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text("Enable Notifications"),
            value: notificationsEnabled,
            onChanged: (val) {
              setState(() {
                notificationsEnabled = val;
              });
            },
            secondary: const Icon(Icons.notifications),
          ),
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: darkModeEnabled,
            onChanged: (val) {
              setState(() {
                darkModeEnabled = val;
              });
            },
            secondary: const Icon(Icons.dark_mode),
          ),

          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Change Password"),
            onTap: () {
              Get.snackbar("Change Password", "Go to login.");
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("App Info"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "WrenchWise",
                applicationVersion: "1.0",
                applicationIcon: Image.asset(
                  "assets/BM logo.jpg",
                  width: 50,
                  height: 50,
                ),
                children: [
                  const Text(
                    "maintenance redefined.",
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
