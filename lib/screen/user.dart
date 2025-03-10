import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  User? user;

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      user = currentUser;
    });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      user = null;
    });
    Navigator.pushNamed(context, 'Home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('จัดการบัญชีผู้ใช้', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        centerTitle: true,
        actions: [
          if (user != null)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _signOut,
            ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade200, Colors.teal.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Card(
            elevation: 15,
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            shadowColor: Colors.teal.shade800,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: user != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.teal,
                          child: Icon(Icons.account_circle, size: 80, color: Colors.white),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'ยินดีต้อนรับ, ${user!.email}',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.teal),
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton.icon(
                          onPressed: _signOut,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          icon: const Icon(Icons.logout, color: Colors.white),
                          label: const Text('ออกจากระบบ', style: TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                      ],
                    )
                  : const Text(
                      'กรุณาล็อกอิน',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
