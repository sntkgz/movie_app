import 'package:flutter/material.dart';

import '../core/const.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class WrapperScreen extends StatefulWidget {
  @override
  _WrapperScreenState createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSkinColor,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/Mapp.png'),
                          fit: BoxFit.contain)),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Movie App',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Yeni filmleri bulabileceğiniz, favorileriyebileceğiniz yep yeni bir platform',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17, letterSpacing: 0.15),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: kBlueColor, width: 0.5),
                                    borderRadius: BorderRadius.circular(4)),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ));
                                  },
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            vertical: 14)),
                                  ),
                                  child: Text(
                                    'GİRİŞ YAP',
                                    style: TextStyle(
                                        color: kBlueColor,
                                        fontSize: 20,
                                        letterSpacing: 1.25),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: kBlueColor,
                                    borderRadius: BorderRadius.circular(4)),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => RegisterScreen(),
                                    ));
                                  },
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            vertical: 14)),
                                  ),
                                  child: Text(
                                    'Üye Ol'.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        letterSpacing: 1.25),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
