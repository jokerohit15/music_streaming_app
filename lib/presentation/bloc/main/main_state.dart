


abstract class MainState{}



class MainInitial extends MainState{}


class MainLoading extends MainState{}

class MainLoaded extends MainState{

  final int currentIndex;


  MainLoaded({required this.currentIndex});
  }




class MainError extends MainState{
  final String errorMessage;

  MainError({required this.errorMessage});
}