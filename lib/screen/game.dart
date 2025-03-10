import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(const Game());
}

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'คณิตคิดไว',
      theme: ThemeData.dark(),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int digitCount = 2; // จำนวนหน่วยของตัวเลข
  int timeLimit = 10; // เวลาในการเล่น
  List<int> currentNumbers = [];
  int sum = 0;
  bool isGameStarted = false;
  bool isAnswerPhase = false;
  Timer? timer;
  int remainingTime = 10;
  final TextEditingController answerController = TextEditingController();
  String message = '';

  void startGame() {
    setState(() {
      isGameStarted = true;
      isAnswerPhase = false;
      remainingTime = timeLimit;
      message = '';
      sum = 0; // เริ่มต้นค่าผลรวมใหม่
      generateRandomNumbers(); // เรียกสุ่มเลขในวินาทีแรกทันที
      timer?.cancel();
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (remainingTime > 1) {
          setState(() {
            remainingTime--;
            generateRandomNumbers(); // สุ่มเลขใหม่ทุกวินาที
          });
        } else {
          endGame();
        }
      });
    });
  }

  void generateRandomNumbers() {
    int maxNumber = pow(10, digitCount).toInt() - 1;
    int minNumber = pow(10, digitCount - 1).toInt();
    int numberCount = Random().nextInt(3) + 1; // สุ่มจำนวนเลข (1-3 ตัวเลข)
    currentNumbers = List.generate(
      numberCount,
      (_) => Random().nextInt(maxNumber - minNumber + 1) + minNumber,
    );
    sum += currentNumbers.reduce(
      (a, b) => a + b,
    ); // สะสมผลรวมทุกครั้งที่เลขเปลี่ยน
  }

  void endGame() {
    setState(() {
      isGameStarted = false;
      isAnswerPhase = true;
      timer?.cancel();
    });
  }

  void checkAnswer() {
    if (int.tryParse(answerController.text) == sum) {
      setState(() {
        message = 'ถูกต้อง! คำตอบคือ $sum';
      });
    } else {
      setState(() {
        message = 'ผิด! คำตอบที่ถูกต้องคือ $sum';
      });
    }
    answerController.clear();
    resetGame();
  }

  void resetGame() {
    setState(() {
      isGameStarted = false;
      isAnswerPhase = false;
      currentNumbers.clear();
      sum = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isGameStarted || isAnswerPhase
          ? null
          : AppBar(
              title: const Text('คณิตคิดไว'),
              backgroundColor: Colors.blue,
              centerTitle: true,
              titleTextStyle: TextStyle(fontSize: 24),
            ),
      backgroundColor: isAnswerPhase || !isGameStarted ? Colors.white : Colors.black,
      body: Container(
        decoration: BoxDecoration(
          // ตรวจสอบว่าเป็นช่วงเกมเริ่มหรือไม่ ถ้าไม่ใช่ ให้แสดงภาพพื้นหลัง
          image: !isGameStarted && !isAnswerPhase || isAnswerPhase
              ? DecorationImage(
                  image: AssetImage('assets/image/16.jpg'), // ใส่ภาพพื้นหลังที่ต้องการ
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                )
              : null, // ถ้าเกมเริ่มไม่ให้ภาพพื้นหลังแทรก
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isGameStarted && !isAnswerPhase) ...[
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'จำนวนหน่วยของตัวเลข (1-3)',
                        labelStyle: const TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blue, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blue, width: 3),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        digitCount = int.tryParse(value) ?? 2;
                        digitCount = digitCount.clamp(1, 3);
                      },
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'เวลาที่กำหนด (วินาที)',
                        labelStyle: const TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blue, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blue, width: 3),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        timeLimit = int.tryParse(value) ?? 10;
                      },
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: startGame,
                      child: Container(
                        color: Colors.blue,
                        padding: const EdgeInsets.all(16.0),
                        child: const Text(
                          'เริ่มเกม',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (isGameStarted) ...[
              Text(
                currentNumbers.join(' + '),
                style: const TextStyle(
                  fontSize: 64,
                  color: Colors.white,
                ),
              ),
            ] else if (isAnswerPhase) ...[
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      '   กรอกคำตอบ  ',
                      style: TextStyle(fontSize: 32, color: Colors.red),
                    ),
                    TextField(
                      controller: answerController,
                      decoration: InputDecoration(
                        labelText: 'กรอกผลรวมที่ถูกต้อง',
                        labelStyle: const TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blue, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blue, width: 3),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: checkAnswer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('ส่งคำตอบ'),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(fontSize: 24, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
