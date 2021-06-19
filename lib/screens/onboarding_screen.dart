import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:my_app/cubit/auth_cubit.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd() {
    context.read<AuthCubit>().onboardingDone();
  }

  Widget _buildImage(String imageNumber, [double width = 370]) {
    return Image.asset('assets/images/onboarding_$imageNumber.jpeg',
        width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,

      pages: [
        PageViewModel(
          title: "Kolayca Giriş Yap",
          body:
              "Kullanıcı adını, emailini ve şifreni girerek kolay ve hızlı bir şekilde giriş yapabilirsin",
          image: _buildImage('1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Filmler İçin Not Tut",
          body: "İzlemiş olduğun filmler için kendine ait notlar tutabilirsin",
          image: _buildImage('2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Yorum Yap",
          body: "Filmlere ait yorumları görebilir. Sen de yorum yapabilirsin",
          image: _buildImage('3'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "İzlenenlere Kaydet veya Favorile",
          body:
              "İstediğin filmi sana ait olan arşivinde izlenenlere kaydebilir veya favorileyebilirsin",
          image: _buildImage('4'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text(
        'GEÇ',
        style: TextStyle(
          color: Color(0xffD6080B),
        ),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Color(0xffD6080B),
      ),
      done: const Text('Done',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xffD6080B),
          )),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: Color(0xffD6080B),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
