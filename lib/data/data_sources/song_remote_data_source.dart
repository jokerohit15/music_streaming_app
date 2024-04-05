import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:music_streaming_app/core/app_constants/app_keys.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';
import '../models/song_model.dart';




abstract class SongRemoteDataSource {
  Future<List<SongModel>> fetchSongs();

  Future<List<SongModel>> fetchMonthlyHits();

  Future<List<SongModel>> fetchLikedSongs(String uid);

  Future<void> toggleFavoriteStatus(
      String userId, bool isLiked, DocumentReference reference);

  Future<List<SongModel>>  searchedSongs(String keyword);
}

class SongRemoteDataSourceImpl implements SongRemoteDataSource {
  final FirebaseFirestore firestore;
  DocumentSnapshot? _lastDocument;
  SongRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<SongModel>> fetchSongs() async {
    try {
      late QuerySnapshot<Map<String, dynamic>> querySnapshot;
      if(_lastDocument == null)
        {
           querySnapshot = await firestore
              .collection(AppKeys.musicStreamingKey)
              .doc(StringConstants.musicStreamDoc)
              .collection(AppKeys.songsKey)
               .orderBy(AppKeys.yearOfReleaseKey)
              .limit(7)
              .get();
        }
      else{
        querySnapshot =   await firestore
            .collection(AppKeys.musicStreamingKey)
            .doc(StringConstants.musicStreamDoc)
            .collection(AppKeys.songsKey)
            .orderBy(AppKeys.yearOfReleaseKey)
            .startAfterDocument(_lastDocument!)
            .limit(7)
            .get();
      }
      final List<DocumentSnapshot> items = querySnapshot.docs;
      if (items.isNotEmpty) {
        _lastDocument = items.last;
      }

      print(querySnapshot);
        List<SongModel> songList = querySnapshot.docs
            .map((doc) => SongModel.fromJson(doc.data(), doc.reference))
            .toList();
        print(songList);
        return songList;
      }
     catch (e) {
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa $e");
      return [];
    }
  }

  @override
  Future<void> toggleFavoriteStatus(
      String userId, bool isLiked, DocumentReference reference) async {
    final firestore = FirebaseFirestore.instance;
    try {
      final querySnapshot = await firestore
          .collection(AppKeys.musicStreamingKey)
          .doc(StringConstants.musicStreamDoc)
          .collection(AppKeys.usersKey)
          .doc(userId)
          .collection(AppKeys.likedSongsKey)
          .where(AppKeys.referenceKey, isEqualTo: reference)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        await doc.reference.delete();
      } else if (isLiked) {
        await firestore
            .collection(AppKeys.musicStreamingKey)
            .doc(StringConstants.musicStreamDoc)
            .collection(AppKeys.usersKey)
            .doc(userId)
            .collection(AppKeys.likedSongsKey)
            .add({
          AppKeys.referenceKey: reference,
        }).then((value) => print(value));
      }
    } catch (e) {
      debugPrint("Error toggling favorite status: $e");
    }
  }

  @override
  Future<List<SongModel>> fetchLikedSongs(String uid) async {
    try {
      final querySnapshot = await firestore
          .collection(AppKeys.musicStreamingKey)
          .doc(StringConstants.musicStreamDoc)
          .collection(AppKeys.usersKey)
          .doc(uid)
          .collection(AppKeys.likedSongsKey)
          .get();
      List <DocumentReference> likedList  = querySnapshot.docs.map((doc) => doc.data()[AppKeys.referenceKey] as DocumentReference).toList();
      List<SongModel> songList = [];
      for (DocumentReference documentReference in likedList) {
        DocumentSnapshot documentSnapshot = await documentReference.get();
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        DocumentReference reference = documentSnapshot.reference;
        songList.add(SongModel.fromJson(data, reference));
      }
      return songList;
    } catch (e) {
      debugPrint("Error fetching songs: $e");
      return [];
    }
  }

  @override
  Future<List<SongModel>> fetchMonthlyHits() async {
    try {
      final querySnapshot = await firestore
          .collection(AppKeys.musicStreamingKey)
          .doc(StringConstants.musicStreamDoc)
          .collection(AppKeys.monthlyHits)
          .get();
      List <DocumentReference> monthlyList  = querySnapshot.docs.map((doc) => doc.data()[AppKeys.songKey] as DocumentReference).toList();
      List<SongModel> songList = [];
      for (DocumentReference documentReference in monthlyList) {
        DocumentSnapshot documentSnapshot = await documentReference.get();
        Map<String, dynamic> data =
        documentSnapshot.data() as Map<String, dynamic>;
        DocumentReference reference = documentSnapshot.reference;
        songList.add(SongModel.fromJson(data, reference));
      }
      return songList;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<SongModel>>  searchedSongs(String keyword) async {
    try {
      final db = firestore
          .collection(AppKeys.musicStreamingKey)
          .doc(StringConstants.musicStreamDoc)
          .collection(AppKeys.songsKey);
      Set<String> processedDocIds = <String>{};
      List<SongModel> songList = [];

      // Function to process query snapshots and add unique songs to songList
      void processSnapshot(QuerySnapshot snapshot) {
        for (var doc in snapshot.docs) {
          if (!processedDocIds.contains(doc.id)) {
            songList.add(SongModel.fromJson(
                doc.data() as Map<String, dynamic>, doc.reference));
            processedDocIds.add(doc.id);
          }
        }
      }
      final String endKey = keyword.substring(0, keyword.length - 1) +
          String.fromCharCode(keyword.codeUnitAt(keyword.length - 1) + 1);

      var nameSnapshot = await db
          .where(AppKeys.nameKey, isGreaterThanOrEqualTo: keyword)
          .where(AppKeys.nameKey, isLessThan: endKey)
          .get();
      print("namekeyyyyyyyyyyyyyyyyyy   ${nameSnapshot.docs}");
      processSnapshot(nameSnapshot);

      var albumSnapshot = await db
          .where(AppKeys.albumKey, isGreaterThanOrEqualTo: keyword)
          .where(AppKeys.albumKey, isLessThan: endKey)
          .get();
      print("album   ${albumSnapshot.docs}");
      processSnapshot(albumSnapshot);

      var artistsSnapshot = await db
          .where(AppKeys.artistKey, arrayContains: keyword)
          .get();
      print("artists   ${artistsSnapshot.docs}");
      processSnapshot(artistsSnapshot);

      var yearSnapshot = await db
          .where(AppKeys.yearOfReleaseKey, isGreaterThanOrEqualTo: keyword)
          .where(AppKeys.yearOfReleaseKey, isLessThan: endKey)
          .get();
      print("year   ${yearSnapshot.docs}");
      processSnapshot(yearSnapshot);

      print("gggggggggggggggggggggggggggggggggggg");
      return songList;
    }
    catch(e){
      print("fffffffffffffffffffffffffffffff");
      print(e);
      return [];
    }
  }

}
