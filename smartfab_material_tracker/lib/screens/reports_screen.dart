import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final materialUsage = [
      {'name': 'Steel Sheet', 'quantity': 50.0},
      {'name': 'Aluminum Bar', 'quantity': 30.0},
      {'name': 'Copper Wire', 'quantity': 100.0},
    ];

    final processCosts = [
      {'name': 'Cutting', 'cost': 200.0},
      {'name': 'Welding', 'cost': 300.0},
      {'name': 'Assembly', 'cost': 400.0},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Material Usage',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries>[
                  ColumnSeries<Map<String, dynamic>, String>(
                    dataSource: materialUsage,
                    xValueMapper: (data, _) => data['name'] as String,
                    yValueMapper: (data, _) => data['quantity'] as double,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Process Costs',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: SfCircularChart(
                series: <CircularSeries>[
                  PieSeries<Map<String, dynamic>, String>(
                    dataSource: processCosts,
                    xValueMapper: (data, _) => data['name'] as String,
                    yValueMapper: (data, _) => data['cost'] as double,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
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