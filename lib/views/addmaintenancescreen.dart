import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

const String baseUrl = 'http://localhost/flutter_application_1';

class AddMaintenanceScreen extends StatefulWidget {
  final int carId;
  final String carName;
  const AddMaintenanceScreen({
    super.key,
    required this.carId,
    required this.carName,
  });

  @override
  State<AddMaintenanceScreen> createState() => _AddMaintenanceScreenState();
}

class _AddMaintenanceScreenState extends State<AddMaintenanceScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String service = "";
  String date = "";
  String status = "Scheduled";
  String notes = "";
  String cost = "0";

  final List<String> statusOptions = ["Scheduled", "In Progress", "Completed"];

  Future<void> _saveRecord() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => isLoading = true);

      try {
        final response = await http.post(
          Uri.parse('$baseUrl/add_maintenance.php'),
          body: {
            'car_id': widget.carId.toString(),
            'service': service,
            'date': date,
            'status': status,
            'notes': notes,
            'cost': cost,
          },
        );

        final data = jsonDecode(response.body);
        if (data['success'] == 1) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context, true);
        } else {
          Get.snackbar('Error', 'Failed to save record: ${data['error']}');
        }
      } catch (e) {
        Get.snackbar('Error', 'Something went wrong: $e');
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        // Format as YYYY-MM-DD for MySQL DATE column
        date =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Record — ${widget.carName}")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Service Type",
                    hintText: "e.g. Oil Change, Tire Rotation",
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Enter service type' : null,
                  onSaved: (val) => service = val!,
                ),
                const SizedBox(height: 12),

                GestureDetector(
                  onTap: _pickDate,
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Date",
                        hintText: date.isEmpty ? "Tap to select date" : date,
                        border: const OutlineInputBorder(),
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                      controller: TextEditingController(text: date),
                      validator: (val) => date.isEmpty ? 'Select a date' : null,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  initialValue: status,
                  decoration: const InputDecoration(
                    labelText: "Status",
                    border: OutlineInputBorder(),
                  ),
                  items: statusOptions.map((s) {
                    return DropdownMenuItem(value: s, child: Text(s));
                  }).toList(),
                  onChanged: (val) => setState(() => status = val!),
                ),
                const SizedBox(height: 12),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Notes (optional)",
                    hintText: "Any additional details",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  onSaved: (val) => notes = val ?? '',
                ),
                const SizedBox(height: 12),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Cost (optional)",
                    hintText: "e.g. 2500",
                    border: OutlineInputBorder(),
                    prefixText: 'KES ',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (val) => cost = val ?? '0',
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: _saveRecord,
                          child: const Text(
                            "Save Record",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
