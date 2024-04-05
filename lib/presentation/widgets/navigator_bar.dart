import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/app_constants/app_colors.dart';
import 'package:music_streaming_app/core/app_constants/app_images.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/presentation/bloc/main/main_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/main/main_state.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({super.key});

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  @override
  Widget build(BuildContext context) {
    return elevated(context);
  }

  Widget elevated(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;
    return Container(
      height: isWideScreen ? null : 0.07.sh,
      margin: EdgeInsets.symmetric(
          horizontal: 0.05.widthSize(context),
          vertical: 0.01.heightSize(context)),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColorDark.withOpacity(0.2),
              offset: const Offset(0, -4),
            ),
            BoxShadow(
              color: Theme.of(context).primaryColorDark.withOpacity(0.2),
              offset: const Offset(0, 4),
            ),
          ]),
      child: isWideScreen
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                item(context, AppImages.homeNavIcon, StringConstants.home, 0),
                item(context, AppImages.searchNavIcon, StringConstants.search,
                    1),
                item(context, AppImages.profileNavIcon, StringConstants.profile,
                    2),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                item(context, AppImages.homeNavIcon, StringConstants.home, 0),
                item(context, AppImages.searchNavIcon, StringConstants.search,
                    1),
                item(context, AppImages.profileNavIcon, StringConstants.profile,
                    2),
              ],
            ),
    );
  }

  Widget item(BuildContext context, String icon, String title, int index) {
    return BlocBuilder<MainCubit, MainState>(builder: (context, state) {
      return GestureDetector(
        onTap: () => context.read<MainCubit>().onTabTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 0.1.widthSize(context),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.elliptical(0.3.sw, 0.25.sw)),
                color: context.read<MainCubit>().currentIndex == index
                    ?  AppColors.brandColor
                    : null,
              ),
              child: Image.asset(
                icon,
                height: context.read<MainCubit>().currentIndex == index
                    ? 0.04.sh
                    : 0.03.sh,
              ),
            ),
            Text(title,
                style: Theme.of(context).textTheme.bodySmall),
            Container(
           //   height: 0.03.heightSize(context),
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                color: context.read<MainCubit>().currentIndex == index
                    ? AppColors.brandColor
                    : null,
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 0.05.widthSize(context)),
      );
    });
  }
}
