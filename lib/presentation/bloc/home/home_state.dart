

import 'package:music_streaming_app/data/models/filter_model.dart';

abstract class HomeState{

}

class HomeInitial extends HomeState{

}

class HomeFiltersUpdated extends HomeState{
 final List<Filters> filterList;

  HomeFiltersUpdated({required this.filterList});
}