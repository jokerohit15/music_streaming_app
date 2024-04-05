
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_streaming_app/data/models/song_model.dart';

abstract class SongRepository {
  Future<List<SongModel>> fetchSongs();
  Future<List<SongModel>> fetchMonthlyHits();
  Future<List<SongModel>> fetchLikedSongs(String uid);
  Future<void> toggleFavoriteStatus(String userId, bool isLiked, DocumentReference reference);
  Future<List<SongModel>>  searchedSongs(String keyword);
}

