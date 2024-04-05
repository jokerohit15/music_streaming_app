import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';
import 'package:music_streaming_app/data/models/filter_model.dart';
import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/data/models/user_model.dart';
import 'package:music_streaming_app/domain/use_cases/fetch_liked_songs.dart';
import 'package:music_streaming_app/domain/use_cases/fetch_monthly_hits.dart';
import 'package:music_streaming_app/domain/use_cases/fetch_songs.dart';
import 'package:music_streaming_app/domain/use_cases/get_user.dart';
import 'package:music_streaming_app/domain/use_cases/get_user_data.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_state.dart';
import 'package:music_streaming_app/presentation/pages/home_screen/tabs/artist_tab.dart';
import 'package:music_streaming_app/presentation/pages/home_screen/tabs/music_tab.dart';
import 'package:music_streaming_app/presentation/pages/home_screen/tabs/playlist_tab.dart';
import 'package:music_streaming_app/presentation/pages/home_screen/tabs/podcast_tab.dart';

class HomeCubit extends Cubit<HomeState> {

  final FetchSongs fetchSongs;
  final FetchMonthlyHits fetchMonthlyHits;
  final FetchLikedSongs fetchLikedSongs;
  final GetUserData getUserData;
  final GetUser getUser;

  HomeCubit({
    required this.fetchSongs,
    required this.fetchMonthlyHits,
    required this.fetchLikedSongs,
    required this.getUserData,
    required this.getUser,
  }) : super(HomeInitial());
  final List<Filters> _filterList = [
    Filters(title: StringConstants.music, isActive: true),
    Filters(title: StringConstants.playlist, isActive: false),
    Filters(title: StringConstants.artist, isActive: false),
    Filters(title: StringConstants.podcast, isActive: false),
  ];


   dynamic giveTab(HomeLoaded state){
    List tabList =[MusicTab( state: state,),PlayListTab( state: state,),ArtistTab(),PodcastTab()];
    return tabList[state.filterIndex];
  }



  List<SongModel> _songs = [];
  List<SongModel> _monthlyHits = [];
  List<SongModel> likedSongs = [];
  int _index = 0;
  String userName = "";
  final ScrollController _scrollController = ScrollController();

  List<SongModel> get songs => _songs;
  List<SongModel> get monthlyHits => _monthlyHits;

  List<Filters> get filterList => _filterList;

  ScrollController get scrollController => _scrollController;

  initCall(){
    _getSongs();
  }




  Future<void> onPageNation() async {
    try {
      _songs.addAll(await fetchSongs());
      emit(HomeLoaded(
        songList: _songs,
        monthlyHits: _monthlyHits,
        userName: userName,
        filterList: _filterList,
         filterIndex: _index
      ));
    } catch (e) {
      emit(HomeError( errorMessage: "Can't fetch songs : $e",));
    }
  }



 void onPressFilter(int index) {
    if (!_filterList[index].isActive) {
      for (var element in _filterList) {
        element.isActive = false;
      }
    }
    _filterList[index].isActive = true;
    _index = index;
    emit(HomeLoaded(
      songList: _songs,
      monthlyHits: _monthlyHits,
      userName: userName,
      filterList: _filterList,
      filterIndex:  _index,
    ));
  }


  Future<void> _getSongs() async {
    emit(HomeLoading());
    try {
      _monthlyHits = await fetchMonthlyHits();
      _songs = await fetchSongs();
      User? user = await getUser();
      if (user != null) {
        likedSongs = await fetchLikedSongs(user.uid);
        userName = await _getUserName(user);
      }
      for (var song in _songs) {
        var found = likedSongs.any((likedSong) => likedSong.name == song.name);
        if (found) {
          song.isLiked = true;
        }
      }
      emit(HomeLoaded(
        songList: _songs,
        monthlyHits: _monthlyHits,
        userName: userName,
        filterList: _filterList,
        filterIndex: _index,
      ));
    } catch (e) {
      emit(HomeError(errorMessage: e.toString()));
    }
  }


  Future<String> _getUserName(User user) async {
    UserModel userModel = await getUserData(user.uid);
    return userModel.name;
  }



}
