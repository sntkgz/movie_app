import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_app/cubit/auth_cubit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../core/const.dart';
import '../models/profile.dart';
import '../widgets/custom_form_field.dart';
import 'landing_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode nickNameFocustNode = FocusNode();
  final TextEditingController nickNameController = TextEditingController();

  final FocusNode emailFocustNode = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final FocusNode passwordFocustNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is AuthLoginError) {
          await Alert(
            context: context,
            type: AlertType.error,
            title: 'Giriş Hatası',
            desc: state.errorMessage,
            buttons: [
              DialogButton(
                onPressed: () => Navigator.pop(context),
                width: 120,
                child: Text(
                  'Tamam',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ).show();
        }
      },
      builder: (context, state) {
        if (state is AuthUnauthenticated) {
          return ModalProgressHUD(
            progressIndicator: Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
              color: Colors.black.withOpacity(0.7),
              child: CircularProgressIndicator(
                color: kBlueColor,
              ),
            ),
            inAsyncCall: state.isLoading,
            color: Colors.white,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                elevation: 0,
                centerTitle: true,
                backgroundColor: Colors.white,
                title: Text(
                  'Üye Ol',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormField(
                        title: 'Kullanıcı Adınız',
                        focusColor: kBlueColor,
                        controller: nickNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Lütfen adınızı giriniz';
                          }
                          return null;
                        },
                        focusNode: nickNameFocustNode,
                      ),
                      CustomFormField(
                        title: 'E-Posta Adresiniz',
                        focusColor: kBlueColor,
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Lütfen bir E-posta giriniz';
                          }
                        },
                        focusNode: emailFocustNode,
                      ),
                      CustomFormField(
                        title: 'Şifreniz',
                        focusColor: kBlueColor,
                        controller: passwordController,
                        passwordField: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Lütfen bir şifre giriniz';
                          }
                          if (value.length < 6) {
                            return 'Şifreniz en az 6 karakterli olmalıdır';
                          }
                          return null;
                        },
                        focusNode: passwordFocustNode,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        child: TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              await context.read<AuthCubit>().registerWithEmail(
                                    profile: Profile(
                                        uid: '',
                                        nickName: nickNameController.text,
                                        email: emailController.text.trim()),
                                    password: passwordController.text,
                                  );
                            }
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 14)),
                              backgroundColor:
                                  MaterialStateProperty.all(kBlueColor)),
                          child: Text(
                            'Üye Ol'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 1.25),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is AuthAuthenticated) {
          return LandingScreen();
        }
        return Container();
      },
    );
  }
}
