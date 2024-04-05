import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming_app/core/app_constants/app_keys.dart';
import 'package:music_streaming_app/core/validators.dart';
import 'package:music_streaming_app/domain/use_cases/create_user_with_email_and_password.dart';
import 'package:music_streaming_app/domain/use_cases/get_user.dart';
import 'package:music_streaming_app/domain/use_cases/save_user_data.dart';
import 'package:music_streaming_app/domain/use_cases/sign_in_with_email_and_password.dart';

part 'login_registration_state.dart';

class LoginRegistrationCubit extends Cubit<LoginRegistrationState> {
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  final CreateUserWithEmailAndPassword createUserWithEmailAndPassword;
  final SaveUserData saveUserData;
  final GetUser getUser;

  LoginRegistrationCubit(this.signInWithEmailAndPassword,
      this.createUserWithEmailAndPassword, this.saveUserData, this.getUser)
      : super(LoginRegistrationInitial(isLogin: true));

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey _formKey = GlobalKey();
  bool isLogin = true;

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get nameController => _nameController;

  GlobalKey get formKey => _formKey;

  void onTapThemeButton(bool isLogin) {
    emit(LoginRegistrationLoading());
    isLogin ? _login() : _register();
  }

  Future<void> _login() async {
    try {
      await signInWithEmailAndPassword(
          _emailController.text, _passwordController.text);
      emit(LoginRegistrationSuccess());
    } catch (e) {
      emit(LoginRegistrationFailure(e.toString()));
    }
  }

  Future<void> _register() async {
    try {
      await createUserWithEmailAndPassword(
          _emailController.text, _passwordController.text);
      User? user = await getUser();
      if (user != null) {
        await saveUserData(
          {
            AppKeys.nameKey: _nameController.text,
            AppKeys.emailKey: _emailController.text,
          },
          user.uid,
        );
      }
      emit(LoginRegistrationSuccess());
    } catch (e) {
      emit(LoginRegistrationFailure(e.toString()));
    }
  }

  void onTapTextButton() {
    isLogin = !isLogin;
    emit(LoginRegistrationInitial(isLogin: isLogin));
  }

  String? emailValidator() {
    return Validators().emailValidator(_emailController.text);
  }

  String? passwordValidator() {
    return Validators().passwordValidator(_passwordController.text);
  }

  String? nameValidator() {
    return Validators().nameValidator(_nameController.text);
  }

  @override
  Future<void> close() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    return super.close();
  }
}
