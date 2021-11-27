// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:indian_zaika_vendor/screens/login_screen.dart';
import 'package:indian_zaika_vendor/widgets/button.dart';

class OnboardingScreen extends StatefulWidget {
  static const String id = 'onboarding-screen';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

final _controller = PageController(
  initialPage: 0,
);

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<Widget> _pages = [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'images/Onboard1.png',
            fit: BoxFit.cover,
            height: screenHeight / 1.4,
            width: screenWidth,
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'images/Onboard2.png',
            fit: BoxFit.cover,
            height: screenHeight / 1.4,
            width: screenWidth,
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'images/Onboard3.png',
            fit: BoxFit.cover,
            height: screenHeight / 1.4,
            width: screenWidth,
          ),
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: Color(0xFFCFAA01),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          //onboard Image Slider
          SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: PageView(
              controller: _controller,
              children: _pages,
            ),
          ),

          //Overall Bottom Container
          Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(44),
                  topRight: Radius.circular(44),
                ),
                color: Color(0xFF272C2F),
              ),
              height: MediaQuery.of(context).size.width / 1.2,
              width: screenWidth,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 50, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Text 1

                    FadeInUp(
                      duration: Duration(milliseconds: 500),
                      child: const Text(
                        'Order & Let’s eat',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    //space
                    const SizedBox(
                      height: 10,
                    ),

                    //Text 2

                    FadeInUp(
                      duration: Duration(milliseconds: 500),
                      child: RichText(
                        text: const TextSpan(
                          text: 'Tasty',
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Food.',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFFFC013),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //space
                    const SizedBox(
                      height: 20,
                    ),

                    //Text 3
                    FadeInUp(
                      duration: Duration(milliseconds: 700),
                      child: const Text(
                        'Order Food and get Delivery in the Fastest\nTime in the Town',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),

                    //space
                    const SizedBox(
                      height: 50,
                    ),

                    //Button

                    FadeInUp(
                      duration: Duration(milliseconds: 900),
                      child: ButtonGlobal(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.id);
                          },
                          buttonText: 'Get Started'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
