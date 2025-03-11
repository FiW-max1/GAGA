import 'package:firebase_core/firebase_core.dart';
import 'package:firstweek/Home.dart';
import 'package:firstweek/firebase_options.dart';
import 'package:firstweek/screen/GAMEMENU.dart';
import 'package:firstweek/screen/api.dart';
import 'package:firstweek/screen/firebaseregister.dart';
import 'package:firstweek/screen/game.dart';
import 'package:firstweek/screen/menugame2.dart';
import 'package:firstweek/screen/user.dart';
import 'package:firstweek/screen/youtube.dart';
import 'package:flutter/material.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //เชื่อมกับ function home ที่ floder screen  =>>file home.dart
      home: Home(),
      routes: {
        'Registerfirebase' : (context) => Firebaseregister(),
        'GAMEMENU' : (context) => GAMEMENU(),
        'GAME2' : (context) => Game2(),
        'GAME1' : (context) => Game(),
        'User' : (context) => Users(),
        'Home' : (context) => Home(),
        'videoyoutube' : (context) => Videoyoutube(),
        'Api' : (context) => JokeScreen(),
        

      },
    );
  }
}
