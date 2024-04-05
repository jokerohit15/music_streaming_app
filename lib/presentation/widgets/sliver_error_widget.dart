import 'package:flutter/material.dart';
import 'package:music_streaming_app/core/app_constants/app_colors.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';

class SliverErrorWidget extends StatelessWidget {
  const SliverErrorWidget({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: 1,
                (BuildContext context, int index) {
              return Container(
                width: 0.5.widthSize(context),
                height: 0.1.heightSize(context),
                color: Theme
                    .of(context)
                    .primaryColor,
                child: Text(
                 message,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: AppColors.redColor),
                ),
              );
            }));
  }
}
