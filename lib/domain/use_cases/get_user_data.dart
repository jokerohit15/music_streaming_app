import 'package:music_streaming_app/data/models/user_model.dart';
import 'package:music_streaming_app/domain/repositories/user_repository.dart';

class GetUserData {
  final UserRepository userRepository;

  GetUserData({required this.userRepository});

  Future<UserModel> call(String userID) {
    return userRepository.getUserData(userID);
  }
}
