

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_streaming_app/domain/repositories/song_repository.dart';

class ToggleFavouriteStatus {
  final SongRepository repository;
  ToggleFavouriteStatus(this.repository);

  Future<void> call(String userId, bool isLiked, DocumentReference reference) async {
   await repository.toggleFavoriteStatus(userId, isLiked, reference);
  }
}