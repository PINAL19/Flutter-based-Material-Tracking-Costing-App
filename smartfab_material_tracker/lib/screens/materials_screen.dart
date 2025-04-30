import 'package:flutter/material.dart';

class MaterialsScreen extends StatelessWidget {
  const MaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final materials = [
      {
        'id': '1',
        'name': 'Steel Sheet',
        'description': '1mm thick steel sheet',
        'unitType': 'kg',
        'currentStock': 100.0,
        'minimumStock': 50.0,
        'price': 2.5,
      },
      {
        'id': '2',
        'name': 'Aluminum Bar',
        'description': '20mm diameter aluminum bar',
        'unitType': 'm',
        'currentStock': 200.0,
        'minimumStock': 100.0,
        'price': 5.0,
      },
      {
        'id': '3',
        'name': 'Copper Wire',
        'description': '2mm diameter copper wire',
        'unitType': 'm',
        'currentStock': 500.0,
        'minimumStock': 200.0,
        'price': 1.5,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Materials'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/material-form'),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: materials.length,
        itemBuilder: (context, index) {
          final material = materials[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(material['name'] as String),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(material['description'] as String),
                  const SizedBox(height: 4),
                  Text(
                    'Stock: ${material['currentStock']} ${material['unitType']}',
                    style: TextStyle(
                      color: (material['currentStock'] as double) <=
                              (material['minimumStock'] as double)
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                ],
              ),
              trailing: Text(
                '\$${material['price']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onTap: () => Navigator.pushNamed(
                context,
                '/material-form',
                arguments: material,
              ),
            ),
          );
        },
      ),
    );
  }
} 