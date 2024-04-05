

import 'package:just_audio/just_audio.dart';

abstract class DetailsState{

}

class DetailsInitial extends DetailsState{}


class DetailsLoaded extends DetailsState{
  final AudioPlayer musicPlayer;
  final List<String> song;
  DetailsLoaded({required this.musicPlayer,required this.song});
}

class DetailsFailure extends DetailsState{
  final String error;

  DetailsFailure({required this.error});
}