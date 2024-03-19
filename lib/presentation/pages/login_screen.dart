import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/app_constants/app_images.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/core/service_locator.dart';
import 'package:music_streaming_app/presentation/bloc/login/login_cubit.dart';
import 'package:music_streaming_app/presentation/widgets/theme_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            0.1.sh.heightSizedBox,
            Image.asset(AppImages.pandaLogo),
            0.1.sh.heightSizedBox,
            field(true, context),
            field(false, context),
            ThemeButton(title: StringConstants.login,onTap:() => context.read<LoginCubit>().login() ,),
            Expanded(child: 10.heightSizedBox),
            Image.asset(AppImages.pandaListImage),
          ],
        ).paddingSymmetric(horizontal: 0.05.sw)
      ),
    );
  }

  Widget field(bool isEmail, BuildContext context) {
    return TextFormField(
      validator: (_) => isEmail
          ? context.read<LoginCubit>().emailValidator()
          : context.read<LoginCubit>().passwordValidator(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: isEmail
          ? context.read<LoginCubit>().emailController
          : context.read<LoginCubit>().passwordController,
      obscureText: !isEmail,
      decoration: InputDecoration(
        hintText: isEmail ? StringConstants.email : StringConstants.password,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ).paddingSymmetric(vertical: 0.02.sh);
  }
}
