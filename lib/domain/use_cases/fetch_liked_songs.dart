


import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/domain/repositories/song_repository.dart';

class FetchLikedSongs {
  final SongRepository repository;

  FetchLikedSongs(this.repository);

  Future<List<SongModel>> call(String uid) async {
    return await repository.fetchLikedSongs(uid);
  }
}