import 'package:flutter/material.dart';

class GAMEMENU extends StatefulWidget {
  const GAMEMENU({super.key});

  @override
  State<GAMEMENU> createState() => _GAMEMENUState();
}

class _GAMEMENUState extends State<GAMEMENU> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Game Menu',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber.shade700,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/15.jpg'), // ใช้ภาพพื้นหลังเหมือนหน้า Home
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 20,
            color: Colors.white.withOpacity(0.9),
            shadowColor: Colors.black.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'เลือกเกมที่คุณต้องการเล่น',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade700,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'GAME1');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      shadowColor: Colors.blue.shade900,
                      elevation: 10,
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    child: const Text('เกมคณิตคิดไว'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'GAME2');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      shadowColor: Colors.green.shade900,
                      elevation: 10,
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    child: const Text('เกมตอบคำถาม'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
