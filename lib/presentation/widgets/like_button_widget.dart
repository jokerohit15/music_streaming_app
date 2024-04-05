import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming_app/core/service_locator.dart';
import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/presentation/bloc/like_buton/like_button_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/like_buton/like_button_state.dart';
import 'package:music_streaming_app/presentation/bloc/main/main_cubit.dart';

class LikeButtonWidget extends StatelessWidget {
  const LikeButtonWidget(
      {super.key, required this.icon, required this.reference, required this.song});
  final SongModel song;
  final IconData icon;
  final DocumentReference reference;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LikeButtonCubit>(
      create: (context) => getIt<LikeButtonCubit>(),
      child:BlocBuilder<LikeButtonCubit, LikeButtonState>(
          builder: (context, state) {
            if (state is LikeButtonUpdate) {
              return IconButton(
                icon: Icon(state.icon, color: state.color,),
                onPressed: () {
                  context.read<LikeButtonCubit>().onPressLikeButton(
                      state.icon, context, reference, song);
                },
              );
            }
            return IconButton(
                icon: Icon(
                  icon, color: icon == Icons.favorite ? Colors.redAccent : Theme
                    .of(context)
                    .primaryColorDark,),
                onPressed: () {
                  context.read<LikeButtonCubit>().onPressLikeButton(
                      icon, context, reference,song);
                }
            );
          }
      ),
    );
  }
}
