import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/addmaintenancescreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

const String baseUrl = 'http://localhost/flutter_application_1';

class MaintenanceScreen extends StatefulWidget {
  final int carId;
  final String carName;
  final String carImage;

  const MaintenanceScreen({
    super.key,
    required this.carId,
    required this.carName,
    required this.carImage,
  });

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  List<dynamic> records = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecords();
  }

  Future<void> fetchRecords() async {
    setState(() => isLoading = true);
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get_maintenance.php?car_id=${widget.carId}'),
      );
      final data = jsonDecode(response.body);
      if (data['success'] == 1) {
        setState(() => records = data['data']);
      } else {
        setState(() => records = []);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load records: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> deleteRecord(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/delete_maintenance.php?id=$id'),
      );
      final data = jsonDecode(response.body);
      if (data['success'] == 1) {
        Get.snackbar('Deleted', 'Record deleted successfully');
        fetchRecords();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete record: $e');
    }
  }

  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Record'),
        content: const Text('Are you sure you want to delete this record?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              deleteRecord(id);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Color getStatusColor(String status) {
    if (status == "Completed") return Colors.green;
    if (status == "Scheduled") return Colors.orange;
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carName),
        flexibleSpace: widget.carImage.isNotEmpty
            ? Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('$baseUrl/${widget.carImage}'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      // ignore: deprecated_member_use
                      Colors.black.withOpacity(0.4),
                      BlendMode.darken,
                    ),
                  ),
                ),
              )
            : null,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddMaintenanceScreen(
                carId: widget.carId,
                carName: widget.carName,
              ),
            ),
          );
          if (result == true) {
            await fetchRecords();
            Get.snackbar('Success', 'Maintenance record added');
          }
        },
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : records.isEmpty
          ? const Center(
              child: Text(
                'No maintenance records yet.\nTap + to add one.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : RefreshIndicator(
              onRefresh: fetchRecords,
              child: ListView.builder(
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final record = records[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: getStatusColor(
                          record['status'] ?? '',
                        // ignore: deprecated_member_use
                        ).withOpacity(0.15),
                        child: Icon(
                          Icons.build,
                          color: getStatusColor(record['status'] ?? ''),
                        ),
                      ),
                      title: Text(
                        record['service'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: ${record['date'] ?? ''}'),
                          if (record['notes'] != null &&
                              record['notes'].toString().isNotEmpty)
                            Text('Notes: ${record['notes']}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: getStatusColor(
                                record['status'] ?? '',
                              // ignore: deprecated_member_use
                              ).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              record['status'] ?? '',
                              style: TextStyle(
                                color: getStatusColor(record['status'] ?? ''),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _confirmDelete(
                              int.parse(record['id'].toString()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
