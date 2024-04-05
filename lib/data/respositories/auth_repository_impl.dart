

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl(this.firebaseAuth);

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      debugPrint("Error signing out: $e");
      rethrow;
    }
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      debugPrint("User registration error: $e");
      rethrow;
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    final user = firebaseAuth.currentUser;
    return user != null;
  }


  @override
  Future<User?> currentUser() async{
    try{
      return  firebaseAuth.currentUser;
    }
    catch(e){
      debugPrint("User not found $e");
    }
    return null;
  }



}
