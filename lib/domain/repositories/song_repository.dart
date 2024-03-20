
import 'package:music_streaming_app/data/models/song_model.dart';

abstract class SongRepository {
  Future<List<SongModel>> fetchSongs();
  Future<List<SongModel>> fetchMonthlyHits();
}

