import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/presentation/bloc/details/details_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_streaming_app/presentation/bloc/details/details_state.dart';

import 'play_button_widget_test.dart';

class MockAudioPlayer extends Mock implements AudioPlayer  {}
class MockDocumentReference extends Mock implements MyDocumentReference {}




void main() {
  late DetailsCubit cubit;
  late AudioPlayer audioPlayer;
  late DocumentReference mockReference;

  setUp(() {
    audioPlayer = MockAudioPlayer();
    cubit = DetailsCubit();
    mockReference = MockDocumentReference() as DocumentReference<Object?>;
  });

  group('DetailsCubit', () {
    final songModel = SongModel(
      name: "Test Song",
      albumArt: "https://example.com/album_art.jpg",
      audio: "https://example.com/audio.mp3",
      artist: ["Test Artist"],
      album: "Test Album",
      reference: mockReference, // Assuming DocumentReference or similar
      yearOfRelease: 2020,
    );

    test('initial state is DetailsInitial', () {
      expect(cubit.state, equals(DetailsInitial()));
    });

    blocTest<DetailsCubit, DetailsState>(
      'emits [DetailsLoaded] when audio is initialized',
      build: () => cubit,
      act: (cubit) => cubit.initialize(songModel),
      expect: () => isA<DetailsLoaded>(),
    );

    blocTest<DetailsCubit, DetailsState>(
      'emits [DetailsFailure] when audio initialization fails',
      setUp: () {
        when(() => audioPlayer.setUrl(any())).thenThrow(Exception("Failed to load"));
      },
      build: () => cubit,
      act: (cubit) => cubit.initialize(songModel),
      expect: () => isA<DetailsFailure>(),
    );
  });
}
