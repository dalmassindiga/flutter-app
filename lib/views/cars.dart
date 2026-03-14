import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/car.dart';
import 'package:flutter_application_1/models/car_data.dart';
class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  List<Car> carsList = List.from(cars);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cars"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addCar, 
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: carsList.length,
        itemBuilder: (context, index) {
          final car = carsList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading: Image.asset(
                car.imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text("${car.brand} ${car.model}"),
              subtitle: Text("Year: ${car.year}, Mileage: ${car.mileage} km"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _removeCar(index),
              ),
              onTap: () {
                _showCarDetails(car);
              },
            ),
          );
        },
      ),
    );
  }
  void _addCar() {
    setState(() {
      carsList.add(
        Car(
          brand: "New Car",
          model: "Model X",
          year: 2023,
          mileage: 0,
          imagePath: "assets/images/toyota_supra.jpg",
        ),
      );
    });
  }
  void _removeCar(int index) {
    setState(() {
      carsList.removeAt(index);
    });
  }
  void _showCarDetails(Car car) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("${car.brand} ${car.model}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Year: ${car.year}"),
            Text("Mileage: ${car.mileage} km"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}
