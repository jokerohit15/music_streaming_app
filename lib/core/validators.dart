
import 'package:music_streaming_app/core/app_constants/string_constants.dart';

class Validators{



  String? nameValidator(String name){
    if(name.isEmpty)
      {
        return StringConstants.nameErrorText;
      }
    else if(RegExp(r"[\d._%+-]").hasMatch(name))
      {
        return StringConstants.nameHasNumberSpecialCharError;
      }
    else{
      return null;
    }
  }


  String? emailValidator(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z\d._%+-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,4}$",
    );

    if (email.isEmpty) {
      return StringConstants.emailIsEmptyError;
    } else if (!emailRegex.hasMatch(email)) {
      return StringConstants.enterValidEmailError;
    } else {
      return null;
    }
  }

  String? passwordValidator(String password) {
    if (password.isEmpty) {
      return StringConstants.passwordCannotBeEmptyError;
    } else if (password.length < 8) {
      return StringConstants.passwordLengthError;
    } else if (!RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$")
        .hasMatch(password)) {
      return StringConstants.passwordValidationError;
    } else {
      return null; // The password is valid
    }
  }
}