import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecipeDetailsPage extends StatefulWidget {
  final int recipeId;

  const RecipeDetailsPage({super.key, required this.recipeId});

  @override
  _RecipeDetailsPageState createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  Map<String, dynamic>? _recipeDetails;
  bool _isLoading = true;

  final String apiKey = 'f6d94ea2c6634b87ada2d76008cee1c0'; // Replace with your Spoonacular API key

  @override
  void initState() {
    super.initState();
    _fetchRecipeDetails();
  }

  Future<void> _fetchRecipeDetails() async {
    final url = Uri.parse(
        'https://api.spoonacular.com/recipes/${widget.recipeId}/information?apiKey=$apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _recipeDetails = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        _showError('Failed to fetch recipe details.');
      }
    } catch (e) {
      _showError('An error occurred. Please try again.');
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe Details"),
        backgroundColor: const Color(0xFFB6D7A8),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _recipeDetails == null
              ? const Center(child: Text("No details available."))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Recipe Title
                        Text(
                          _recipeDetails!['title'] ?? 'No Title',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Recipe Image
                        if (_recipeDetails!['image'] != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              _recipeDetails!['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        const SizedBox(height: 20),

                        // Ingredients Section
                        const Text(
                          "Ingredients:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (_recipeDetails!['extendedIngredients'] != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              _recipeDetails!['extendedIngredients'].length,
                              (index) {
                                final ingredient =
                                    _recipeDetails!['extendedIngredients'][index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(
                                    "- ${ingredient['original']}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                );
                              },
                            ),
                          ),
                        const SizedBox(height: 20),

                        // Instructions Section
                        const Text(
                          "Steps:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (_recipeDetails!['analyzedInstructions'] != null &&
                            _recipeDetails!['analyzedInstructions'].isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              _recipeDetails!['analyzedInstructions'][0]['steps']
                                  .length,
                              (index) {
                                final step = _recipeDetails!['analyzedInstructions'][0]
                                    ['steps'][index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    "${index + 1}. ${step['step']}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                );
                              },
                            ),
                          )
                        else
                          const Text(
                            "No instructions provided.",
                            style: TextStyle(fontSize: 16),
                          ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
