

import 'package:music_streaming_app/core/app_constants/app_keys.dart';

class UserModel{
  final String name;
  final String emailId;
  final String uid;

  UserModel( {required this.name, required this.emailId,required this.uid});

  factory UserModel.fromJson(Map<String, dynamic> data,String uid) {
    return UserModel(
      name : data[AppKeys.nameKey],
      emailId : data[AppKeys.emailKey],
      uid:  uid,
    );
  }

}