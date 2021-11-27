import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:indian_zaika_vendor/constants/constants.dart';
import 'package:indian_zaika_vendor/providers/auth_provider.dart';
import 'package:indian_zaika_vendor/screens/home_screen.dart';
import 'package:indian_zaika_vendor/widgets/button.dart';
import 'package:indian_zaika_vendor/widgets/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register-screen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _typeController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isVisible = false;
  bool isLoading = false;

  String _uploadedFileURL = '';

  Future<String> uploadFile(filePath) async {
    File file = File(filePath);
    FirebaseStorage _storage = FirebaseStorage.instance;

    try {
      await _storage.ref('uploads/${_nameController.text}').putFile(file);
    } on FirebaseException catch (e) {
      print(e.code);
      // e.g, e.code == 'canceled'
    }
    String downloadURL =
        await _storage.ref('uploads/${_nameController.text}').getDownloadURL();

    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    final _registerProvider = Provider.of<AuthenticationHelper>(context);
    //Scaffold Message
    void scaffoldMessage(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kAccentColor,
        content: Text(message, style: const TextStyle(color: kPrimaryColor)),
      ));
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
        child: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Image.asset('images/Registering.gif')),
                  const Text(
                    'Registering You',
                    style: kTextStyleHead2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: const TextSpan(
                      text: 'Hold On',
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Tight.',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFFFC013),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    //Image Picker
                    RestaurantPicCard(),

                    //Text Inputs
                    Padding(
                      padding: EdgeInsets.only(top: screenWidth / 10),
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Name
                            const Text('Restaurant Name', style: kLabelStyle),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _nameController,
                              style: kHintText,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: 'Enter Your Restaurant Name',
                                hintStyle: kHintText,
                                filled: true,
                                fillColor: kCardBackColor,
                                contentPadding: const EdgeInsets.all(22.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            //Space
                            SizedBox(height: screenWidth / 20),

                            //Emial
                            const Text('E-mail', style: kLabelStyle),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _emailController,
                              style: kHintText,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Enter Your Email',
                                hintStyle: kHintText,
                                filled: true,
                                fillColor: kCardBackColor,
                                contentPadding: const EdgeInsets.all(22.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            //Space
                            SizedBox(height: screenWidth / 20),

                            //Mobile Number
                            const Text('Mobile Number', style: kLabelStyle),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _mobileController,
                              style: kHintText,
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                prefixText: '+91',
                                counterText: '',
                                hintText: 'Enter Your Mobile Number',
                                hintStyle: kHintText,
                                filled: true,
                                fillColor: kCardBackColor,
                                contentPadding: const EdgeInsets.all(22.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            //Space
                            SizedBox(height: screenWidth / 20),

                            //Restaurant Type
                            const Text('Restaurant Type', style: kLabelStyle),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _typeController,
                              style: kHintText,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Enter Your Restaurant Type',
                                hintStyle: kHintText,
                                filled: true,
                                fillColor: kCardBackColor,
                                contentPadding: const EdgeInsets.all(22.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            //Space
                            SizedBox(height: screenWidth / 20),

                            //Address
                            const Text('Address', style: kLabelStyle),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _addressController,
                              style: kHintText,
                              keyboardType: TextInputType.emailAddress,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: 'Enter Your Address',
                                hintStyle: kHintText,
                                filled: true,
                                fillColor: kCardBackColor,
                                contentPadding: const EdgeInsets.all(22.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: IconButton(
                                  splashRadius: 0.1,
                                  onPressed: () {
                                    _addressController.text =
                                        'We are Feching you Location....\nPlease Wait';
                                    _registerProvider
                                        .getCurrentAddress()
                                        .then((address) {
                                      if (address != null) {
                                        setState(() {
                                          _addressController.text =
                                              '${_registerProvider.restPlace}\n${_registerProvider.restAddress}';
                                        });
                                      } else {
                                        scaffoldMessage(
                                            'Could Not Find Ypur Location. Try agaiun later after checking if Location Permission is Granted');
                                      }
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.my_location,
                                    size: 30,
                                    color: kHintTextColor,
                                  ),
                                ),
                              ),
                            ),

                            //Space
                            SizedBox(height: screenWidth / 20),

                            //Password
                            const Text('Password', style: kLabelStyle),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _passwordController,
                              style: kHintText,
                              obscureText: _isVisible ? false : true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: IconButton(
                                    color: const Color(0xFFD4CDCD),
                                    splashRadius: 0.1,
                                    icon: _isVisible
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _isVisible = !_isVisible;
                                      });
                                    },
                                  ),
                                ),
                                hintText: 'Enter Your Password',
                                hintStyle: kHintText,
                                filled: true,
                                fillColor: kCardBackColor,
                                contentPadding: const EdgeInsets.all(22.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            //Space
                            SizedBox(height: screenWidth / 20),

                            //Confirm Password
                            const Text('Confirm Password', style: kLabelStyle),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _confirmPasswordController,
                              style: kHintText,
                              obscureText: _isVisible ? false : true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: IconButton(
                                    color: const Color(0xFFD4CDCD),
                                    splashRadius: 0.1,
                                    icon: _isVisible
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _isVisible = !_isVisible;
                                      });
                                    },
                                  ),
                                ),
                                hintText: 'Enter Your Confirmation Password',
                                hintStyle: kHintText,
                                filled: true,
                                fillColor: kCardBackColor,
                                contentPadding: const EdgeInsets.all(22.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            //Space
                            SizedBox(height: screenWidth / 10),

                            //Register Button
                            ButtonGlobal(
                                onPressed: () {
                                  if (_registerProvider.isPicAvail = false) {
                                    scaffoldMessage(
                                        'Restaurant Image is Required Please Upload Restaurant Image');
                                  } else {
                                    if (_nameController.text == '' ||
                                        _emailController.text == '' ||
                                        _mobileController.text == '' ||
                                        _typeController.text == '' ||
                                        _addressController.text == '' ||
                                        _passwordController.text == '' ||
                                        _confirmPasswordController.text == '') {
                                      scaffoldMessage(
                                          'You Might have missed an Important Detail. Please enter all the required Details');
                                    } else if (EmailValidator.validate(
                                            _emailController.text) ==
                                        false) {
                                      scaffoldMessage(
                                          'Oh No! The Email is badly Formatted Enter a Valid Email');
                                    } else if (_passwordController.text.length <
                                        7) {
                                      scaffoldMessage(
                                          'Oh No! That might be a Weak Password kindly Enter a Password with Altleast 7 characters');
                                    } else if (_passwordController.text !=
                                        _confirmPasswordController.text) {
                                      scaffoldMessage(
                                          'Oh No! The Passwords Dint Match Kindly Check Once');
                                    } else if (_mobileController.text.length <
                                        10) {
                                      scaffoldMessage(
                                          'Oh No! You have entered an invalid Mobile Number Kindly enter a 10 digit Mobile Number');
                                    } else {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      _registerProvider
                                          .signUp(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text)
                                          .then((result) {
                                        if (result == null) {
                                          uploadFile(
                                                  _registerProvider.image!.path)
                                              .then((url) {
                                            if (url != null) {
                                              _registerProvider
                                                  .saveRestaurantdataToDB(
                                                      url: url,
                                                      shopName:
                                                          _nameController.text,
                                                      mobile: _mobileController
                                                          .text,
                                                      dialog:
                                                          _typeController.text);
                                              Navigator.pushReplacementNamed(
                                                  context, HomeScreen.id);
                                              setState(() {
                                                isLoading = false;
                                              });
                                            } else {
                                              scaffoldMessage(
                                                  'Failed top Uploaod Profile Picture');
                                              setState(() {
                                                isLoading = false;
                                              });
                                            }
                                          });
                                        } else {
                                          scaffoldMessage(result);
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      });
                                    }
                                  }
                                },
                                buttonText: 'Register'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
