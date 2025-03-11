import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  String joke = "กดปุ่มด้านล่างเพื่อรับมุกตลก 😆";
  bool isLoading = false;

  Future<void> fetchJoke() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://v2.jokeapi.dev/joke/Any?type=single'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          joke = data['joke'] ?? "มุกตลกหายไปไหนก็ไม่รู้ 🤔";
        });
      } else {
        setState(() {
          joke = "ไม่สามารถโหลดมุกตลกได้ 😢";
        });
      }
    } catch (e) {
      setState(() {
        joke = "เกิดข้อผิดพลาดในการโหลดมุกตลก 😵";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'มุกตลกฮาๆ 🤣',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber.shade700,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/17.jpg'), // ใส่รูปภาพพื้นหลัง
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
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
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      joke,
                      key: ValueKey<String>(joke),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: isLoading ? null : fetchJoke,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      shadowColor: Colors.orange.shade900,
                      elevation: 10,
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(color: Colors.white),
                          )
                        : const Text("ขออีกมุก! 😆"),
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
