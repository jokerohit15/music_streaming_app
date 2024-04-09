import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming_app/presentation/bloc/main/main_state.dart';

class MainCubit extends Cubit<MainState> {



  MainCubit() : super(MainInitial());


  int _currentIndex = 0;



  int get currentIndex => _currentIndex;


  void onTabTap(int index) {
   _currentIndex = index;
    emit(MainLoaded(
      currentIndex: _currentIndex,
    ));
  }


}
