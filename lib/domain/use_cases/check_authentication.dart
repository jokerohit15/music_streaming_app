


import 'package:music_streaming_app/domain/repositories/auth_repository.dart';

class CheckAuthentication{
  final AuthRepository repository;

  CheckAuthentication(this.repository);

  Future<bool> call() async {
  return  await repository.isAuthenticated();
  }
}