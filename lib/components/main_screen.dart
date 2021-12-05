import 'package:flutter/material.dart';
import 'package:indian_zaika_vendor/constants/constants.dart';
import 'package:indian_zaika_vendor/providers/auth_provider.dart';
import 'package:indian_zaika_vendor/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main-screen';
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final _homeScreenProvider = Provider.of<AuthenticationHelper>(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: TextButton(
          onPressed: () {
            _homeScreenProvider.signOut().then((value) {
              if (value == null) {
                Navigator.pushReplacementNamed(context, OnboardingScreen.id);
              } else {
                print('failed');
              }
            });
          },
          child: Text(
            'Dashboard',
            style: kHintText,
          ),
        ),
      ),
    );
  }
}
