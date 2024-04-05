


import 'package:flutter/material.dart';

abstract class LikeButtonState{

}
class LikeButtonInitial extends LikeButtonState {}
class LikeButtonUpdate extends LikeButtonState{
  final Color color;
  final IconData icon;
  LikeButtonUpdate(this.color, this.icon);
}
