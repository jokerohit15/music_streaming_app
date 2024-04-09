import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/presentation/bloc/details/details_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/details/details_state.dart';
import 'package:music_streaming_app/presentation/pages/details_screen/widgets/play_buttons.dart';

class NowPlayingWidget extends StatelessWidget {
  const NowPlayingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return     BlocBuilder<DetailsCubit, DetailsState>
      (builder: (context, state) {
        if(state is DetailsLoaded)
          {
            return Container(
              margin: EdgeInsets.fromLTRB(0.06.widthSize(context), 0,
                  0.06.widthSize(context), 0.013.heightSize(context)),
              width: 1.sw,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: buttonRow(true, context,state.song),
            );
          }
        else{
          return const SizedBox.shrink();
        }
      }
    );
  }

  Widget buttonRow(bool isDarkMode, BuildContext context,List<String> song) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 0.08.heightSize(context),
          width: 0.08.heightSize(context),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12)),
            image: DecorationImage(
              image: CachedNetworkImageProvider(song[1])
            )
          ),
        ),
        Expanded(child: 0.1.sw.widthSizedBox),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            0.01.heightSize(context).heightSizedBox,
          Text(song[0],style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).primaryColorLight,),),
          Text(song.last,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).primaryColorLight),),
          ],
        ),
        Expanded(child: 0.1.sw.widthSizedBox),
        const PlayButtons(icon: Icons.fast_rewind_sharp,isFromNowPlaying: true),
        const PlayButtons(icon: Icons.pause,isFromNowPlaying: true),
        const PlayButtons(icon: Icons.fast_forward_sharp,isFromNowPlaying: true),
      ],
    );
  }
}
