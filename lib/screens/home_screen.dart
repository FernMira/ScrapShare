import 'package:flutter/material.dart';
import 'grocery_page.dart';
import 'education_page.dart';
import 'social_media_page.dart';
import 'recipes/recipes_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scrap Share', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFB6D7A8), // Pastel green
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavigationButton(
              context,
              'Recipes',
              Icons.restaurant_menu,
              () => _navigateToPage(context, const RecipesPage()),
            ),
            const SizedBox(height: 20),
            _buildNavigationButton(
              context,
              'Education',
              Icons.school,
              () => _navigateToPage(context, const EducationPage()),
            ),
            const SizedBox(height: 20),
            _buildNavigationButton(
              context,
              'Grocery Organizer',
              Icons.shopping_cart,
              () => _navigateToPage(context, const GroceryPage()),
            ),
            const SizedBox(height: 20),
            _buildNavigationButton(
              context,
              'Social Media',
              Icons.group,
              () => _navigateToPage(context, const SocialMediaPage()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 28, color: Colors.white),
      label: Text(label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFB6D7A8), // Pastel green
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
