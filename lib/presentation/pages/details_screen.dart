import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/app_constants/app_colors.dart';
import 'package:music_streaming_app/core/app_constants/app_images.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/core/theme/theme_provider.dart';
import 'package:music_streaming_app/presentation/widgets/icon_button_widget.dart';
import 'package:music_streaming_app/presentation/widgets/theme_button.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: 1.sw,
          height: 1.sh,
          padding: EdgeInsets.symmetric(horizontal: 0.15.sw, vertical: 0.0.sh),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: Column(
            children: [
              0.1.sh.heightSizedBox,
              BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Image.asset("assets/image.png")),
            ],
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(isDarkMode
                ? AppImages.blurredEllipseBlack
                : AppImages.blurredEllipseWhite)),
        Align(alignment: Alignment.bottomCenter, child: player(textTheme,isDarkMode)),
      ],
    ));
  }

  Widget player(TextTheme textTheme, bool isDarkMode) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Red Kamra",
                  style: textTheme.displayLarge,
                ),
                Text("Artist Name", style: textTheme.titleMedium),
              ],
            ),
            0.35.sw.widthSizedBox,
            IconButtonWidget(icon: Icons.favorite_border, isDark: isDarkMode),
          ],
        ).paddingSymmetric(horizontal: 0.05.sw),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButtonWidget(icon: Icons.shuffle, isDark: isDarkMode),
            0.17.sw.widthSizedBox,
            IconButtonWidget(icon: Icons.fast_rewind, isDark: isDarkMode),
            IconButtonWidget(icon: Icons.play_arrow, isDark: isDarkMode),
            IconButtonWidget(
                icon: Icons.fast_forward_sharp, isDark: isDarkMode),
            0.16.sw.widthSizedBox,
            IconButtonWidget(icon: Icons.repeat_one, isDark: isDarkMode),
          ],
        ).paddingSymmetric(horizontal: 0.016.sw),
        const Player(),
      ],
    );
  }
}
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//               child: Image.asset("assets/image.png")),
//         ],
//       ),
//     );
//   }
// }
// Stack(
// // fit: StackFit.expand,
// children: <Widget>[
// // Artist Image
// Image.asset("assets/image.png",width: 1.sw),
// // Apply BackdropFilter
// Align(
// alignment: Alignment.center,
// child: BackdropFilter(
// filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
// child: Image.asset("assets/image.png",width: 0.2.sw,),// This is a transparent container
// ),
// ),
// ],
// ),

class Player extends StatelessWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        CustomPaint(
          size: const Size(500, 30), // You can give any size to CustomPaint
          painter: WaveformPainter(color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: CustomPaint(
            size: const Size(500, 70), // You can give any size to CustomPaint
            painter: WaveformPainter(color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor),
          ),
        ),
      ],
    );
  }
}

class WaveformPainter extends CustomPainter {
  final Color color;

  WaveformPainter({super.repaint, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    var path = Path();

    // Assuming you want to draw the waveform as shown in the picture
    // This is a simple two-point waveform for example purposes
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
        size.width / 4,
        size.height, // Control point
        size.width / 2,
        size.height / 2 // End point
        );
    path.quadraticBezierTo(
        size.width * 3 / 4,
        0, // Control point
        size.width,
        size.height / 2 // End point
        );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
