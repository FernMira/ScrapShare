import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeDeveloperPage extends StatefulWidget {
  const RecipeDeveloperPage({super.key});

  @override
  _RecipeDeveloperPageState createState() => _RecipeDeveloperPageState();
}

class _RecipeDeveloperPageState extends State<RecipeDeveloperPage> {
  final _recipeController = TextEditingController();
  final _ingredientController = TextEditingController();
  final List<Map<String, String>> _ingredients = [];
  bool _isLoading = false;

  Future<void> _submitRecipe() async {
    setState(() {
      _isLoading = true;
    });

    // Prepare data to send to the API
    final recipeData = {
      'recipeName': _recipeController.text,
      'ingredients': _ingredients.map((ingredient) => ingredient['ingredient']).toList(),
    };

    // API call to submit recipe
    final response = await http.post(
      Uri.parse('https://your-api-endpoint.com/recipes'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(recipeData),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe submitted successfully!')),
      );
      setState(() {
        _recipeController.clear();
        _ingredients.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit recipe. Please try again.')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Developer'),
        backgroundColor: const Color(0xFFB6D7A8), // Pastel green
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create a New Recipe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _recipeController,
              decoration: const InputDecoration(
                labelText: 'Recipe Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ingredients',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ..._ingredients.map((ingredient) => ListTile(
                  title: Text(ingredient['ingredient']!),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _ingredients.remove(ingredient);
                      });
                    },
                  ),
                )),
            const SizedBox(height: 10),
            TextField(
              controller: _ingredientController,
              decoration: const InputDecoration(
                labelText: 'Add Ingredient',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_ingredientController.text.isNotEmpty) {
                  setState(() {
                    _ingredients.add({'ingredient': _ingredientController.text});
                  });
                  _ingredientController.clear();
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFB6D7A8)),
              child: const Text('Add Ingredient'),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              ElevatedButton(
                onPressed: _submitRecipe,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFB6D7A8)),
                child: const Text('Submit Recipe'),
              ),
          ],
        ),
      ),
    );
  }
}
