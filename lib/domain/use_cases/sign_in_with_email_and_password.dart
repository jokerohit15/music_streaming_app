import 'package:music_streaming_app/domain/repositories/auth_repository.dart';

class SignInWithEmailAndPassword {
  final AuthRepository repository;

  SignInWithEmailAndPassword(this.repository);

  Future<void> call(String email, String password) async {
    await repository.signInWithEmailAndPassword(email, password);
  }
}