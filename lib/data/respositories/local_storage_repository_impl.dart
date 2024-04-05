
import 'package:music_streaming_app/data/data_sources/local_storage_source.dart';
import 'package:music_streaming_app/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageSource localStorageSource;

  LocalStorageRepositoryImpl({required this.localStorageSource});

  @override
  bool? isDarkTheme() {
    return  localStorageSource.isDarkTheme();
  }

  @override
 void  saveTheme(bool isDark)  {
    localStorageSource.saveTheme(isDark);
  }


}