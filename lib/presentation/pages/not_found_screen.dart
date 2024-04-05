import 'package:flutter/material.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(StringConstants.routeNotFound,style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}
