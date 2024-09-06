import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  bool _isAdmin = false;

  User? get user => _user;
  bool get isAdmin => _isAdmin;

  Future<void> signup(String email, String password, bool isAdmin) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      _user = userCredential.user;

      await _firestore.collection('users').doc(_user!.uid).set({
        'email': email,
        'role': isAdmin ? 'admin' : 'user',
      });

      _isAdmin = isAdmin;
      notifyListeners();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = userCredential.user;

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(_user!.uid).get();
      _isAdmin = userDoc['role'] == 'admin';

      notifyListeners();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void logout() {
    _auth.signOut();
    _user = null;
    _isAdmin = false;
    notifyListeners();
  }
}
