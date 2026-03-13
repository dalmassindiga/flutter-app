import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: primaryColor,
        buttonBackgroundColor: secondaryColor,
        items: [
          Icon(Icons.dashboard, size: 30, color: Colors.white), // Dashboard
          Icon(Icons.category, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          if (index == 0) {
            Get.toNamed("/dashboard");
          } else if (index == 3) {
            Get.toNamed("/profile");
          }
        },
      ),
    );
  }
}
