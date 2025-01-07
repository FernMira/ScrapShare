import 'package:flutter/material.dart';

class GroceryPage extends StatefulWidget {
  const GroceryPage({super.key});

  @override
  _GroceryPageState createState() => _GroceryPageState();
}

class _GroceryPageState extends State<GroceryPage> {
  final List<Map<String, dynamic>> _groceries = [];
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _expiryController = TextEditingController();

  void _addItem() {
    if (_nameController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty &&
        _expiryController.text.isNotEmpty) {
      setState(() {
        _groceries.add({
          'name': _nameController.text,
          'quantity': _quantityController.text,
          'expiry': _expiryController.text,
        });
        _nameController.clear();
        _quantityController.clear();
        _expiryController.clear();
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      _groceries.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grocery Organizer"),
        backgroundColor: const Color(0xFFB6D7A8), // Pastel green
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: "Name"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(labelText: "Quantity"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _expiryController,
                    decoration: const InputDecoration(labelText: "Expiry"),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green),
                  onPressed: _addItem,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _groceries.length,
                itemBuilder: (context, index) {
                  final grocery = _groceries[index];
                  return Card(
                    child: ListTile(
                      title: Text(grocery['name']),
                      subtitle: Text(
                          "Quantity: ${grocery['quantity']} | Expiry: ${grocery['expiry']}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeItem(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
