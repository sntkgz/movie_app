import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_app/cubits/auth_cubit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../core/const.dart';
import 'landing_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode emailFocustNode = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final FocusNode passwordFocustNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;

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
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 80.0, bottom: 30.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/Mapp.png')),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(ekranYuksekligi / 50),
                          child: TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Lütfen bir E-posta giriniz';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "E-Posta",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(ekranYuksekligi / 50),
                          child: TextFormField(
                            controller: passwordController,
                            focusNode: passwordFocustNode,
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Lütfen bir şifre giriniz';
                              }
                              if (value.length < 6) {
                                return 'Şifreniz en az 6 karakterli olmalıdır';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Şifre",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          constraints:
                              const BoxConstraints(minWidth: double.infinity),
                          child: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                await context.read<AuthCubit>().loginWithEmail(
                                      email: emailController.text.trim(),
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
                              'Gİrİş Yap'.toUpperCase(),
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
