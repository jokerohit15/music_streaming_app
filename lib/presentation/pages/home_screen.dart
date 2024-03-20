import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/app_constants/app_colors.dart';
import 'package:music_streaming_app/core/app_constants/app_images.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/core/service_locator.dart';
import 'package:music_streaming_app/core/theme/theme_provider.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_state.dart';
import 'package:music_streaming_app/presentation/bloc/main/main_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/main/main_state.dart';
import 'package:music_streaming_app/presentation/widgets/music_list.dart';
import 'package:music_streaming_app/presentation/widgets/theme_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BlocProvider<HomeCubit>(
      create: (context) => getIt<HomeCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        0.04.sh.heightSizedBox,
                        Text(StringConstants.hiUser,
                            style: textTheme.titleLarge),
                        0.01.sh.heightSizedBox,
                        Text(StringConstants.findYourMusicNow,
                            style: textTheme.titleMedium),
                      ],
                    ),
                    Expanded(child: 10.widthSizedBox),
                    Image.asset(
                      "assets/notifications.png",
                      width: 0.2.sw,
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.2.sh,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            return filterBox(context, index, textTheme);
                          },
                        );
                      }),
                ),
                BlocBuilder<MainCubit, MainState>(
                  builder: (context, state) {
                    if (state is MainLoaded) {
                      return Column(
                        children: [
                          MusicList(
                            title: StringConstants.monthlyHits,
                            songs: state.monthlyHits,
                          ),
                          MusicList(
                            title: StringConstants.lastPlayed,
                            songs: state.songList,
                          ),
                          MusicList(
                            title: "Party",
                            songs: state.monthlyHits,
                          ),
                          MusicList(
                            title: StringConstants.soothYourself,
                            songs: state.songList,
                          ),
                        ],
                      );
                    }
                    else if(state is MainError)
                      {
                        return Container(
                          width: 0.5.sw,
                          height: 0.1.sh,
                          color: Theme.of(context).primaryColor,
                          child: Text(state.errorMessage,style: Theme.of(context).textTheme.titleLarge!.copyWith(color:AppColors.redColor),),
                        );
                      }
                    else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                ThemeButton(
                  title: "sds",
                  onTap: () =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(),
                )
              ],
            ).paddingSymmetric(horizontal: 0.05.sw),
          ),
        ),
      ),
    );
  }

  Widget filterBox(BuildContext context, int index, TextTheme textTheme) {
    final bloc = context.read<HomeCubit>();
    return Column(
      children: [
        bloc.filterList[index].isActive
            ? Image.asset(
                AppImages.pandaLogo,
                height: 0.07.sh,
              )
            : SizedBox(height: 0.07.sh),
        GestureDetector(
          onTap: () => bloc.onPressFilter(index),
          child: Container(
            width: 0.2.sw,
            height: 0.04.sh,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: bloc.filterList[index].isActive
                  ? AppColors.brandColor
                  : AppColors.greyColor,
            ),
            child: Center(
              child: Text(
                bloc.filterList[index].title,
                style: textTheme.titleLarge!
                    .copyWith(color: AppColors.secondaryColor),
              ),
            ),
          ),
        ),
      ],
    ).paddingLTRB(right: 0.03.sw, top: 0.01.sh);
  }
}

