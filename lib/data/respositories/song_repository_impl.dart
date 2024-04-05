import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_streaming_app/data/data_sources/song_remote_data_source.dart';
import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/domain/repositories/song_repository.dart';

class SongRepositoryImpl implements SongRepository {
  final SongRemoteDataSource remoteDataSource;

  SongRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<SongModel>> fetchSongs() async {
    return await remoteDataSource.fetchSongs();
  }

  @override
  Future<List<SongModel>> fetchMonthlyHits() async {
    return await remoteDataSource.fetchMonthlyHits();
  }

  @override
  Future<List<SongModel>> fetchLikedSongs(String uid) async {
    return await remoteDataSource.fetchLikedSongs(uid);
  }

  @override
  Future<void> toggleFavoriteStatus(String userId, bool isLiked, DocumentReference<Object?> reference) async {
    await remoteDataSource.toggleFavoriteStatus(userId, isLiked, reference);
  }

  @override
  Future<List<SongModel>>  searchedSongs(String keyword) async{
   return await remoteDataSource.searchedSongs(keyword);
  }
}
