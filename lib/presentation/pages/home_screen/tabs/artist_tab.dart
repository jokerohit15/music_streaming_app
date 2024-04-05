import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';

class ArtistTab extends StatelessWidget {
  const ArtistTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: 1,
                (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  0.2.sh.heightSizedBox,
                  Text("We are yet to work on this",style: Theme.of(context).textTheme.displayLarge,),
                ],
              );
            }));
  }
}
