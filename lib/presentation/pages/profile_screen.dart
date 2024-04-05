import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/app_constants/app_colors.dart';
import 'package:music_streaming_app/core/app_constants/app_images.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/core/theme/theme_provider.dart';
import 'package:music_streaming_app/presentation/bloc/auth/auth_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeCubit>();
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 0.4.widthSize(context),
            height: 0.4.widthSize(context),
            margin: EdgeInsets.symmetric(vertical: 0.05.heightSize(context)),
            padding: EdgeInsets.all(0.05.widthSize(context)),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              boxShadow:  [
                BoxShadow(
                  offset: const Offset(0, 4),
                  spreadRadius: 4,
                  blurRadius: 4,
                  color:  context.read<ThemeProvider>().isDarkMode  ? Theme.of(context).primaryColorLight : AppColors.greyColor,
                )
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(AppImages.profileDp),
          ),
          listTile(const Icon(Icons.person,color: AppColors.indicatorColor,), "User", homeBloc.userName, context),
          listTile(const Icon(Icons.music_note,color: AppColors.brandColor,), "All Songs", homeBloc.songs.length.toString(), context),
          listTile(const Icon(Icons.local_fire_department_outlined,color: Colors.yellow), StringConstants.monthlyHits, homeBloc.monthlyHits.length.toString(), context),
          listTile(const Icon(Icons.favorite,color: AppColors.redColor), StringConstants.likedSongs, homeBloc.likedSongs.length.toString(), context),
          listTile(const Icon(Icons.logout,color: AppColors.secondaryColor), StringConstants.logout, "", context),
        ],
      ).paddingSymmetric(horizontal: 0.05.sw),
    );
  }

  Widget listTile(Icon icon, String title, String count, BuildContext context) {
    return GestureDetector(
      onTap: () => title == StringConstants.logout ?   context.read<AuthCubit>().onTapSignOut() : null,
      child: Container(
        width: 1.0.widthSize(context),
        height: 0.1.heightSize(context),
        margin: EdgeInsets.symmetric(vertical: 0.01.heightSize(context)),
        padding: EdgeInsets.all(0.05.widthSize(context)),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          boxShadow:  [
            BoxShadow(
              offset: const Offset(0, 4),
              spreadRadius: 4,
              blurRadius: 4,
              color: context.read<ThemeProvider>().isDarkMode  ? Theme.of(context).primaryColorLight : AppColors.greyColor,
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            icon,
            0.05.widthSize(context).widthSizedBox,
            Text(title, style: Theme.of(context).textTheme.titleLarge),
           Expanded(child: 1.heightSizedBox),
            Text(
              count,
              style:
                  Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
