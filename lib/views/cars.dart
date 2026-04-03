import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cardetailsscreen.dart';

const String baseUrl = 'http://localhost/flutter_application_1';

class CarsScreen extends StatefulWidget {
  final int userId;
  const CarsScreen({super.key, required this.userId});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  List<dynamic> carsList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCars();
  }

  Future<void> fetchCars() async {
    setState(() => isLoading = true);
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get_cars.php?user_id=${widget.userId}'),
      );
      final data = jsonDecode(response.body);
      if (data['success'] == 1) {
        setState(() => carsList = data['data']);
      } else {
        setState(() => carsList = []);
      }
    } catch (e) {
      Get.snackbar('Error', 'Error loading cars: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> deleteCar(int carId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/delete_car.php?id=$carId'),
      );
      final data = jsonDecode(response.body);
      if (data['success'] == 1) {
        Get.snackbar('Deleted', 'Car deleted successfully');
        fetchCars();
      }
    } catch (e) {
      Get.snackbar('Error', 'Error deleting car: $e');
    }
  }

  void _navigateToAddCar() async {
    final result = await Get.toNamed('/addcarscreen', arguments: widget.userId);
    if (result == true) fetchCars();
  }

  void _navigateToDetails(dynamic car) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CarDetailsScreen(car: Map<String, dynamic>.from(car)),
      ),
    );
  }

  void _confirmDelete(int carId, String carName) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Car'),
        content: Text('Are you sure you want to delete $carName?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              deleteCar(carId);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cars'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _navigateToAddCar),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : carsList.isEmpty
          ? const Center(
              child: Text(
                'No cars added yet.\nTap + to add your first car.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : RefreshIndicator(
              onRefresh: fetchCars,
              child: ListView.builder(
                itemCount: carsList.length,
                itemBuilder: (context, index) {
                  final car = carsList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading:
                          car['image_path'] != null &&
                              car['image_path'].toString().isNotEmpty
                          ? Image.network(
                              '$baseUrl/${car['image_path']}',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.directions_car, size: 40),
                            )
                          : const Icon(Icons.directions_car, size: 40),
                      title: Text(
                        '${car['brand']} ${car['model']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${car['year']} • ${car['mileage']} km'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmDelete(
                          int.parse(car['id'].toString()),
                          '${car['brand']} ${car['model']}',
                        ),
                      ),
                      onTap: () => _navigateToDetails(car),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
