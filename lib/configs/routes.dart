import 'package:flutter_application_1/views/login.dart';
import 'package:flutter_application_1/views/maintenance.dart';
import 'package:flutter_application_1/views/signup.dart';
import 'package:flutter_application_1/views/cars.dart';
import 'package:flutter_application_1/views/addcarscreen.dart';
import 'package:flutter_application_1/views/addmaintenancescreen.dart';
import 'package:flutter_application_1/views/dashboard.dart';
import 'package:flutter_application_1/views/settings.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/views/homescreen.dart';
import 'package:flutter_application_1/views/profile.dart';

var routes = [
  GetPage(name: "/", page: () => const LoginScreen()),
  GetPage(name: "/signup", page: () => const SignUpPage()),
  GetPage(name: "/homescreen", page: () => const HomeScreen()),
  GetPage(
    name: "/settingsscreen",
    page: () {
      final args = Get.arguments as Map<String, dynamic>? ?? {};
      return SettingsScreen(userId: args['user_id'] ?? 0);
    },
  ),
  GetPage(
    name: "/profilescreen",
    page: () => ProfileScreen(user: Get.arguments ?? {}),
  ),
  GetPage(
    name: "/dashboard",
    page: () {
      final args = Get.arguments as Map<String, dynamic>? ?? {};
      return DashboardScreen(
        userId: args['user_id'] ?? 0,
        firstname: args['firstname'] ?? '',
      );
    },
  ),
  GetPage(
    name: "/maintenancescreen",
    page: () {
      final args = Get.arguments as Map<String, dynamic>? ?? {};
      return MaintenanceScreen(
        carId: args['car_id'] ?? 0,
        carName: args['car_name'] ?? '',
        carImage: args['car_image'] ?? '',
      );
    },
  ),
  GetPage(
    name: "/carsscreen",
    page: () {
      final args = Get.arguments;
      return CarsScreen(
        userId: args is int ? args : int.tryParse(args.toString()) ?? 0,
      );
    },
  ),
  GetPage(
    name: "/addcarscreen",
    page: () {
      final args = Get.arguments;
      return AddCarScreen(
        userId: args is int ? args : int.tryParse(args.toString()) ?? 0,
      );
    },
  ),
  GetPage(
    name: "/addmaintenancescreen",
    page: () {
      final args = Get.arguments as Map<String, dynamic>? ?? {};
      return AddMaintenanceScreen(
        carId: args['car_id'] ?? 0,
        carName: args['car_name'] ?? '',
      );
    },
  ),
];
