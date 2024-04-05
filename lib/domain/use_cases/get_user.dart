
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_streaming_app/domain/repositories/auth_repository.dart';

class GetUser{
  final AuthRepository repository;

  GetUser( this.repository);

  Future<User?> call()async{
    return repository.currentUser();
  }
}