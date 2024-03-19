import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/song_model.dart';

abstract class SongRemoteDataSource {
  Future<List<SongModel>> fetchSongs();
  Future<void> toggleFavoriteStatus(String songId, bool isFavorited);
}

class SongRemoteDataSourceImpl implements SongRemoteDataSource {
  final FirebaseFirestore firestore;

  SongRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<SongModel>> fetchSongs() async {
    final querySnapshot = await firestore.collection('songs').get();
    return querySnapshot.docs
        .map((doc) => SongModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> toggleFavoriteStatus(String songId, bool isFavorited) async {
    await firestore.collection('songs').doc(songId).update({'isFavorited': isFavorited});
  }
}