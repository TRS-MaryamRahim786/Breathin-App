import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Store user information on Firestore
  Future<void> storeUserInfo(
      String uid, String email, String countryCode) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'email': email,
        'countryCode': countryCode,
      });
    } catch (e) {
      throw Exception('Failed to store user info: $e');
    }
  }

  // Fetch user data from Firestore
  Future<DocumentSnapshot> getUserInfo(String uid) async {
    try {
      return await _firestore.collection('users').doc(uid).get();
    } catch (e) {
      throw Exception('Failed to get user info: $e');
    }
  }
}
