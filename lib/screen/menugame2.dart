import 'package:firstweek/screen/game2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Game2 extends StatelessWidget {
  const Game2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'เกมทายคำวิทยาศาสตร์',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เลือกหมวดหมู่')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20),
        children: [
          _buildCategoryButton(context, '🐾 สัตว์', 'animals'),
          _buildCategoryButton(context, '🌿 พืช', 'plants'),
          _buildCategoryButton(context, '🌌 ดาราศาสตร์', 'astronomy'),
          _buildCategoryButton(context, '🌎 สิ่งแวดล้อม', 'environment'),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String title, String category) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameScreen2(category: category),
          ),
        );
      },
      child: Text(title),
    );
  }
}
