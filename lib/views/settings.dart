import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = 'http://localhost/flutter_application_1';

class SettingsScreen extends StatefulWidget {
  final int userId;
  const SettingsScreen({super.key, required this.userId});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Get.offAllNamed('/');
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showChangePassword() {
    final formKey = GlobalKey<FormState>();
    String newPassword = '';
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Change Password'),
          content: Form(
            key: formKey,
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
              validator: (val) => val!.length < 6
                  ? 'Password must be at least 6 characters'
                  : null,
              onSaved: (val) => newPassword = val!,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        setDialogState(() => isLoading = true);

                        try {
                          final response = await http.post(
                            Uri.parse('$baseUrl/update_profile.php'),
                            body: {
                              'id': widget.userId.toString(),
                              'password': newPassword,
                              'firstname': '',
                              'image': '',
                            },
                          );
                          final data = jsonDecode(response.body);
                          if (data['success'] == 1) {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            Get.snackbar(
                              'Success',
                              'Password changed successfully',
                            );
                          } else {
                            Get.snackbar('Error', 'Failed to change password');
                          }
                        } catch (e) {
                          Get.snackbar('Error', 'Something went wrong: $e');
                        } finally {
                          setDialogState(() => isLoading = false);
                        }
                      }
                    },
              child: isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Preferences section
          const Text(
            'Preferences',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Enable Notifications'),
                  value: notificationsEnabled,
                  onChanged: (val) {
                    setState(() => notificationsEnabled = val);
                    Get.snackbar(
                      'Notifications',
                      val ? 'Notifications enabled' : 'Notifications disabled',
                    );
                  },
                  secondary: const Icon(Icons.notifications),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  value: Get.isDarkMode,
                  onChanged: (val) {
                    Get.changeThemeMode(val ? ThemeMode.dark : ThemeMode.light);
                  },
                  secondary: const Icon(Icons.dark_mode),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Account section
          const Text(
            'Account',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('Change Password'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _showChangePassword,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About WrenchWise'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'WrenchWise',
                      applicationVersion: '1.0.0',
                      applicationIcon: Image.asset(
                        'assets/BM logo.jpg',
                        width: 50,
                        height: 50,
                      ),
                      children: const [Text('Car maintenance redefined.')],
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Logout
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: _confirmLogout,
            ),
          ),
        ],
      ),
    );
  }
}
