import 'package:flutter/material.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Education"),
        backgroundColor: const Color(0xFFB6D7A8), // Pastel green
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome to the Education Page!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4F772D), // Dark green
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                "Here you can find educational resources, tips, and guides "
                "to help you learn more about reducing waste, sustainable living, "
                "and sharing resources effectively.",
                style: TextStyle(fontSize: 18, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Future: Add navigation to a specific topic or resource
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("More features coming soon!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB6D7A8), // Pastel green
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                ),
                child: const Text(
                  "Explore Topics",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
