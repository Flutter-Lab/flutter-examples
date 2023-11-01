import 'package:flutter/material.dart';
import 'package:flutter_examples/firebase_storage/upload_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
}
