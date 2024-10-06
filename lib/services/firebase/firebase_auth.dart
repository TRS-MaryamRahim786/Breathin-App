import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../screens/auth/login/model/user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register user with email and password

  Future<void> registerUser(UserModel user) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
    await _firestore.collection('users').doc(userCredential.user!.email).set({
      'email': user.email,
      'language': user.language,
    });
  }

  // Method to login user
  Future<void> loginUser(UserModel user) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
  }

  // Check if the user is already registered
  Future<bool> isUserRegistered(String email) async {
    bool isUserRegistered = false;
    try {
// if the size of value is greater then 0 then that doc exist.
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get()
          .then((value) {
        if (value.size > 0) {
          isUserRegistered = true;
        } else {
          isUserRegistered = false;
        }
      });
      return isUserRegistered;
    } catch (e) {
      debugPrint(e.toString());
      return isUserRegistered;
    }
  }
}
