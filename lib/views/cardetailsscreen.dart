import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = 'http://localhost/flutter_application_1';

class CarDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> car;
  const CarDetailsScreen({super.key, required this.car});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  late Map<String, dynamic> car;

  @override
  void initState() {
    super.initState();
    car = Map<String, dynamic>.from(widget.car);
  }

  void _showEditDialog() {
    final formKey = GlobalKey<FormState>();
    final brandController = TextEditingController(text: car['brand']);
    final modelController = TextEditingController(text: car['model']);
    final yearController = TextEditingController(text: car['year'].toString());
    final mileageController = TextEditingController(
      text: car['mileage'].toString(),
    );
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Edit Car'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: brandController,
                    decoration: const InputDecoration(
                      labelText: 'Brand',
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) => val!.isEmpty ? 'Enter brand' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: modelController,
                    decoration: const InputDecoration(
                      labelText: 'Model',
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) => val!.isEmpty ? 'Enter model' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: yearController,
                    decoration: const InputDecoration(
                      labelText: 'Year',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) => val!.isEmpty ? 'Enter year' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: mileageController,
                    decoration: const InputDecoration(
                      labelText: 'Mileage (km)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) => val!.isEmpty ? 'Enter mileage' : null,
                  ),
                ],
              ),
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
                        setDialogState(() => isLoading = true);
                        try {
                          final response = await http.post(
                            Uri.parse('$baseUrl/update_car.php'),
                            body: {
                              'id': car['id'].toString(),
                              'brand': brandController.text.trim(),
                              'model': modelController.text.trim(),
                              'year': yearController.text.trim(),
                              'mileage': mileageController.text.trim(),
                            },
                          );
                          final data = jsonDecode(response.body);
                          if (data['success'] == 1) {
                            setState(() {
                              car['brand'] = brandController.text.trim();
                              car['model'] = modelController.text.trim();
                              car['year'] = yearController.text.trim();
                              car['mileage'] = mileageController.text.trim();
                            });
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            Get.snackbar('Success', 'Car updated successfully');
                          } else {
                            Get.snackbar(
                              'Error',
                              'Failed to update: ${data['error']}',
                            );
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

  @override
  Widget build(BuildContext context) {
    final String carName = '${car['brand']} ${car['model']}';
    final String imagePath = car['image_path'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(carName),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: _showEditDialog),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
}
