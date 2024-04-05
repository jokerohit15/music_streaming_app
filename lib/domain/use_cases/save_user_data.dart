

import 'package:music_streaming_app/domain/repositories/user_repository.dart';

class SaveUserData{
  final UserRepository repository;

  SaveUserData(this.repository);


  Future<void> call(Map<String,String> userData,String uid)async {
    repository.saveUserData(userData,uid);
  }
}