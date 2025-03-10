// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:miniproject/Home.dart'; // Assuming Home.dart is a valid screen
// import 'package:miniproject/screen/game.dart'; // Assuming this is the game screen

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   final _email = TextEditingController();
//   final _password = TextEditingController();

//   Future<void> login() async {
//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: _email.text, password: _password.text)
//           .then((value) {
//         // Navigate to a different screen after successful login
//         MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => GameScreen());
//         Navigator.of(context).pushAndRemoveUntil(
//             materialPageRoute, (Route<dynamic> route) => false);  // Push game screen after login
//       }).catchError((onError) {
//         print(onError);
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('NTN & PTS'),
//         backgroundColor: Colors.amber,
//         centerTitle: true,
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: const Icon(Icons.menu),
//             onPressed: () {
//               Scaffold.of(context).openDrawer();
//             },
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.account_circle),
//             onPressed: () {
//               Navigator.pushNamed(context, 'User');
//             },
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: const EdgeInsets.all(0),
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Text(
//                 "MENU",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.accessibility_rounded),
//               title: const Text("Youtube"),
//               onTap: () {
//                 Navigator.pushNamed(context, 'videoyoutube');
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextFormField(
//               controller: _email,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             TextFormField(
//               controller: _password,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: login,
//                   child: const Text('ล็อกอิน'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, 'Registerfirebase');
//                   },
//                   child: const Text('สมัครบัญชี'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20), // Add spacing to separate buttons
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, 'GAMEMENU');
//               },
//               child: const Text('GAMEMENU'),
//             ),
//             const SizedBox(height: 20), // Add spacing to separate buttons
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, 'User');
//               },
//               child: const Text('จัดการบัญชี'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
