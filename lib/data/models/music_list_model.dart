
import 'package:music_streaming_app/data/models/song_model.dart';

class MusicListModel{
  final String title;
  final List<SongModel> songs;

  MusicListModel({required this.title, required this.songs});
}