import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'recipe_details_page.dart';

class FindRecipePage extends StatefulWidget {
  const FindRecipePage({super.key});

  @override
  _FindRecipePageState createState() => _FindRecipePageState();
}

class _FindRecipePageState extends State<FindRecipePage> {
  final _ingredientController = TextEditingController();
  List<dynamic> _recipes = [];
  bool _isLoading = false;

  final String apiKey = 'f6d94ea2c6634b87ada2d76008cee1c0'; // Replace with your Spoonacular API key

  Future<void> _searchRecipes() async {
    final ingredients = _ingredientController.text.trim();
    if (ingredients.isEmpty) {
      _showError("Please enter ingredients to search.");
      return;
    }

    setState(() {
      _isLoading = true;
      _recipes = [];
    });

    final url = Uri.parse(
        'https://api.spoonacular.com/recipes/findByIngredients?ingredients=$ingredients&number=10&apiKey=$apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Debugging: Print API response
        print("API Response: $data");

        setState(() {
          _recipes = data;
          _isLoading = false;
        });
      } else {
        _showError("Failed to fetch recipes. Please try again.");
      }
    } catch (e) {
      _showError("An error occurred. Please try again.");
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    setState(() {
      _isLoading = false;
    });
  }

  void _viewRecipe(int recipeId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailsPage(recipeId: recipeId),
      ),
    );
  }

  String _getImageUrl(dynamic recipe) {
    if (recipe['image'] != null && recipe['image'].isNotEmpty) {
      return recipe['image'].toString();
    }
    // Use a default placeholder URL if image is missing
    return 'https://via.placeholder.com/150?text=No+Image';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find a Recipe"),
        backgroundColor: const Color(0xFFB6D7A8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _ingredientController,
              decoration: InputDecoration(
                labelText: "Enter ingredients (comma-separated)",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchRecipes,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _recipes.isEmpty
                    ? const Center(child: Text("No recipes found."))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: _recipes.length,
                          itemBuilder: (context, index) {
                            final recipe = _recipes[index];
                            final imageUrl = _getImageUrl(recipe);

                            // Debugging: Print recipe title and image URL
                            print("Recipe: ${recipe['title']}, Image URL: $imageUrl");

                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                leading: Image.network(
                                  imageUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset('assets/placeholder.png', width: 50, height: 50, fit: BoxFit.cover);
                                  },
                                ),
                                title: Text(recipe['title'] ?? "No Title"),
                                trailing: ElevatedButton(
                                  onPressed: () =>
                                      _viewRecipe(recipe['id']),
                                  child: const Text("View"),
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
