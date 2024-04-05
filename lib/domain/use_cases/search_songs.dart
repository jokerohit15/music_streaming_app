import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/domain/repositories/song_repository.dart';

class SearchSongs {
  final SongRepository repository;

  SearchSongs(this.repository);

  Future<List<SongModel>> call(String keyword) async {
    return await repository.searchedSongs(keyword);
  }
}
