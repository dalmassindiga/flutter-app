import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/views/profile.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/views/maintenance.dart';
import 'package:flutter_application_1/views/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final dashboardContent = const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Dashboard",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text("Car Status"),
        SizedBox(height: 10),
        Text("Upcoming Services: Oil Change, Tire Rotation"),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    final pages = [
      dashboardContent,
      const Center(child: Text("Expenses Content")),
      const Center(child: Text("Profile Content")),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: primaryColor,
        buttonBackgroundColor: secondaryColor,
        color: Colors.white,
        height: 60,
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.build, size: 30),
          Icon(Icons.attach_money, size: 30),
          Icon(Icons.settings, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            if (index == 0) {
              currentIndex = 0;
            } else if (index == 1)
              // ignore: curly_braces_in_flow_control_structures
              Get.to(() => const MaintenanceScreen());
            else if (index == 2)
              // ignore: curly_braces_in_flow_control_structures
              currentIndex = 1; // Expenses
            else if (index == 3)
              // ignore: curly_braces_in_flow_control_structures
              Get.to(
                () => const SettingsScreen(),
              ); // <-- Settings opens new screen
            else if (index == 4)
              // ignore: curly_braces_in_flow_control_structures
              Get.to(() => const ProfileScreen()); // Profile
          });
        },
      ),
    );
  }
}
