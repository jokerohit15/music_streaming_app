
import 'package:music_streaming_app/data/models/song_model.dart';

import '../repositories/song_repository.dart';

class FetchSongs {
  final SongRepository repository;

  FetchSongs(this.repository);

  Future<List<SongModel>> call() async {
    return await repository.fetchSongs();
  }
}