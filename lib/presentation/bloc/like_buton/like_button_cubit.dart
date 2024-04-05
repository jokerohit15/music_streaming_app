


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/domain/use_cases/get_user.dart';
import 'package:music_streaming_app/domain/use_cases/toggle_favourite_status.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/like_buton/like_button_state.dart';
import 'package:music_streaming_app/presentation/bloc/search/search_cubit.dart';

class LikeButtonCubit extends Cubit<LikeButtonState>{
  LikeButtonCubit({required this.toggleFavouriteStatus,required this.getUser}):super(LikeButtonInitial());
  final ToggleFavouriteStatus toggleFavouriteStatus;
  final GetUser getUser;


  void onPressLikeButton(IconData icon,BuildContext context,DocumentReference reference,SongModel song){
    List<SongModel> songs = context.read<HomeCubit>().songs;
    if (icon == Icons.favorite_border) {
      _toggleFavourite(true, reference);
      for(var sung in songs)
        {
          sung.name == song.name ? song.isLiked = true : null;
        }
      emit(LikeButtonUpdate(Colors.redAccent, Icons.favorite));
    } else  {
      print("nahi aaaya");
      _toggleFavourite(false, reference);
      for(var sung in songs)
      {
        sung.name == song.name ? song.isLiked = false : null;
      }
      emit(LikeButtonUpdate(Theme.of(context).primaryColorDark, Icons.favorite_border));
    }
  }

  Future<void> _toggleFavourite(bool isLiked, DocumentReference reference) async {
    User? user = await getUser();
    if(user != null)
    {
      toggleFavouriteStatus.call(user.uid,isLiked, reference);
    }
    else {
      debugPrint("User not found");
    }

  }

}