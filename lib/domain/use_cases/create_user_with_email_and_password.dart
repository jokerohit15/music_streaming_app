


import 'package:music_streaming_app/domain/repositories/auth_repository.dart';

class CreateUserWithEmailAndPassword{
  final AuthRepository repository;

  CreateUserWithEmailAndPassword(this.repository);

  Future<void> call(String email,String password){
    return repository.createUserWithEmailAndPassword(email, password);
  }
}