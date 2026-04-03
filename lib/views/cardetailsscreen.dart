import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String baseUrl = 'http://localhost/flutter_application_1';

class CarDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> car;

  const CarDetailsScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final String carName = '${car['brand']} ${car['model']}';
    final String imagePath = car['image_path'] ?? '';

    return Scaffold(
      appBar: AppBar(title: Text(carName)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car image
            imagePath.isNotEmpty
                ? Image.network(
                    '$baseUrl/$imagePath',
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                    // ignore: unnecessary_underscores
                    errorBuilder: (_, __, ___) => Container(
                      width: double.infinity,
                      height: 220,
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.directions_car,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: 220,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.directions_car,
                      size: 80,
                      color: Colors.grey,
                    ),
                  ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    carName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _infoRow(
                    Icons.calendar_today,
                    "Year",
                    car['year'].toString(),
                  ),
                  const SizedBox(height: 8),
                  _infoRow(Icons.speed, "Mileage", "${car['mileage']} km"),
                  const SizedBox(height: 24),

                  // View maintenance button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.build),
                      label: const Text("View Maintenance Records"),
                      onPressed: () {
                        Get.toNamed(
                          '/maintenancescreen',
                          arguments: {
                            'car_id': int.tryParse(car['id'].toString()) ?? 0,
                            'car_name': carName,
                            'car_image': imagePath,
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          "$label: ",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
