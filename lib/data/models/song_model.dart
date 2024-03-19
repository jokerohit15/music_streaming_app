

import 'package:music_streaming_app/core/app_constants/app_keys.dart';

class SongModel{
  final String name;
  final String album;
  final String audio;
  final String albumArt;
  final List<String> artist;
  final int yearOfRelease;

  SongModel({required this.name, required this.album, required this.audio, required this.albumArt, required this.artist, required this.yearOfRelease});

  factory SongModel.fromJson(Map<String, dynamic> data) {
  return SongModel(
      name : data[AppKeys.nameKey],
      album : data[AppKeys.albumKey],
      audio : data[AppKeys.audioKey],
      albumArt : data[AppKeys.albumArtKey],
      artist:data[AppKeys.artistKey],
      yearOfRelease: data[AppKeys.yearOfReleaseKey],
  );
  }

  Map<String, dynamic> toJson() {
    return {
      AppKeys.nameKey: name,
      AppKeys.albumKey: album,
      AppKeys.audioKey: audio,
      AppKeys.albumArtKey: albumArt,
      AppKeys.artistKey :artist,
    AppKeys.yearOfReleaseKey :yearOfRelease,
    };
  }
}