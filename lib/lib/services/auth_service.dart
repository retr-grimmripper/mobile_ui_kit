import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // 1. SIGN UP (This is the method that was missing!)
  static Future<String?> signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return null; // Return null if successful
    } on FirebaseAuthException catch (e) {
      return e.message; // Return the Firebase error message
    } catch (e) {
      return "An unknown error occurred.";
    }
  }

  // 2. LOGIN
  static Future<String?> login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Return null if successful
    } on FirebaseAuthException catch (e) {
      return e.message; // Return the Firebase error message
    } catch (e) {
      return "An unknown error occurred.";
    }
  }

  // 3. LOGOUT
  static Future<void> logout() async {
    await _auth.signOut();
  }
}