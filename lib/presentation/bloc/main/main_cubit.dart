import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/data/models/user_model.dart';
import 'package:music_streaming_app/domain/use_cases/fetch_liked_songs.dart';
import 'package:music_streaming_app/domain/use_cases/fetch_monthly_hits.dart';
import 'package:music_streaming_app/domain/use_cases/fetch_songs.dart';
import 'package:music_streaming_app/domain/use_cases/get_user.dart';
import 'package:music_streaming_app/domain/use_cases/get_user_data.dart';
import 'package:music_streaming_app/presentation/bloc/main/main_state.dart';

class MainCubit extends Cubit<MainState> {



  MainCubit() : super(MainInitial());


  int _currentIndex = 0;



  int get currentIndex => _currentIndex;


  void onTabTap(int index) {
   _currentIndex = index;
    emit(MainLoaded(
      currentIndex: _currentIndex,
    ));
  }






}
