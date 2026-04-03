import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/views/profile.dart';
import 'package:flutter_application_1/views/cars.dart';
import 'package:flutter_application_1/views/settings.dart';
import 'package:flutter_application_1/views/dashboard.dart';
import 'package:flutter_application_1/views/expensesscreen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  late Map<String, dynamic> user;
  late int userId;

  @override
  void initState() {
    super.initState();
    user = Get.arguments ?? {};
    userId = int.tryParse(user['id'].toString()) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardScreen(userId: userId, firstname: user['firstname'] ?? 'User'),
      CarsScreen(userId: userId),
      ExpensesScreen(userId: userId),
      const SettingsScreen(),
      ProfileScreen(user: user),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: primaryColor,
        buttonBackgroundColor: secondaryColor,
        color: Colors.white,
        height: 60,
        index: currentIndex,
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.directions_car, size: 30),
          Icon(Icons.attach_money, size: 30),
          Icon(Icons.settings, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() => currentIndex = index);
        },
      ),
    );
  }
}
