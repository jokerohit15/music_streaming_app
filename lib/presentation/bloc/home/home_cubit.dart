import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';
import 'package:music_streaming_app/data/models/filter_model.dart';
import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/domain/use_cases/fetch_monthly_hits.dart';
import 'package:music_streaming_app/domain/use_cases/fetch_songs.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final List<Filters> _filterList = [
    Filters(title: StringConstants.music, isActive: true),
    Filters(title: StringConstants.playlist, isActive: false),
    Filters(title: StringConstants.artist, isActive: false),
    Filters(title: StringConstants.podcast, isActive: false),
  ];


  List<Filters> get filterList => _filterList;

 void onPressFilter(int index) {
    if (!_filterList[index].isActive) {
      for (var element in _filterList) {
        element.isActive = false;
      }
    }
    _filterList[index].isActive = true;
    emit(HomeLoaded(filterList: _filterList));
  }




}
