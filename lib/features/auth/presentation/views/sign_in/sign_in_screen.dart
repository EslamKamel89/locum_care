// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/heleprs/validator.dart';
import 'package:locum_care/core/router/app_routes_names.dart';
import 'package:locum_care/core/widgets/auth_text_form_field.dart';
import 'package:locum_care/core/widgets/default_screen_padding.dart';
import 'package:locum_care/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:locum_care/utils/styles/styles.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _collectData() => {
    "email": _emailController.text,
    "password": _passwordController.text,
  };
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        final controller = context.read<SignInCubit>();
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: DefaultScreenPadding(
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      txt(
                        "Welcome Back!",
                        e: St.bold25,
                        textAlign: TextAlign.center,
                        c: context.secondaryHeaderColor,
                      ),
                      const SizedBox(height: 10),
                      txt(
                        "Sign in to continue",
                        e: St.reg16,
                        c: Colors.grey,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      AuthTextFormField(
                        controller: _emailController,
                        labelText: "Email Address",
                        prefixIcon: Icons.email_outlined,
                        validator: (String? value) {
                          return valdiator(
                            input: value,
                            label: 'Email',
                            isRequired: true,
                            minChars: 5,
                            maxChars: 50,
                            isEmail: true,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      AuthTextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        labelText: "Password",
                        prefixIcon: Icons.lock_outline,
                        validator: (String? value) {
                          return valdiator(
                            input: value,
                            label: 'Password',
                            isRequired: true,
                            minChars: 5,
                            maxChars: 50,
                          );
                        },
                      ),
                      // const SizedBox(height: 10),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: TextButton(
                      //     onPressed: () {},
                      //     child:
                      //         txt("Forgot Password?", c: context.primaryColor),
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      state.responseType == ResponseEnum.loading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState!.validate()) {
                                controller.signIn(signInData: _collectData());
                              }
                            },
                            child: txt("Sign In", e: St.reg16),
                          ),
                      const SizedBox(height: 20),
                      // Row(
                      //   children: [
                      //     const Expanded(child: Divider(thickness: 1)),
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 10),
                      //       child: txt("OR", c: Colors.grey),
                      //     ),
                      //     const Expanded(child: Divider(thickness: 1)),
                      //   ],
                      // ),
                      // const SizedBox(height: 20),
                      // BlocProvider(
                      //   create: (context) => SocialAuthCubit(serviceLocator()),
                      //   child: BlocBuilder<SocialAuthCubit, SocialAuthState>(
                      //     builder: (context, state) {
                      //       return state.responseType == ResponseEnum.loading
                      //           ? const Center(
                      //               child: CircularProgressIndicator())
                      //           : OutlinedButton.icon(
                      //               onPressed: () async {
                      //                 _handleGoogleSignIn(context);
                      //               },
                      //               style: context.outlinedButtonTheme.style,
                      //               icon: Icon(MdiIcons.google),
                      //               label:
                      //                   txt("Sign in with Google", e: St.reg16),
                      //             );
                      //     },
                      //   ),
                      // ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          txt("Don't have an account?", c: Colors.grey),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(AppRoutesNames.signupScreen);
                            },
                            child: txt("Sign Up", c: Colors.blue),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Future _handleGoogleSignIn(BuildContext context) async {
  //   final UserCredential credential = await signInWithGoogle();
  //   final User? user = credential.user;
  //   if (user == null) {
  //     showSnackbar('Error', "Something went wrong with google authentication", true);
  //     return;
  //   }
  //   // UserTypeEnum? userType = await getUserTypeDialog(context);
  //   // if (userType == null) {
  //   //   showSnackbar('Error', "You must choose your type", true);
  //   //   return;
  //   // }
  //   final params = pr(
  //     SocialAuthParam(
  //       authId: user.uid,
  //       authType: 'google',
  //       name: user.displayName,
  //       email: user.email,
  //       userType: UserTypeEnum.doctor,
  //     ),
  //     'SocialAuthParam',
  //   );
  //   context.read<SocialAuthCubit>().socialAuth(params);
  // }
}
