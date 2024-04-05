import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/app_constants/app_colors.dart';
import 'package:music_streaming_app/core/app_constants/app_images.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/core/service_locator.dart';
import 'package:music_streaming_app/core/theme/theme_provider.dart';
import 'package:music_streaming_app/data/models/music_list_model.dart';
import 'package:music_streaming_app/presentation/bloc/auth/auth_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_state.dart';
import 'package:music_streaming_app/presentation/widgets/circular_indicator_sliver.dart';
import 'package:music_streaming_app/presentation/widgets/music_list.dart';
import 'package:music_streaming_app/presentation/widgets/sliver_error_widget.dart';
import 'package:music_streaming_app/presentation/widgets/top_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return  CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          surfaceTintColor: Colors.transparent,
          expandedHeight: 0.27.heightSize(context),
          collapsedHeight: 0.15.heightSize(context),
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              var top = constraints.biggest.height;
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (top > 100)
                          const TopBarWidget(),
                        SizedBox(
                          height: 0.15.sh,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return BlocBuilder<HomeCubit, HomeState>(
                                  builder: (context, state) {
                                    return filterBox(
                                        context, index, textTheme);
                                  },
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        musicList(),
      ],
    ).paddingSymmetric(horizontal: 0.05.widthSize(context));
  }

  Widget musicList() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
         return context.read<HomeCubit>().giveTab(state);
        } else if (state is HomeError) {
          return SliverErrorWidget(message: state.errorMessage);
        } else {
          return const CircularIndicatorSliver();
        }
      },
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
                cacheHeight: (0.7.sh).toInt(),
              )
            : SizedBox(height: 0.07.sh),
        GestureDetector(
          onTap: () => bloc.onPressFilter(index),
          child: Container(
            width: 0.2.widthSize(context),
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
                style:
                    textTheme.titleLarge!.copyWith(color: AppColors.blackColor),
              ),
            ),
          ),
        ),
      ],
    ).paddingLTRB(right: 0.03.sw, top: 0.01.sh);
  }
}
