


import 'package:music_streaming_app/data/models/song_model.dart';

abstract class MainState{}



class MainInitial extends MainState{}


class MainLoading extends MainState{}

class MainLoaded extends MainState{
  final List<SongModel> songList;
  final List<SongModel> monthlyHits;
  final int currentIndex;

  MainLoaded({required this.songList, required this.monthlyHits,required this.currentIndex});
  }



class MainSearchedSong extends MainState{
  final List<SongModel> songList;

  MainSearchedSong({required this.songList});
}


class MainError extends MainState{
  final String errorMessage;

  MainError({required this.errorMessage});
}