import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_screen.dart';
import 'admin_panel.dart';
import 'user_panel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        if (!snapshot.hasData) {
          return const AuthScreen();
        }
        return FutureBuilder<bool?>(
          future: _checkIfAdmin(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            }
            if (snapshot.data == true) {
              return const AdminPanel();
            } else {
              return const UserPanel();
            }
          },
        );
      },
    );
  }

  Future<bool?> _checkIfAdmin() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) return false;

    final adminDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    return adminDoc.exists && adminDoc.data()!['isAdmin'] == true;
  }
}
