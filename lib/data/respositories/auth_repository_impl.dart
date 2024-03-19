

import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl(this.firebaseAuth);

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
}
