import 'package:flutter/material.dart';

class ProcessesScreen extends StatelessWidget {
  const ProcessesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final processes = [
      {
        'id': '1',
        'name': 'Cutting',
        'description': 'Cut steel sheets to size',
        'materials': [
          {'id': '1', 'quantity': 2.0},
        ],
        'overheadCost': 10.0,
        'profitMargin': 20.0,
      },
      {
        'id': '2',
        'name': 'Welding',
        'description': 'Weld steel components',
        'materials': [
          {'id': '1', 'quantity': 1.0},
          {'id': '3', 'quantity': 5.0},
        ],
        'overheadCost': 15.0,
        'profitMargin': 25.0,
      },
      {
        'id': '3',
        'name': 'Assembly',
        'description': 'Assemble final product',
        'materials': [
          {'id': '2', 'quantity': 3.0},
          {'id': '3', 'quantity': 2.0},
        ],
        'overheadCost': 20.0,
        'profitMargin': 30.0,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Processes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/process-form'),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: processes.length,
        itemBuilder: (context, index) {
          final process = processes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(process['name'] as String),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(process['description'] as String),
                  const SizedBox(height: 4),
                  Text(
                    'Materials: ${(process['materials'] as List).length}',
                    style: const TextStyle(color: Colors.blue),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Overhead: \$${process['overheadCost']}',
                    style: const TextStyle(color: Colors.orange),
                  ),
                ],
              ),
              trailing: Text(
                '${process['profitMargin']}%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
              onTap: () => Navigator.pushNamed(
                context,
                '/process-form',
                arguments: process,
              ),
            ),
          );
        },
      ),
    );
  }
} 