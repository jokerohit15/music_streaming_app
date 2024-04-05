import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/service_locator.dart';
import 'package:music_streaming_app/core/theme/theme_provider.dart';
import 'package:music_streaming_app/presentation/bloc/auth/auth_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/details/details_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_cubit.dart';
import 'package:music_streaming_app/presentation/routes/app_routes.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCXY82vZFf29gvWF6QiSWlTEoaGj2qhodU",
          authDomain: "practice-projects-7c9bf.firebaseapp.com",
          projectId: "practice-projects-7c9bf",
          storageBucket: "practice-projects-7c9bf.appspot.com",
          messagingSenderId: "48580419363",
          appId: "1:48580419363:web:4916330dbe35bf9b7b3696",
          measurementId: "G-XVKCBC5TN1"),
    );
    await FirebaseFirestore.instance
        .enablePersistence(const PersistenceSettings(synchronizeTabs: false))
        .catchError((e) {
      if (e.code == 'failed-precondition') {
        // Multiple tabs open, persistence can only be enabled
        // in one tab at a time.
        // ...
      } else if (e.code == 'unimplemented') {
        // The current browser does not support all of the
        // features required to enable persistence.
        // ...
      }
    });
    FirebaseFirestore.instance.settings.persistenceEnabled;
  } else {
    await Firebase.initializeApp();
  }
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.settings = const Settings(persistenceEnabled: true);
  setupLocator();
  runApp(
    ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return const MyApp();
        }),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => getIt<HomeCubit>()..initCall(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<ThemeProvider>()..assignTheme(context),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => getIt<AuthCubit>(),
        ),
        BlocProvider<DetailsCubit>(
          create: (context) => getIt<DetailsCubit>(),
        ),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
        return MaterialApp(
          theme: themeProvider.currentTheme,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      }),
    );
  }
}

//
// class GenreTile extends StatelessWidget {
//   final String genre;
//
//   const GenreTile({required this.genre});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey[850],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Center(
//         child: Text(
//           genre,
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: AudioPlayerScreen(),
//     );
//   }
// }
//
// class AudioPlayerScreen extends StatefulWidget {
//   @override
//   _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
// }
//
// class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
//   late AudioPlayer _audioPlayer;
//   late ValueNotifier<Duration> _positionNotifier;
//   Duration _duration = Duration.zero;
//
//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer = AudioPlayer();
//     _positionNotifier = ValueNotifier<Duration>(Duration.zero);
//     _initializeAudio();
//   }
//
//   Future<void> _initializeAudio() async {
//     // Load your audio source and prepare the player
//     try {
//       await _audioPlayer.setUrl('https://firebasestorage.googleapis.com/v0/b/practice-projects-7c9bf.appspot.com/o/songs%2Fmp3%2FMan%20In%20The%20Mirror.mp3?alt=media&token=7f0f15c1-2751-4291-9d27-2aa73135cc63');
//       _duration = await _audioPlayer.duration ?? Duration.zero;
//       // Listen to audio player position changes
//       _audioPlayer.positionStream.listen((position) {
//         _positionNotifier.value = position;
//       });
//     } catch (e) {
//       print("Error loading audio source: $e");
//     }
//   }
//
//   @override
//   void dispose() {
//     _positionNotifier.dispose();
//     _audioPlayer.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Custom Waveform Audio Player'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: WaveformProgressBar(
//               duration: _duration,
//               positionNotifier: _positionNotifier,
//               onSeek: (newPosition) {
//                 _audioPlayer.seek(newPosition);
//               },
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.play_arrow),
//             onPressed: () {
//               _audioPlayer.play();
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.pause),
//             onPressed: () {
//               _audioPlayer.pause();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class WaveformProgressBar extends StatelessWidget {
//   final Duration duration;
//   final ValueNotifier<Duration> positionNotifier;
//   final Function(Duration) onSeek;
//
//   const WaveformProgressBar({
//     Key? key,
//     required this.duration,
//     required this.positionNotifier,
//     required this.onSeek,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onHorizontalDragUpdate: (details) {
//         final RenderBox box = context.findRenderObject() as RenderBox;
//         final Offset localOffset = box.globalToLocal(details.localPosition);
//         final double progress = localOffset.dx / box.size.width;
//         final Duration newPosition = Duration(
//           milliseconds: (duration.inMilliseconds * progress).clamp(0, duration.inMilliseconds).toInt(),
//         );
//         onSeek(newPosition);
//       },
//       child: ValueListenableBuilder<Duration>(
//         valueListenable: positionNotifier,
//         builder: (_, position, __) {
//           print(positionNotifier.value);
//           print(position.inMilliseconds);
//           return CustomPaint(
//             painter: WaveformPainter(
//               color: Colors.blue,
//               progress: position.inMilliseconds / duration.inMilliseconds,
//             ),
//             size: Size(double.infinity, 50),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class WaveformPainter extends CustomPainter {
//   final Color color;
//   final double progress;
//
//   WaveformPainter({required this.color, required this.progress});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Paint for the background waveform
//     var backgroundPaint = Paint()
//       ..color = color.withOpacity(0.3) // Lighter color for the background
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.stroke;
//
//     // Paint for the progress waveform
//     var progressPaint = Paint()
//       ..color = color // Original color for the progress
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.stroke;
//
//     var path = Path();
//
//     // Draw the entire waveform as the background
//     path.moveTo(0, size.height / 2);
//     path.quadraticBezierTo(
//         size.width / 4, 0, // Control point
//         size.width / 2, size.height / 2); // End point
//     path.quadraticBezierTo(
//         size.width * 3 / 4, size.height, // Control point
//         size.width, size.height / 2); // End point
//     canvas.drawPath(path, backgroundPaint);
//
//     // Create a new path for the progress portion of the waveform
//     var progressPath = Path();
//     double progressWidth = size.width * progress;
//     if (progressWidth <= size.width / 4) {
//       // Only in the first quarter of the waveform
//       double controlPointX = progressWidth * 4;
//       double endPointX = progressWidth * 2;
//       progressPath.moveTo(0, size.height / 2);
//       progressPath.quadraticBezierTo(
//           controlPointX / 2, 0, // Control point adjusted for progress
//           endPointX, size.height / 2); // End point adjusted for progress
//     } else if (progressWidth <= size.width / 2) {
//       // Up to halfway of the waveform
//       progressPath.moveTo(0, size.height / 2);
//       progressPath.quadraticBezierTo(
//           size.width / 4, 0,
//           size.width / 2, size.height / 2);
//       // Add more logic here if progress is beyond the first half
//       // This is simplified for demonstration
//     }
//     // You can extend this with more detailed logic to cover the entire waveform
//
//     canvas.drawPath(progressPath, progressPaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
