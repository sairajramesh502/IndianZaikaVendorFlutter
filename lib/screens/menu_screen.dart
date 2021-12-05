import 'package:flutter/material.dart';
import 'package:indian_zaika_vendor/constants/constants.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  get kPrimaryColor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Text(
          'Menu',
          style: kHintText,
        ),
      ),
    );
  }
}
