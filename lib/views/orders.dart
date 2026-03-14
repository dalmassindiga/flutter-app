import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final List<Map<String, dynamic>> orders = [
    {
      "car": "Toyota Supra",
      "service": "Oil Change",
      "date": "12 Mar 2026",
      "status": "Scheduled",
    },
    {
      "car": "Honda Civic Type R",
      "service": "Brake Inspection",
      "date": "10 Mar 2026",
      "status": "Completed",
    },
    {
      "car": "Subaru WRX STI",
      "service": "Tire Rotation",
      "date": "14 Mar 2026",
      "status": "In Progress",
    },
  ];

  int? expandedIndex; // Track which card is expanded

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Service Orders")),

      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          final isExpanded =
              expandedIndex == index; // check if this card is expanded

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: InkWell(
              onTap: () {
                setState(() {
                  // Toggle expansion
                  expandedIndex = isExpanded ? null : index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row: icon, car name, status
                    Row(
                      children: [
                        const Icon(Icons.build, size: 30),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            order["car"],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Status text with color
                        Text(
                          order["status"],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: order["status"] == "Completed"
                                ? Colors.green
                                : (order["status"] == "Scheduled"
                                      ? Colors.orange
                                      : Colors.blue),
                          ),
                        ),
                      ],
                    ),

                    // Expanded details
                    if (isExpanded) ...[
                      const SizedBox(height: 10),
                      Text("Service: ${order["service"]}"),
                      Text("Date: ${order["date"]}"),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
