import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/app_constants/app_colors.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/presentation/pages/details_screen.dart';

class MusicList extends StatefulWidget {
  const MusicList({super.key, required this.title});
final String title;
  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    bool isSoothYourself = widget.title == StringConstants.soothYourself ? true : false;
    double boxHeight = widget.title == StringConstants.lastPlayed || isSoothYourself ? 0.23.sh : 0.2.sh;
    double itemBaseWidth = widget.title == StringConstants.lastPlayed ? 0.3.sw : 0.16.sw;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text( widget.title, style: textTheme.titleLarge),
        0.02.sh.heightSizedBox,
        SizedBox(
          height: boxHeight,
          child: ListView.builder(
            controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                final int leftmostIndex = (_scrollController.offset * 0.85 / itemBaseWidth).floor();
                final bool isLeftmost = index == leftmostIndex;
                double dynamicSize = isSoothYourself ? isLeftmost ? itemBaseWidth *2 : itemBaseWidth: itemBaseWidth;
                return songBox(isSoothYourself, dynamicSize, textTheme,context);
              }),
        ),
      ],
    );
  }

  Widget songBox(bool isSoothYourself,double dynamicSize, TextTheme textTheme,BuildContext context){
    return GestureDetector(
      onTap: ()=> Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DetailsScreen()),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isSoothYourself
              ? Expanded(
            child: 1.heightSizedBox,
          )
              : const SizedBox.shrink(),
          Container(
            width: dynamicSize,
            height: dynamicSize,
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius:  widget.title == StringConstants.monthlyHits
                  ? null
                  : BorderRadius.circular(4),
              shape:  widget.title == StringConstants.monthlyHits
                  ? BoxShape.circle
                  : BoxShape.rectangle,
            ),
          ),
          Text(
            "Raju ki cha",
            style: textTheme.titleLarge,
          ),
          Text("Albert",
              style: textTheme.titleMedium!.copyWith(fontSize: 10))
        ],
      ).paddingLTRB(right: 0.05.sw),
    );
  }
}
