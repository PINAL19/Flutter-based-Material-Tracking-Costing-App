import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/process_provider.dart';
import '../providers/material_provider.dart';
import '../models/process_model.dart';

class ProcessFormScreen extends StatefulWidget {
  final Process? process;

  const ProcessFormScreen({super.key, this.process});

  @override
  State<ProcessFormScreen> createState() => _ProcessFormScreenState();
}

class _ProcessFormScreenState extends State<ProcessFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _laborCostController = TextEditingController();
  final _overheadCostController = TextEditingController();
  final _profitMarginController = TextEditingController();
  final _selectedMaterials = <String, double>{};

  @override
  void initState() {
    super.initState();
    if (widget.process != null) {
      _nameController.text = widget.process!.name;
      _descriptionController.text = widget.process!.description;
      _laborCostController.text = widget.process!.laborCost.toString();
      _overheadCostController.text = widget.process!.overheadCost.toString();
      _profitMarginController.text = widget.process!.profitMargin.toString();
      _selectedMaterials.addAll(widget.process!.materials);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _laborCostController.dispose();
    _overheadCostController.dispose();
    _profitMarginController.dispose();
    super.dispose();
  }

  Future<void> _saveProcess() async {
    if (!_formKey.currentState!.validate()) return;

    final processProvider = Provider.of<ProcessProvider>(context, listen: false);
    final process = Process(
      id: widget.process?.id ?? const Uuid().v4(),
      name: _nameController.text,
      description: _descriptionController.text,
      materials: _selectedMaterials,
      laborCost: double.parse(_laborCostController.text),
      overheadCost: double.parse(_overheadCostController.text),
      profitMargin: double.parse(_profitMarginController.text),
    );

    if (widget.process == null) {
      await processProvider.addProcess(process);
    } else {
      await processProvider.updateProcess(process);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.process == null ? 'Add Process' : 'Edit Process'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Process Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a process name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _laborCostController,
                decoration: const InputDecoration(labelText: 'Labor Cost'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter labor cost';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _overheadCostController,
                decoration: const InputDecoration(labelText: 'Overhead Cost'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter overhead cost';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _profitMarginController,
                decoration: const InputDecoration(labelText: 'Profit Margin (%)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter profit margin';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Materials Used',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Consumer<MaterialProvider>(
                builder: (context, materialProvider, _) {
                  return Column(
                    children: materialProvider.materials.map((material) {
                      final quantity = _selectedMaterials[material.id] ?? 0.0;
                      return Card(
                        child: ListTile(
                          title: Text(material.name),
                          subtitle: Text(
                            'Current Stock: ${material.currentStock} ${material.unitType}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (quantity > 0) {
                                      _selectedMaterials[material.id] = quantity - 1;
                                    }
                                  });
                                },
                              ),
                              Text(quantity.toString()),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    _selectedMaterials[material.id] = quantity + 1;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveProcess,
                child: const Text('Save Process'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 