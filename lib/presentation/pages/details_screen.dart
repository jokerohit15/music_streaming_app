import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/app_constants/app_images.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/presentation/widgets/icon_button_widget.dart';
import 'package:music_streaming_app/presentation/widgets/player.dart';


class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.song, required this.title});
  final SongModel song;
  final String title;
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        body: Stack(
      children: [
       Hero(
         tag: song.name + title,
          child: Container(
            width: 1.sw,
            height: 1.sh,
            padding: EdgeInsets.symmetric(horizontal: 0.15.sw, vertical: 0.0.sh),
            decoration:  BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(song.albumArt),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: Align(
              alignment: Alignment.center,
             child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Image.network(song.albumArt)),
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(isDarkMode
                ? AppImages.blurredEllipseBlack
                : AppImages.blurredEllipseWhite)),
        Align(alignment: Alignment.bottomCenter, child: player(textTheme,isDarkMode)),
      ],
    ));
  }

  Widget player(TextTheme textTheme, bool isDarkMode) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.name,
                  style: textTheme.displayLarge,
                ),
                song.artist.length == 1
                ? Text(song.artist.first, style: textTheme.titleMedium)
                :SizedBox(
                  height: 0.02.sh,
                  width: 0.7.sw,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: song.artist.length,
                    itemBuilder: (context,index) {
                      return Text(index ==  song.artist.length-1 ?"${song.artist[index]}  ":"${song.artist[index]} , ", style: textTheme.titleMedium);
                    }
                  ),
                ),
              ],
            ),
            Expanded(child: 0.35.sw.widthSizedBox),
            IconButtonWidget(icon: Icons.favorite_border, isDark: isDarkMode),
          ],
        ).paddingSymmetric(horizontal: 0.05.sw),
        buttonRow(isDarkMode),
        const Player(),
      ],
    );
  }

  Widget buttonRow(bool isDarkMode){
    return   Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButtonWidget(icon: Icons.shuffle, isDark: isDarkMode),
        0.17.sw.widthSizedBox,
        IconButtonWidget(icon: Icons.fast_rewind, isDark: isDarkMode),
        IconButtonWidget(icon: Icons.play_arrow, isDark: isDarkMode),
        IconButtonWidget(
            icon: Icons.fast_forward_sharp, isDark: isDarkMode),
        0.16.sw.widthSizedBox,
        IconButtonWidget(icon: Icons.repeat_one, isDark: isDarkMode),
      ],
    ).paddingSymmetric(horizontal: 0.016.sw);
  }
}


