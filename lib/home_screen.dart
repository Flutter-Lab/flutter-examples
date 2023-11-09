import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_examples/firebase_storage/upload_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (user != null)
            Column(
              children: [
                Text('User Email : ${user.email}'),
                TextButton(onPressed: logOut, child: const Text('Log out'))
              ],
            ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FirebaseStorageScreen(),
                    ));
              },
              child: const Text('Firebase Storage'))
        ],
      )),
    );
  }

  Future logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
