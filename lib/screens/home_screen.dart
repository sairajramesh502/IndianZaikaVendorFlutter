import 'package:flutter/material.dart';
import 'package:indian_zaika_vendor/constants/constants.dart';
import 'package:indian_zaika_vendor/providers/auth_provider.dart';
import 'package:indian_zaika_vendor/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _homeScreenProvider = Provider.of<AuthenticationHelper>(context);
    return Scaffold(
      body: TextButton(
          onPressed: () {
            _homeScreenProvider.signOut().then((result) {
              if (result == null) {
                Navigator.pushReplacementNamed(context, OnboardingScreen.id);
              } else {
                print(result);
              }
            });
          },
          child: Center(child: Text('HomeScreen2', style: kHintText))),
    );
  }
}
