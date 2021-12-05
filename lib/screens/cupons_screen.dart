import 'package:flutter/material.dart';
import 'package:indian_zaika_vendor/constants/constants.dart';

class CuponsScreen extends StatefulWidget {
  const CuponsScreen({Key? key}) : super(key: key);

  @override
  _CuponsScreenState createState() => _CuponsScreenState();
}

class _CuponsScreenState extends State<CuponsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Text(
          'Cupons',
          style: kHintText,
        ),
      ),
    );
  }
}
