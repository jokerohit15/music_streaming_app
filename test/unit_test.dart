import "package:equatable/equatable.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';


abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object?> get props => [];
}

class MainInitial extends MainState {}

class MainLoaded extends MainState {
  final int currentIndex;

  const MainLoaded({required this.currentIndex});

  @override
  List<Object?> get props => [currentIndex];
}


class MainCubit extends Cubit<MainState> {
  MainCubit() : super( MainInitial());

  void onTabTap(int index) {
    emit(MainLoaded(currentIndex: index));
  }
}


void main() {
  group('MainCubit', () {
    blocTest<MainCubit, MainState>(
      'emits [MainLoaded] with updated index on onTabTap',
      build: () => MainCubit(),
      act: (cubit) => cubit.onTabTap(1),
      expect: () => [const MainLoaded(currentIndex: 1)],
    );

    blocTest<MainCubit, MainState>(
      'emits [MainLoaded] with updated index multiple times on multiple onTabTap',
      build: () => MainCubit(),
      act: (cubit) {
        cubit.onTabTap(1);
        cubit.onTabTap(2);
      },
      expect: () => [
        const MainLoaded(currentIndex: 1),
        const MainLoaded(currentIndex: 2),
      ],
    );
  });
}
