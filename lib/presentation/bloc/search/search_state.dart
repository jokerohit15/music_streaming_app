
import 'package:music_streaming_app/data/models/song_model.dart';

abstract class SongState {}

class SearchInitial extends SongState {}

class SongsLoaded extends SongState {
  final List<SongModel> songs;
  SongsLoaded(this.songs);
}

class SongsError extends SongState {
  final String message;
  SongsError(this.message);
}
