import 'package:flutter/material.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({super.key});

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}
class _MaintenanceScreenState extends State<MaintenanceScreen> {
  final maintenanceRecords = [
    {
      "car": "Toyota Supra",
      "service": "Oil Change",
      "date": "12 Mar 2026",
      "status": "Scheduled",
      "img": "assets/Toyota Supra.jpeg",
    },
    {
      "car": "Honda Civic Type R",
      "service": "Brake Inspection",
      "date": "10 Mar 2026",
      "status": "Completed",
      "img": "assets/Honda Civic Type R.jpeg",
    },
    {
      "car": "Subaru WRX STI",
      "service": "Tire Rotation",
      "date": "14 Mar 2026",
      "status": "In Progress",
      "img": "assets/Subaru wrx sti.jpeg",
    },
  ];

  int? expandedIndex;

  Color getStatusColor(String status) {
    if (status == "Completed") return Colors.green;
    if (status == "Scheduled") return Colors.orange;
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Maintenance Records")),
      body: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75, 
        ),
        itemCount: maintenanceRecords.length,
        itemBuilder: (context, i) {
          final record = maintenanceRecords[i];
          final expanded = expandedIndex == i;
          return GestureDetector(
            onTap: () => setState(() => expandedIndex = expanded ? null : i),
            child: Card(
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(record["img"]!),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record["car"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (expanded) ...[
                          const SizedBox(height: 5),
                          Text("Service: ${record["service"]}"),
                          Text("Date: ${record["date"]}"),
                        ],
                        const SizedBox(height: 5),
                        Text(
                          record["status"]!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: getStatusColor(record["status"]!),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
