

import 'package:music_streaming_app/data/data_sources/user_remote_data_source.dart';
import 'package:music_streaming_app/data/models/user_model.dart';
import 'package:music_streaming_app/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository{

  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> saveUserData(Map<String,String> userData,String uid) async {
    await remoteDataSource.saveUserData(userData,uid);
  }

  @override
  Future<UserModel> getUserData(String userID) async {
   return await remoteDataSource.getUserData(userID);
  }


}