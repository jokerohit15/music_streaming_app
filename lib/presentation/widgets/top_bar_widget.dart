import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/app_constants/app_images.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/core/theme/theme_provider.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_cubit.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(flex: 1, child: 0.04.sh.heightSizedBox),
              Expanded(
                child: Text(
                    StringConstants.hiUser + context.read<HomeCubit>().userName,
                    style: textTheme.titleLarge),
              ),
              Flexible(flex: 2, child: 0.01.sh.heightSizedBox),
              Expanded(
                  child: Text(StringConstants.findYourMusicNow,
                      style: textTheme.titleMedium)),
            ],
          ),
          Expanded(child: 10.widthSizedBox),
          Expanded(
            child: GestureDetector(
              onTap: () => context.read<ThemeProvider>().toggleTheme(),
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      AppImages.notificationsImage,
                      width: 0.2.widthSize(context),
                      cacheWidth: (0.2.widthSize(context)).toInt(),
                    ),
                  ),
                  Text("Change Theme",style: Theme.of(context).textTheme.titleLarge,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
