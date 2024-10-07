import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../screens/auth/auth/model/user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Register user with email and password
  Future<void> registerUser(UserModel user) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      await _firestore.collection('users').doc(userCredential.user!.email).set({
        'email': user.email,
        'language': user.language,
      });
    } catch (e) {
      throw e.toString() ?? 'An unexpected error occurred. Please try again.';
    }
  }

  /// Method to login user
  Future<void> loginUser(UserModel user) async {
    try {
      // Attempt to log the user in using email and password
      await _auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
    } on FirebaseAuthException catch (e) {
      // Check for specific error codes from FirebaseAuthException
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        // Handle wrong password case
        throw 'Invalid credentials. Please check your password.';
      } else if (e.code == 'user-not-found') {
        // Handle user not found case
        throw 'No user found with this email.';
      } else {
        // Throw any other FirebaseAuth related errors
        throw e.message ?? 'Authentication failed.';
      }
    } catch (e) {
      // Catch any other exceptions (non-Firebase)
      throw 'An unexpected error occurred. Please try again.';
    }
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

  // Method to sign out the user
  Future<void> signOut() async {
    try {
      // Sign the user out from Firebase Auth
      await _auth.signOut();
      print("User signed out successfully.");
    } catch (e) {
      // Handle any errors during sign-out
      print("Error during sign-out: $e");
      throw 'Sign out failed. Please try again.';
    }
  }
}
