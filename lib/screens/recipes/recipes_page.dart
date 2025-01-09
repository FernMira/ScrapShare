import 'package:flutter/material.dart';
import 'recipe_developer.dart'; // For "Create a Recipe"
import 'find_recipe_page.dart'; // For "Find a Recipe"

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipes"),
        backgroundColor: const Color(0xFFB6D7A8),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Recipes Section',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Choose an option below:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate to Recipe Developer page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecipeDeveloperPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB6D7A8),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: const Text("Create a Recipe"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Recipe Finder page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FindRecipePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB6D7A8),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: const Text("Find a Recipe"),
            ),
          ],
        ),
      ),
    );
  }
}
