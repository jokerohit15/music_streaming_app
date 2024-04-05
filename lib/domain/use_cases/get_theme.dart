import 'package:music_streaming_app/domain/repositories/local_storage_repository.dart';

class GetTheme {
  final LocalStorageRepository localRepository;

  GetTheme({required this.localRepository});

  bool? call( )  {
    return  localRepository.isDarkTheme();
  }
}