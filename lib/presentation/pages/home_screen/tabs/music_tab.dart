import 'package:flutter/material.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';
import 'package:music_streaming_app/data/models/music_list_model.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_state.dart';
import 'package:music_streaming_app/presentation/widgets/music_list.dart';


class MusicTab extends StatelessWidget {
  const MusicTab({super.key, required this.state});
  final HomeLoaded state;
  @override
  Widget build(BuildContext context) {
    List<MusicListModel> musicList = [
      MusicListModel(
          title: StringConstants.monthlyHits, songs: state.monthlyHits),
      MusicListModel(
          title: StringConstants.lastPlayed, songs: state.songList),
      MusicListModel(title: "Party", songs: state.monthlyHits),
      MusicListModel(
          title: StringConstants.soothYourself, songs: state.songList),
    ];
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: musicList.length,
                (BuildContext context, int index) {
              return MusicList(
                  title: musicList[index].title, songs: musicList[index].songs);
            }));
  }
}
