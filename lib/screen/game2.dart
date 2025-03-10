import 'package:flutter/material.dart';
import 'dart:async';

final Map<String, List<Map<String, String>>> questionData = {
  'animals': [
    {'hint': 'สัตว์ที่มีงวงและตัวใหญ่', 'answer': 'ช้าง'},
    {'hint': 'สัตว์ที่วางไข่และร้อง "ก๊าบ ๆ"', 'answer': 'เป็ด'},
    {'hint': 'สัตว์เลี้ยงที่ชอบไล่จับหนู', 'answer': 'แมว'},
    {'hint': 'สัตว์ที่มีลายขาวดำ', 'answer': 'ม้าลาย'},
    {'hint': 'สัตว์ที่กินไผ่เป็นอาหารหลัก', 'answer': 'แพนด้า'},
  ],
  'plants': [
    {'hint': 'ต้นไม้ที่ให้ผลสีแดงและหวาน', 'answer': 'มะเขือเทศ'},
    {'hint': 'พืชที่มีหนามและเติบโตในทะเลทราย', 'answer': 'กระบองเพชร'},
    {'hint': 'ต้นไม้ที่มีใบสีเขียวและให้ร่มเงา', 'answer': 'ต้นไม้'},
    {'hint': 'พืชที่ให้ใบมีกลิ่นหอมใช้ปรุงอาหาร', 'answer': 'โหระพา'},
    {'hint': 'ผลไม้ที่มีเปลือกสีเหลืองและรสเปรี้ยว', 'answer': 'มะนาว'},
  ],
  'astronomy': [
    {'hint': 'ดาวฤกษ์ที่ให้แสงสว่างตอนกลางวัน', 'answer': 'ดวงอาทิตย์'},
    {'hint': 'วัตถุสว่างบนท้องฟ้ายามค่ำคืน', 'answer': 'ดวงจันทร์'},
    {'hint': 'กลุ่มดาวที่มองเห็นเป็นรูปสัตว์หรือสิ่งของ', 'answer': 'กลุ่มดาว'},
    {'hint': 'ดาวเคราะห์สีแดง', 'answer': 'ดาวอังคาร'},
    {'hint': 'ดาวเคราะห์ที่ใหญ่ที่สุดในระบบสุริยะ', 'answer': 'ดาวพฤหัสบดี'},
  ],
  'environment': [
    {'hint': 'ทรัพยากรที่ใช้ผลิตกระดาษ', 'answer': 'ต้นไม้'},
    {'hint': 'สิ่งที่เราหายใจเข้าไปเพื่อมีชีวิต', 'answer': 'อากาศ'},
    {'hint': 'น้ำที่มีรสเค็มและอยู่ในมหาสมุทร', 'answer': 'น้ำทะเล'},
    {'hint': 'พลังงานที่มาจากแสงอาทิตย์', 'answer': 'พลังงานแสงอาทิตย์'},
    {'hint': 'กระบวนการที่ต้นไม้สร้างอาหาร', 'answer': 'สังเคราะห์แสง'},
  ],
};

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'เกมทายคำวิทยาศาสตร์',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เลือกหมวดหมู่')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'เลือกหมวดหมู่ที่คุณต้องการเล่น!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                _buildCategoryButton(context, '🐾 สัตว์', 'animals'),
                _buildCategoryButton(context, '🌿 พืช', 'plants'),
                _buildCategoryButton(context, '🌌 ดาราศาสตร์', 'astronomy'),
                _buildCategoryButton(context, '🌎 สิ่งแวดล้อม', 'environment'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String title, String category) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GameScreen2(category: category)),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 28, color: Colors.white)),
          const SizedBox(height: 10),
          Text(
            category,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class GameScreen2 extends StatefulWidget {
  final String category;
  const GameScreen2({super.key, required this.category});

  @override
  _GameScreen2State createState() => _GameScreen2State();
}

class _GameScreen2State extends State<GameScreen2> {
  final TextEditingController _controller = TextEditingController();
  int _currentQuestion = 0;
  int _score = 0;
  String _feedback = '';

  late List<Map<String, String>> _questions;

  @override
  void initState() {
    super.initState();
    _questions = questionData[widget.category] ?? [];
  }

  void _checkAnswer() {
    if (_controller.text.trim() == _questions[_currentQuestion]['answer']) {
      setState(() {
        _feedback = '✅ ถูกต้อง!';
        _score += 10;
      });
      Future.delayed(Duration(seconds: 1), _nextQuestion);
    } else {
      setState(() {
        _feedback = '❌ ผิด! คำตอบที่ถูกต้องคือ: ${_questions[_currentQuestion]['answer']}';
      });
    }
  }

  void _nextQuestion() {
    setState(() {
      _controller.clear();
      _feedback = '';
      if (_currentQuestion < _questions.length - 1) {
        _currentQuestion++;
      } else {
        _showFinalScore();
      }
    });
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('จบเกม!'),
        content: Text('คุณได้คะแนน $_score คะแนน'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('ตกลง'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('หมวดหมู่: ${widget.category}')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/14.jpg'), // Add your background image here
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_questions[_currentQuestion]['hint']!, style: TextStyle(fontSize: 24, color: Colors.white)),
            SizedBox(height: 20),
            TextField(controller: _controller, decoration: InputDecoration(
              labelText: 'พิมพ์คำตอบที่นี่',
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(),
            )),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _checkAnswer, child: Text('ตรวจสอบคำตอบ')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _nextQuestion, child: Text('ข้ามคำถาม')),
            SizedBox(height: 20),
            Text(_feedback, style: TextStyle(fontSize: 20, color: _feedback.contains('✅') ? Colors.green : Colors.red)),
          ],
        ),
      ),
    );
  }
}