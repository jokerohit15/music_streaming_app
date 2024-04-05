import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/app_constants/app_colors.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key, required this.title, this.onTap});
final String title;
final void Function()?  onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0.2.sw,vertical: 0.02.sh),
        margin: EdgeInsets.symmetric(horizontal: 0.1.sw,vertical: 0.02.sh),
       decoration:  BoxDecoration(
         borderRadius: BorderRadius.circular(12),
         color: AppColors.brandColor
       ),
        child: Text(title,style: const TextStyle(color:AppColors.secondaryColor,fontSize: 15,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
