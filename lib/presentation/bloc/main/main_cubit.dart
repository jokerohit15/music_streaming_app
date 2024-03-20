import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/domain/use_cases/fetch_monthly_hits.dart';
import 'package:music_streaming_app/domain/use_cases/fetch_songs.dart';
import 'package:music_streaming_app/presentation/bloc/main/main_state.dart';

class MainCubit extends Cubit<MainState> {
  final FetchSongs fetchSongs;
  final FetchMonthlyHits fetchMonthlyHits;

  MainCubit({required this.fetchSongs, required this.fetchMonthlyHits})
      : super(MainInitial());

  List<SongModel> _songs =[];
  List <SongModel> _monthlyHits = [];
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  Future<void> getSongs() async {
    emit(MainLoading());
    try {
       _songs = await fetchSongs();
     _monthlyHits = await fetchMonthlyHits();
      emit(MainLoaded(songList: _songs, monthlyHits: _monthlyHits, currentIndex: 0));
    } catch (e) {
      emit(MainError(errorMessage: e.toString()));
    }
  }

  void onTabTap(int index) {
      _currentIndex = index;
        emit(MainLoaded(songList: _songs, monthlyHits: _monthlyHits, currentIndex: _currentIndex));
  }

  void searchSongs(String query) {
    final currentState = state;
    if (currentState is MainLoaded || currentState is MainSearchedSong) {
      final allSongs = currentState is MainLoaded ? currentState.songList : _songs;
      final filteredSongs = query.isNotEmpty
          ? allSongs.where((song) => _matchesQuery(song, query)).toList()
          : allSongs;
      emit(MainSearchedSong(songList: filteredSongs));
    }
  }

  bool _matchesQuery(SongModel song, String query) {
    final lowerCaseQuery = query.toLowerCase();
    return song.name.toLowerCase().contains(lowerCaseQuery) ||
        song.artist.first.toLowerCase().contains(lowerCaseQuery) ||
        song.yearOfRelease.toString().contains(query) ||
        song.album.toLowerCase().contains(lowerCaseQuery);
  }
}
