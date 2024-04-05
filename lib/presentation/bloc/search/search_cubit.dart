import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/domain/use_cases/fetch_songs.dart';
import 'package:music_streaming_app/domain/use_cases/search_songs.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/main/main_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/search/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    required this.fetchSongs,
    required this.songsSearch,
  }) : super(SearchInitial());
  final SearchSongs songsSearch;
  final FetchSongs fetchSongs;
  List<SongModel> _songs = [];
  final ScrollController _scrollController = ScrollController();


  ScrollController get scrollController => _scrollController;

  initCall(BuildContext context){
    _scrollController.addListener(_onScroll);
    _getAllSongs(context);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final thresholdReached = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent;
    if (thresholdReached) {
   //   emit(SearchInitial());
      _onPageNation();
    }
  }

  Future<void> _getAllSongs(BuildContext context) async {
    _songs = context.read<HomeCubit>().songs;
    emit(SearchLoaded(_songs));
  }

  Future<void> _onPageNation() async {
    try {
      _songs.addAll(await fetchSongs());
      emit(SearchLoaded(_songs));
    } catch (e) {
      emit(SearchError("Can't fetch songs : $e"));
    }
  }



  Future<void> searchSongs(String query) async {
    final currentState = state;
    if (currentState is SearchLoaded) {
      final allSongs = _songs;
      List<SongModel> filteredSongs = query.isNotEmpty
          ? allSongs.where((song) => _matchesQuery(song, query)).toList()
          : allSongs;
      if (filteredSongs.isEmpty && query.isNotEmpty) {
        filteredSongs = await songsSearch(query.capitalize());
      }
      emit(SearchLoaded(filteredSongs));
    }
  }

  bool _matchesQuery(SongModel song, String query) {
    final lowerCaseQuery = query.toLowerCase();
    return song.name.toLowerCase().contains(lowerCaseQuery) ||
        song.artist.first.toLowerCase().contains(lowerCaseQuery) ||
        song.yearOfRelease.toString().contains(query) ||
        song.album.toLowerCase().contains(lowerCaseQuery);
  }


  @override
  Future<void> close() {
   _scrollController.dispose();
    return super.close();
  }


}
