import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Music extends StatefulWidget {
  const Music({super.key});

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playBackgroundMusic();
  }

  // ฟังก์ชั่นในการเล่นเพลงพื้นหลังจากไฟล์ MP3
  void _playBackgroundMusic() async {
    await _audioPlayer.setSource(AssetSource('assets/22.mp3'));  // ใส่เส้นทางของไฟล์ MP3 ใน assets
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);  // ตั้งให้เพลงเล่นวนลูป
    await _audioPlayer.resume();  // เริ่มเล่นเพลง
  }

  @override
  void dispose() {
    _audioPlayer.dispose();  // ปิดการใช้งานเมื่อไม่ต้องการเล่นเพลง
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Background Music")),
      body: const Center(
        child: Text("Enjoy the background music!"),
      ),
    );
  }
}
