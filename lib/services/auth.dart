import 'package:firebase_auth/firebase_auth.dart';
import 'package:mu_dent/models/user.dart';
import 'package:mu_dent/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create 'User' obj based on FirebaseUser
  Users _userFromFirebaseUser(User user) {
    return user != null ? Users(uid: user.uid): null;
  }

  // Auth change user stream
  Stream<Users> get user {
    return _auth.authStateChanges()
      .map((User user) => _userFromFirebaseUser(user));
  }

  // Sign in Anonymous
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      // User user = result.user;

      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Siign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email & password
  Future registerWithEmailAndPassword(String email, String password,
  String name, String surName, String gender, String phoneNumber, String birthOfDate 
  ) async {
    try {
      UserCredential result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

       // Create a new document for the user with the uid
      await DatabaseService(uid: user.uid).createPatientData(
         name, surName, gender, phoneNumber, birthOfDate
      );
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}