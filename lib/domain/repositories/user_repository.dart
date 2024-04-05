

import 'package:music_streaming_app/data/models/user_model.dart';

abstract class UserRepository{
  Future<void> saveUserData(Map<String,String> userData,String uid);
  Future<UserModel> getUserData(String userID);
}