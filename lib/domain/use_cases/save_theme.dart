

import 'package:music_streaming_app/domain/repositories/local_storage_repository.dart';

class SaveTheme{

final LocalStorageRepository localRepository;

  SaveTheme({required this.localRepository});

   void call(bool isDark)  {
      localRepository.saveTheme(isDark);
   }

}