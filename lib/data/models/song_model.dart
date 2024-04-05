

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_streaming_app/core/app_constants/app_keys.dart';

class SongModel{
  final String name;
  final String album;
  final String audio;
  final String albumArt;
  final List<dynamic> artist;
  final int yearOfRelease;
  final DocumentReference reference;
  bool isLiked;

  SongModel({required this.name, required this.album, required this.audio, required this.albumArt, required this.artist, required this.yearOfRelease,required this.reference,this.isLiked= false});

  factory SongModel.fromJson(Map<String, dynamic> data,DocumentReference reference) {
  return SongModel(
      name : data[AppKeys.nameKey],
      album : data[AppKeys.albumKey],
      audio : data[AppKeys.audioKey],
      albumArt : data[AppKeys.albumArtKey],
      artist:data[AppKeys.artistKey],
      yearOfRelease: data[AppKeys.yearOfReleaseKey]??11,
      reference: reference,
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