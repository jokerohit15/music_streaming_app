import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:music_streaming_app/presentation/bloc/details/details_cubit.dart';

import 'package:mocktail/mocktail.dart';
import 'package:music_streaming_app/presentation/bloc/details/details_state.dart';
import 'package:music_streaming_app/presentation/pages/details_screen/widgets/play_buttons.dart';

class MockDetailsCubit extends MockCubit<DetailsState> implements DetailsCubit {}

void main() {
  late DetailsCubit detailsCubit;

  setUp(() {
    detailsCubit = MockDetailsCubit();
    when(() => detailsCubit.onPressPlayPauseButton(any())).thenAnswer((_) async {});
    when(() => detailsCubit.onForwardReverseButton(any())).thenAnswer((_) async {});
  });

  Widget makeTestableWidget({required IconData icon}) => MaterialApp(
    home: BlocProvider<DetailsCubit>(
      create: (context) => detailsCubit,
      child: Scaffold(
        body: PlayButtons(icon: icon),
      ),
    ),
  );

  testWidgets('Play button toggles play and pause icons correctly', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(icon: Icons.play_arrow));
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pumpAndSettle();

  });

}


class MyDocumentReference {
  final DocumentReference documentReference;

  MyDocumentReference({required this.documentReference});

  // Example method that uses the DocumentReference instance
  Future<void> addData(Map<String, dynamic> data) {
    return documentReference.set(data);
  }

}