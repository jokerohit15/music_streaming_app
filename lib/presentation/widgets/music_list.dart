import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_cubit.dart';
import 'package:music_streaming_app/presentation/pages/details_screen/details_screen.dart';

class MusicList extends StatefulWidget {
  const MusicList({super.key, required this.title, required this.songs});

  final String title;
  final List<SongModel> songs;

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  final ScrollController _scrollController = ScrollController();
  late bool isSoothYourself;
  late  bool isLastPlayed;

  @override
  void initState() {
    super.initState();
    isSoothYourself = widget.title == StringConstants.soothYourself;
     isLastPlayed = widget.title == StringConstants.lastPlayed;
    isSoothYourself || isLastPlayed ? _scrollController.addListener(_onScroll) : null;
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final thresholdReached = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent;
    if (thresholdReached) {
      context.read<HomeCubit>().onPageNation();
    }
  }

  @override
  void dispose() {
    isSoothYourself  ||  isLastPlayed ? _scrollController.removeListener(_onScroll) : null;
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    double boxHeight =
        widget.title == StringConstants.lastPlayed || isSoothYourself
            ? 0.25.heightSize(context)
            : 0.2.heightSize(context);
    double itemBaseWidth =
        widget.title == StringConstants.lastPlayed ? 0.3.widthSize(context) : 0.16.widthSize(context);


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: textTheme.titleLarge),
        0.02.sh.heightSizedBox,
        SizedBox(
          height: boxHeight,
          child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.songs.length,
              itemBuilder: (context, index) {
                final int leftmostIndex =
                    (_scrollController.offset / (itemBaseWidth.floor()))
                        .floor();
                final bool isLeftmost = index == leftmostIndex;
                double dynamicWidth = isSoothYourself
                    ? isLeftmost
                        ? itemBaseWidth * 2
                        : itemBaseWidth
                    : itemBaseWidth;
                return songBox(
                    isSoothYourself,
                    dynamicWidth,
                    textTheme,
                    context,
                    widget.songs[index]);
              }),
        ),
      ],
    );
  }

  Widget songBox(bool isSoothYourself, double dynamicSize, TextTheme textTheme,
      BuildContext context, SongModel song) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsScreen(
                  song: song,
                  title: widget.title,
                )),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isSoothYourself
              ? Expanded(
                  child: 1.heightSizedBox,
                )
              : const SizedBox.shrink(),
          Hero(
            tag: song.name + widget.title,
            child: Container(
              width: dynamicSize,
              height: dynamicSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(song.albumArt),
                  fit: BoxFit.cover,
                ),
                color: Theme.of(context).primaryColor,
                borderRadius: widget.title == StringConstants.monthlyHits
                    ? null
                    : BorderRadius.circular(4),
                shape: widget.title == StringConstants.monthlyHits
                    ? BoxShape.circle
                    : BoxShape.rectangle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                song.name,
                style: textTheme.titleLarge,
              ),
              Text(song.artist.first,
                  style: textTheme.titleMedium!.copyWith(fontSize: 10)),
            ],
          ),
        ],
      ).paddingLTRB(right: 0.05.widthSize(context)),
    );
  }
}
