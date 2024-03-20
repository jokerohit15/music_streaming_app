import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_streaming_app/core/app_constants/app_keys.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';

import '../models/song_model.dart';

abstract class SongRemoteDataSource {
  Future<List<SongModel>> fetchSongs();

  Future<List<SongModel>> fetchMonthlyHits();

  Future<void> toggleFavoriteStatus(String songId, bool isFavorited);
}

class SongRemoteDataSourceImpl implements SongRemoteDataSource {
  final FirebaseFirestore firestore;

  SongRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<SongModel>> fetchSongs() async {
    try{
      final querySnapshot = await firestore
          .collection(AppKeys.musicStreamingKey)
          .doc(StringConstants.musicStreamDoc)
          .collection(AppKeys.songsKey)
          .get();
      List<SongModel> songList = querySnapshot.docs
          .map((doc) => SongModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      print("totallllllllllllllllll");
      print(songList);
      return songList;
    }
  catch(e){
      print("errrrrrrr  $e");
      return [SongModel(name: e.toString(), album: e.toString(), audio: e.toString(), albumArt: e.toString(), artist: [e.toString()], yearOfRelease: 11)];
  }
  }

  @override
  Future<void> toggleFavoriteStatus(String songId, bool isFavorited) async {
    await firestore
        .collection('songs')
        .doc(songId)
        .update({'isFavorited': isFavorited});
  }

  @override
  Future<List<SongModel>> fetchMonthlyHits() async {
    try{
      final querySnapshot = await firestore
          .collection(AppKeys.musicStreamingKey)
          .doc(StringConstants.musicStreamDoc)
          .collection(AppKeys.monthlyHits)
          .get();
      // print(querySnapshot.docs.length);
      // print(querySnapshot.docs.first.data());
      // int c=0;
      // querySnapshot.docs
      //     .map((doc) => print(c++));
      List<DocumentReference> monthlyList = [querySnapshot.docs.first.data()[AppKeys.songKey]];
      // querySnapshot.docs
      //     .map((doc) => monthlyList.add(doc.data()[AppKeys.songKey]));
      DocumentSnapshot documentSnapshot = await monthlyList[0].get();
      print(documentSnapshot.data());
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      List<SongModel> songList = [SongModel.fromJson(data)];
      print("monthlyyyyyyyyyyyyyyyyyyyy");
      print(songList);
      return songList;
    }
    catch(e){
      print("errrrrrrr  $e");
      return [SongModel(name: e.toString(), album: e.toString(), audio: e.toString(), albumArt: e.toString(), artist: [e.toString()], yearOfRelease: 11)];
    }
  }
}
