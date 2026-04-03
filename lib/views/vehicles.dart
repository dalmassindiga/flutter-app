import 'package:flutter/material.dart';
import '../models/car.dart';

class VehiclesScreen extends StatefulWidget {
  const VehiclesScreen({super.key});

  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  final List<Car> myVehicles = [
    Car(
      brand: "Toyota",
      model: "Supra",
      year: 2020,
      mileage: 15000,
      imagePath: "assets/images/toyota_supra.jpg",
    ),
    Car(
      brand: "Honda",
      model: "Civic Type R",
      year: 2021,
      mileage: 8000,
      imagePath: "assets/images/honda_civic.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Vehicles")),
      body: ListView.builder(
        itemCount: myVehicles.length,
        itemBuilder: (context, index) {
          final vehicle = myVehicles[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Image.asset(
                  vehicle.imagePath,
                  width: 100,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${vehicle.brand} ${vehicle.model}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text("Year: ${vehicle.year}"),
                    Text("Mileage: ${vehicle.mileage} km"),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
