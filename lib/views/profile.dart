import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> user;
  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    String firstname = user['firstname'] ?? "No Name";
    String email = user['email'] ?? "No Email";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: primaryColor,
              child: Text(
                firstname.isNotEmpty ? firstname[0].toUpperCase() : "?",
                style: const TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              firstname,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              email,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
