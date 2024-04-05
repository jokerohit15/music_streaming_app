import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/app_constants/app_images.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/presentation/bloc/details/details_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/details/details_state.dart';
import 'package:music_streaming_app/presentation/pages/details_screen/widgets/play_buttons.dart';
import 'package:music_streaming_app/presentation/widgets/icon_button_widget.dart';
import 'package:music_streaming_app/presentation/widgets/like_button_widget.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.song, required this.title});

  final SongModel song;
  final String title;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    context.read<DetailsCubit>().initialize(song);
    bool isWide = MediaQuery.of(context).size.width > 600;
    return Scaffold(
        body: Stack(
      children: [
        Hero(
          tag: song.name + title,
          child: Container(
            width: 1.sw,
            height: 1.sh,
            padding:
                EdgeInsets.symmetric(horizontal: 0.15.sw, vertical: 0.0.sh),
            decoration: BoxDecoration(
              image: DecorationImage(
                //image: const AssetImage("assets/image.png"),
                image: CachedNetworkImageProvider(song.albumArt),
                fit: isWide ? BoxFit.fitWidth : BoxFit.fitHeight,
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              //   child: Image.asset(
              //     "assets/image.png",
              //   ),
              // ),
               child: CachedNetworkImage(imageUrl: song.albumArt)),
            ).paddingLTRB(bottom: 0.2.sh),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child:Container(
              width: 1.sw,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      isDarkMode
                          ? AppImages.blurredEllipseBlack
                          : AppImages.blurredEllipseWhite,
                  ),
                  fit: isWide ? BoxFit.fitWidth : BoxFit.fitHeight,
                )
              ),
            )
        ),
        BlocBuilder<DetailsCubit, DetailsState>(builder: (context, state) {
          if (state is DetailsLoaded) {
            return Align(
                alignment: Alignment.bottomCenter,
                child: player(textTheme, isDarkMode, context));
          } else if (state is DetailsFailure) {
            return Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Couldn't initialise player as ${state.error}",
                  textAlign: TextAlign.center,
                ).paddingLTRB(bottom: 0.1.sh));
          }
          return Align(
              alignment: Alignment.bottomCenter,
              child: const CircularProgressIndicator()
                  .paddingLTRB(bottom: 0.1.sh));
        }),
      ],
    ));
  }

  Widget player(TextTheme textTheme, bool isDarkMode, BuildContext context) {
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
                    : SizedBox(
                        height: 0.02.sh,
                        width: 0.7.sw,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: song.artist.length,
                            itemBuilder: (context, index) {
                              return Text(
                                  index == song.artist.length - 1
                                      ? "${song.artist[index]}  "
                                      : "${song.artist[index]} , ",
                                  style: textTheme.titleMedium);
                            }),
                      ),
              ],
            ),
            Expanded(child: 0.35.sw.widthSizedBox),
            LikeButtonWidget(
              icon: song.isLiked ? Icons.favorite : Icons.favorite_border,
              reference: song.reference,
              song: song,
            ),
          ],
        ).paddingSymmetric(horizontal: 0.05.sw),
        buttonRow(isDarkMode, context),
sliderWithPosition(context),
      ],
    );
  }

  Widget buttonRow(bool isDarkMode, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButtonWidget(icon: Icons.shuffle, isDark: isDarkMode),
        Expanded(child: 0.17.widthSize(context).widthSizedBox),
        const PlayButtons(
          icon: Icons.fast_rewind_sharp,
        ),
        const PlayButtons(icon: Icons.pause),
        const PlayButtons(icon: Icons.fast_forward_sharp),
        Expanded(child: 0.16.widthSize(context).widthSizedBox),
        IconButtonWidget(icon: Icons.repeat_one, isDark: isDarkMode),
      ],
    ).paddingSymmetric(horizontal: 0.05.sw);
  }


  Widget sliderWithPosition(BuildContext context) {
    final detailsCubit = context.read<DetailsCubit>();
    return Column(
      children: [
        ValueListenableBuilder<Duration>(
          valueListenable: detailsCubit.positionNotifier,
          builder: (_, position, __) => ValueListenableBuilder<Duration?>(
            valueListenable: detailsCubit.durationNotifier,
            builder: (_, duration, __) {
              final songDuration = duration ?? Duration.zero;
              final positionValue = position.inSeconds.toDouble();
              final double sliderValue = songDuration.inSeconds > 0
                  ? (positionValue <= songDuration.inSeconds.toDouble() ? positionValue : songDuration.inSeconds.toDouble())
                  : 0.0;
              return Slider(
                value: sliderValue,
                min: 0,
                max: songDuration.inSeconds.toDouble() > 0 ? songDuration.inSeconds.toDouble() : 1.0,
                onChanged: (value) {
                  detailsCubit.seekToPosition(Duration(seconds: value.toInt()));
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder<Duration>(
                valueListenable: detailsCubit.positionNotifier,
                builder: (_, position, __) => Text(formatDuration(position)),
              ),
              ValueListenableBuilder<Duration?>(
                valueListenable: detailsCubit.durationNotifier,
                builder: (_, duration, __) => Text(formatDuration(duration ?? Duration.zero)),
              ),
            ],
          ),
        ),
      ],
    );
  }


  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

}
