

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming_app/domain/use_cases/sign_in_with_email_and_password.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SignInWithEmailAndPassword signInWithEmailAndPassword;

  LoginCubit(this.signInWithEmailAndPassword) : super(LoginInitial());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  get emailController => _emailController;
  get passwordController => _passwordController;


  Future<void> login() async {
    emit(LoginLoading());
    try {
      await signInWithEmailAndPassword(_emailController.text, _passwordController.text);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }


  String? emailValidator() {
    final emailRegex = RegExp(
      r"^[a-zA-Z\d._%+-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,4}$",
    );

    if (_emailController.text.isEmpty) {
      return 'Email cannot be empty';
    } else if (!emailRegex.hasMatch(_emailController.text)) {
      return 'Enter a valid email address';
    } else {
      return null; // The email is valid
    }
  }

  String? passwordValidator() {
    if (_passwordController.text.isEmpty) {
      return 'Password cannot be empty';
    } else if (_passwordController.text.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$")
        .hasMatch(_passwordController.text)) {
      return 'Password must contain a letter and a number';
    } else {
      return null; // The password is valid
    }
  }



}

