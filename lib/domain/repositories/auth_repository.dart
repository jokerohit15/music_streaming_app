

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<void> createUserWithEmailAndPassword(String email, String password);
  Future<bool> isAuthenticated();
  Future<User?> currentUser();
}