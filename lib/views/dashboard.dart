import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;
  final List<Widget> pages = [
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Car Dashboard",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text("Car Status: Good"),
          SizedBox(height: 10),
          Text("Upcoming Services: Oil Change, Tire Rotation"),
        ],
      ),
    ),
    Center(child: Text("Service History Content")),
    Center(child: Text("Expenses Content")),
    Center(child: Text("Profile Content")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: primaryColor,
        buttonBackgroundColor: secondaryColor,
        color: Colors.white,
        height: 60,
        items: const <Widget>[
          Icon(Icons.directions_car, size: 30), // Dashboard
          Icon(Icons.build, size: 30), // Service History
          Icon(Icons.attach_money, size: 30), // Expenses
          Icon(Icons.person, size: 30), // Profile
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index; 
          });
        },
      ),
    );
  }
}
