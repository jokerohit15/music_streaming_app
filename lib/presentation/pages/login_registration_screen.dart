import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/app_constants/app_images.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/presentation/bloc/login_registration/login_registration_cubit.dart';
import 'package:music_streaming_app/presentation/routes/app_routes.dart';
import 'package:music_streaming_app/presentation/widgets/theme_button.dart';

class LoginRegistrationScreen extends StatelessWidget {
  const LoginRegistrationScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<LoginRegistrationCubit, LoginRegistrationState>(
          listener: (context, state) {
            if (state is LoginRegistrationSuccess) {
              context.navigateTo(AppRoutes.main, null);
            } else if (state is LoginRegistrationFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: context.read<LoginRegistrationCubit>().formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  0.05.sh.heightSizedBox,
                  Image.asset(AppImages.pandaLogo,cacheHeight: 0.2.sh.toInt()
                  ),
                  Text(
                    StringConstants.appTitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 50),
                  ),
                  Text(
                    StringConstants.appSubtitle,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  nameField(context),
                  field(true, context),
                  field(false, context),
                  BlocBuilder<LoginRegistrationCubit, LoginRegistrationState>(
                      builder: (context, state) {
                        bool isLogin = context.read<LoginRegistrationCubit>().isLogin;
                      return Column(
                        children: [
                          ThemeButton(
                            title: isLogin
                                ? StringConstants.login
                                : StringConstants.register,
                            onTap: () => context
                                .read<LoginRegistrationCubit>()
                                .onTapThemeButton(isLogin),
                          ),
                          0.02.sh.heightSizedBox,
                          TextButton(
                              onPressed: () => context
                                  .read<LoginRegistrationCubit>()
                                  .onTapTextButton(),
                              child: Text(
                                isLogin
                                    ? StringConstants.registerAsANewUser
                                    : StringConstants.loginAsAnOldUser,
                                style: Theme.of(context).textTheme.titleLarge,
                              )),
                          isLogin?
                          Image.asset(AppImages.pandaListImage,cacheWidth: 1.sw.toInt(),
                          )
                          : const SizedBox.shrink(),
                        ],
                      );
                  }),
                ],
              ).paddingSymmetric(horizontal: 0.05.sw),
            ),
          )),
    );
  }

  Widget field(bool isEmail, BuildContext context) {
    return TextFormField(
      validator: (_) => isEmail
          ? context.read<LoginRegistrationCubit>().emailValidator()
          : context.read<LoginRegistrationCubit>().passwordValidator(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: isEmail
          ? context.read<LoginRegistrationCubit>().emailController
          : context.read<LoginRegistrationCubit>().passwordController,
      obscureText: !isEmail,
      decoration: InputDecoration(
        hintText: isEmail ? StringConstants.emailHint : StringConstants.passwordHint,
      ),
    ).paddingSymmetric(vertical: 0.02.sh);
  }

  Widget nameField(BuildContext context) {
    return BlocBuilder<LoginRegistrationCubit, LoginRegistrationState>(
        builder: (context, state) {
    return  context.read<LoginRegistrationCubit>().isLogin
        ? const SizedBox.shrink()
      : TextFormField(
                validator: (_) =>
                    context.read<LoginRegistrationCubit>().nameValidator(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller:
                    context.read<LoginRegistrationCubit>().nameController,
                decoration: const InputDecoration(
                  hintText: StringConstants.nameHintText,
                ),
              ).paddingSymmetric(vertical: 0.02.sh);

    });
  }
}
