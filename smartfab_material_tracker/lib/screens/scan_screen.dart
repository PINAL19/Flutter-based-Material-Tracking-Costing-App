import 'package:flutter/material.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String? _scannedBarcode;
  bool _isLoading = false;

  // Mock materials data
  final _materials = [
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
  ];

  void _handleScan() {
    setState(() {
      _isLoading = true;
    });

    // Simulate scanning delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _scannedBarcode = '1234567890'; // Mock barcode
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Material'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_scannedBarcode != null) ...[
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
              const SizedBox(height: 16),
              Text(
                'Scanned: $_scannedBarcode',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: ListTile(
                  title: const Text('Material Found'),
                  subtitle: Text(
                    _materials.firstWhere(
                      (m) => m['id'] == _scannedBarcode,
                      orElse: () => {'name': 'Unknown'},
                    )['name'] as String,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _scannedBarcode = null;
                  });
                },
                child: const Text('Scan Again'),
              ),
            ] else ...[
              const Icon(
                Icons.qr_code_scanner,
                size: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              const Text(
                'Place the barcode within the frame',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _handleScan,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.camera_alt),
                label: Text(_isLoading ? 'Scanning...' : 'Start Scan'),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 