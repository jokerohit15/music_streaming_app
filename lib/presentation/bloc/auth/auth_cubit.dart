

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming_app/domain/repositories/auth_repository.dart';
import 'package:music_streaming_app/domain/use_cases/check_authentication.dart';
import 'package:music_streaming_app/domain/use_cases/sign_out.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final CheckAuthentication checkAuthentication;
  final SignOut signOut;

  AuthCubit(this.checkAuthentication, this.signOut) : super(AuthInitial()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    bool isAuthenticated = await checkAuthentication();
    if (isAuthenticated) {
   //   User? user = await authRepository.currentUser();
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  void onTapSignOut(){
    signOut();
    emit(Unauthenticated());
  }
}
