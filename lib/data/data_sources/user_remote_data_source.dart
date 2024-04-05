import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_streaming_app/core/app_constants/app_keys.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';
import 'package:music_streaming_app/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<void> saveUserData(Map<String,String> userData,String uid);
  Future<UserModel> getUserData(String userID);
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final FirebaseFirestore firestore;

  UserRemoteDataSourceImpl({required this.firestore});
  @override
  Future<void> saveUserData(Map<String,String> userData,String uid) async {
    try{
      print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
      print(userData);
    await firestore
        .collection(AppKeys.musicStreamingKey)
        .doc(StringConstants.musicStreamDoc)
        .collection(AppKeys.usersKey)
        .doc(uid)
        .set(userData);
  }
  catch(e){
      print("errrrrrrrrrrrrrrrrrrrrrrrrrrrrrorr $e");
    }
  }

  @override
  Future<UserModel> getUserData(String userID) async {
    final docSnapshot =  await firestore
        .collection(AppKeys.musicStreamingKey)
        .doc(StringConstants.musicStreamDoc)
        .collection(AppKeys.usersKey)
        .doc(userID)
        .get();
       return UserModel.fromJson(docSnapshot.data()!, userID);
  }

}
