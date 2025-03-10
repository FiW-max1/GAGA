import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Videoyoutube extends StatefulWidget {
  const Videoyoutube({super.key});

  @override
  State<Videoyoutube> createState() => _VideoyoutubeState();
}

class _VideoyoutubeState extends State<Videoyoutube> {
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'fXw1PERFGMs', // Example YouTube video ID
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("YouTube Player")),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
    );
  }
}
