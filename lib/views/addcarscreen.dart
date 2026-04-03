import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = 'http://localhost/flutter_application_1';

class AddCarScreen extends StatefulWidget {
  final int userId;
  const AddCarScreen({super.key, required this.userId});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String brand = "";
  String model = "";
  String year = "";
  String mileage = "";

  Future<void> _saveCar() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => isLoading = true);

      try {
        final response = await http.post(
          Uri.parse('$baseUrl/add_car.php'),
          body: {
            'user_id': widget.userId.toString(),
            'brand': brand,
            'model': model,
            'year': year,
            'mileage': mileage,
            'image_path': '',
          },
        );

        final data = jsonDecode(response.body);
        if (data['success'] == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Car added successfully')),
          );
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Failed to add car')));
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Car")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Brand"),
                validator: (val) => val!.isEmpty ? 'Enter brand' : null,
                onSaved: (val) => brand = val!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Model"),
                validator: (val) => val!.isEmpty ? 'Enter model' : null,
                onSaved: (val) => model = val!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Year"),
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? 'Enter year' : null,
                onSaved: (val) => year = val!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Mileage"),
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? 'Enter mileage' : null,
                onSaved: (val) => mileage = val!,
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _saveCar,
                      child: const Text("Save Car"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
