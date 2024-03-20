


import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/domain/repositories/song_repository.dart';

class FetchMonthlyHits {
  final SongRepository repository;

  FetchMonthlyHits(this.repository);

  Future<List<SongModel>> call() async {
    return await repository.fetchMonthlyHits();
  }
}