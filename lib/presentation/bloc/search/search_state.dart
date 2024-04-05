
import 'package:music_streaming_app/data/models/song_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoaded extends SearchState {
  final List<SongModel> songs;
  SearchLoaded(this.songs);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}
