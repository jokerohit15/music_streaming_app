import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming_app/presentation/bloc/details/details_cubit.dart';

class PlayButtons extends StatefulWidget {
  const PlayButtons({super.key, required this.icon, this.isFromNowPlaying = false});

  final IconData icon;
  final bool isFromNowPlaying;

  @override
  State<PlayButtons> createState() => _PlayButtonsState();
}

class _PlayButtonsState extends State<PlayButtons> {
  late IconData _icon;

  @override
  void initState() {
    super.initState();
    _icon = widget.icon;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressButton(),
      icon: Icon(
        _icon,
        color: widget.isFromNowPlaying ? Theme.of(context).primaryColorLight :Theme.of(context).primaryColorDark,
        size: _icon == Icons.play_arrow || _icon == Icons.pause ?40 :22,
      ),
    );
  }

  void onPressButton() {
    _playPause();
    _forwardReverseButton();
    setState(() {});
  }

  void _playPause(){
    if (_icon == Icons.play_arrow) {
      context.read<DetailsCubit>().onPressPlayPauseButton(true);
      _icon = Icons.pause;
    } else if (_icon == Icons.pause) {
      _icon = Icons.play_arrow;
      context.read<DetailsCubit>().onPressPlayPauseButton(false);
    }
  }

  void _forwardReverseButton(){
    if(_icon == Icons.fast_forward_sharp)
      {
        context.read<DetailsCubit>().onForwardReverseButton(true);
      }
    else if(_icon == Icons.fast_rewind_sharp)
    {
      context.read<DetailsCubit>().onForwardReverseButton(false);
    }
  }

}
