// songs_cubit.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/domain/use_cases/fetch_songs.dart';
import 'package:music_streaming_app/presentation/bloc/main/main_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/search/search_state.dart';
import 'package:music_streaming_app/presentation/pages/main_screen.dart';

class SearchCubit extends Cubit<SongState> {
  SearchCubit() : super(SearchInitial());


  //
  // void searchSongs(String query,BuildContext context) {
  //   final currentState = state;
  //   List<SongModel> filteredSongs = [];
  //   if (currentState is SongsLoaded) {
  //     if (query.isNotEmpty) {
  //       filteredSongs = currentState.songs.where((song) {
  //         print(song.yearOfRelease);
  //         print(query);
  //         return song.name.toLowerCase().contains(query.toLowerCase()) ||
  //             song.artist.contains(query.toLowerCase()) ||
  //             song.yearOfRelease.toString().contains(query) ||
  //             song.album.toLowerCase().contains(query.toLowerCase());
  //       }).toList();
  //     } else {
  //       filteredSongs = context.read<MainCubit>().songs;
  //     }
  //     emit(SongsLoaded(filteredSongs));
  //   }
  // }
}
