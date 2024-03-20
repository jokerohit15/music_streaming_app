

import 'package:music_streaming_app/data/models/filter_model.dart';
import 'package:music_streaming_app/data/models/song_model.dart';





abstract class HomeState{

}

class HomeInitial extends HomeState{

}

class HomeLoading extends HomeState{

}

class HomeLoaded extends HomeState{

final List<Filters> filterList;

  HomeLoaded({required this.filterList});
}

class HomeError extends HomeState{
 final String errorMessage;

  HomeError({required this.errorMessage});
}