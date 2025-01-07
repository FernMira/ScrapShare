import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/api_constants.dart'; // Import API constants

class RecipeFinderPage extends StatefulWidget {
  const RecipeFinderPage({super.key});

  @override
  State<RecipeFinderPage> createState() => _RecipeFinderPageState();
}

class _RecipeFinderPageState extends State<RecipeFinderPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _recipes = [];
  bool _isLoading = false;

  Future<void> _searchRecipes(String query) async {
    setState(() {
      _isLoading = true;
    });

    final url =
        '${ApiConstants.baseUrl}/recipes/complexSearch?query=$query&number=10&apiKey=${ApiConstants.apiKey}';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _recipes = data['results'];
        });
      } else {
        throw Exception('Failed to load recipes');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Recipe'),
        backgroundColor: const Color(0xFFB6D7A8), // Pastel green
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search for a recipe',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _searchRecipes(value);
                }
              },
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: _recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = _recipes[index];
                        return Card(
                          child: ListTile(
                            title: Text(recipe['title']),
                            subtitle: Text('Ready in ${recipe['readyInMinutes']} mins'),
                            leading: recipe['image'] != null
                                ? Image.network(
                                    recipe['image'],
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.fastfood),
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
