import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/app_constants/app_colors.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/data/models/playlist_model.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_state.dart';

class PlayListTab extends StatelessWidget {
  PlayListTab({super.key, required this.state});

  final HomeLoaded state;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    List playlistsList = [
      {
        "title" : "Our Playlists",
        "playlists" : [
          PlayListModel(title: StringConstants.monthlyHits, image: Icon(Icons.local_fire_department_outlined,color: Theme.of(context).primaryColorLight)),
          PlayListModel(title: StringConstants.likedSongs, image: const Icon(Icons.favorite,color: AppColors.redColor)),
          PlayListModel(title: StringConstants.party, image:const Icon(Icons.local_drink_outlined,color: AppColors.indicatorColor)),
        ],
      },
      {
        "title" : "Your Playlists",
        "playlists" : [
          PlayListModel(title: StringConstants.monthlyHits, image:Icon(Icons.local_fire_department_outlined,color: Theme.of(context).primaryColorLight)),
          PlayListModel(title: StringConstants.likedSongs, image: const Icon(Icons.favorite,color: AppColors.redColor)),
          PlayListModel(title: StringConstants.party, image:const Icon(Icons.local_drink_outlined,color: AppColors.indicatorColor)),
        ],
      }
    ];
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: playlistsList.length,
            (BuildContext context, int index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(playlistsList[index]["title"], style: textTheme.titleLarge),
          0.02.sh.heightSizedBox,
          SizedBox(
            height: 0.16.heightSize(context),
            child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: playlistsList[index]["playlists"].length,
                itemBuilder: (context, number) {
                  return playlistBox(context, textTheme,playlistsList[index]["playlists"][number]);
                }),
          ),
        ],
      ).paddingSymmetric(vertical: 0.05.heightSize(context));
    }));
  }

  Widget playlistBox(BuildContext context, TextTheme textTheme,PlayListModel playlist) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: 1.heightSizedBox,
          ),
          Container(
            width: 0.2.widthSize(context),
            height: 0.2.widthSize(context),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(4),
              shape: BoxShape.rectangle,
            ),
            child: Center(child:playlist.image),
          ),
          Wrap(
            direction: Axis.vertical,
            children: [
              Text(
                playlist.title,
                style: textTheme.titleLarge,
              ),
              Text( playlist.title,
                  style: textTheme.titleMedium!.copyWith(fontSize: 10)),
            ],
          ),
        ],
      ).paddingLTRB(right: 0.1.widthSize(context)),
    );
  }
}
