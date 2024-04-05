import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';

class CircularIndicatorSliver extends StatelessWidget {
  const CircularIndicatorSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: 1,
                (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  0.2.sh.heightSizedBox,
                  SizedBox(
                      height: 0.1.sh,
                      width: 0.1.sh,
                      child: const CircularProgressIndicator()),
                ],
              );
            }));
  }
}
