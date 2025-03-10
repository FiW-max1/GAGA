import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstweek/Home.dart';
import 'package:flutter/material.dart';

class Firebaseregister extends StatefulWidget {
  const Firebaseregister({super.key});

  @override
  State<Firebaseregister> createState() => _RegsiterfirebaseState();
}

class _RegsiterfirebaseState extends State<Firebaseregister> {
  //ประกาศตัวแปร
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();

  Future<void> submit() async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text, password: password.text)
      .then((res){
        print(res);
        Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
      }).catchError((onError) {
        print(onError.code);
        print(onError.message);
      });
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create New Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(labelText: 'email'),
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(labelText: 'password'),
            ),
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: 'name'),
            ),
            const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: submit,
                    child: const Text('Submit'),
                  ),
          ],
        ),
      ),
    );
  }
}