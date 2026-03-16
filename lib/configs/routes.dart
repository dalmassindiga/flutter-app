import 'package:flutter_application_1/views/login.dart';
import 'package:flutter_application_1/views/maintenance.dart';
import 'package:flutter_application_1/views/signup.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/views/homescreen.dart';
import 'package:flutter_application_1/views/dashboard.dart';
import 'package:flutter_application_1/views/profile.dart';
import 'package:flutter_application_1/views/settings.dart';

var routes = [
  GetPage(name: "/", page: () => LoginScreen()),
  GetPage(name: "/signup", page: () => SignUpPage()),
  GetPage(name: "/homescreen", page: () => HomeScreen()),
  GetPage(name: "/dashboard", page: () => DashboardScreen()),
  GetPage(name: "/profilescreen", page: () => ProfileScreen()),
  GetPage(name: "/maintenancescreen", page: () => MaintenanceScreen()),
  GetPage(name: "/settingsscreen", page: () => SettingsScreen()),
];
