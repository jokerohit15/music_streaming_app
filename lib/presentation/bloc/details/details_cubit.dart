import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/presentation/bloc/details/details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  late AudioPlayer _audioPlayer;
  late ValueNotifier<Duration> _positionNotifier;
  late ValueNotifier<Duration?> _durationNotifier;
  Duration _duration = Duration.zero;

  AudioPlayer get audioPlayer => _audioPlayer;
  ValueNotifier<Duration> get positionNotifier => _positionNotifier;
  ValueNotifier<Duration?> get durationNotifier => _durationNotifier;

  List<String> song = [];

  void initialize(SongModel songModel) {
    if (song.isNotEmpty) {
      _audioPlayer.dispose();
      _positionNotifier.dispose();
      _durationNotifier.dispose();
    }
    _audioPlayer = AudioPlayer();
    _positionNotifier = ValueNotifier<Duration>(Duration.zero);
    _durationNotifier = ValueNotifier<Duration?>(null);
    _initializeAudio(songModel);
  }

  void onPressPlayPauseButton(bool isPlay) {
    isPlay ? _audioPlayer.play() : _audioPlayer.pause();
  }

  void onForwardReverseButton(bool isForward) {
    final currentPosition = _audioPlayer.position;
    isForward
        ? _audioPlayer.seek(currentPosition + const Duration(seconds: 10))
        : _audioPlayer.seek(currentPosition - const Duration(seconds: 10));
  }

  Future<void> seekToPosition(Duration position) async {
    await _audioPlayer.seek(position);
  }

  Future<void> _initializeAudio(SongModel songModel) async {
    try {
      await _audioPlayer.setUrl(songModel.audio);
      _duration = _audioPlayer.duration ?? Duration.zero;
      _durationNotifier.value = _duration;
      _audioPlayer.positionStream.listen((position) {
        _positionNotifier.value = position;
      });
      _audioPlayer.play();
      _initialiseSong(songModel);
      emit(DetailsLoaded(musicPlayer: audioPlayer, song: song));
    } catch (e) {
      debugPrint("Error loading audio source: $e");
      emit(DetailsFailure(error: "Error loading audio source: $e"));
    }
  }

  void _initialiseSong(SongModel songModel) {
    song = [songModel.name, songModel.albumArt, songModel.artist.first];
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    _positionNotifier.dispose();
    _durationNotifier.dispose();
    return super.close();
  }
}
