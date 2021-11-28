// ignore_for_file: unnecessary_this, avoid_print, import_of_legacy_library_into_null_safe

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class AuthenticationHelper with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String err = '';
  bool isAuthLoading = false;
  File? image;
  String pickerError = '';
  bool isPicAvail = false;
  double shopLat = 0;
  double shopLng = 0;
  String restAddress = '';
  String restPlace = '';
  String email = '';

  //Image Picker
  Future<File?> getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      this.image = File(pickedImage.path);
      print(this.image!.path);
      notifyListeners();
    } else {
      this.pickerError = 'No Image Select';
      print('No Image Select');
      notifyListeners();
    }
    return this.image;
  }

  //SIGN UP METHOD
  Future signUp({
    required String email,
    required String password,
  }) async {
    this.email = email;
    notifyListeners();
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      this.isAuthLoading = false;
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      this.isAuthLoading = false;
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      this.isAuthLoading = false;
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }

  //Update User
  Future updateUserLocation(
      {required double longitude,
      required double latitude,
      required String address}) async {
    await firestore.collection('Users').doc(_auth.currentUser!.email).update({
      'location': GeoPoint(latitude, longitude),
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    });
    return null;
  }

  //get Location

  Future getCurrentAddress() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    this.shopLat = _locationData.latitude!;
    this.shopLng = _locationData.longitude!;
    notifyListeners();

    final coordinates =
        new Coordinates(_locationData.latitude, _locationData.longitude);
    var _addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var RestAddr = _addresses.first;
    this.restAddress = RestAddr.addressLine;
    this.restPlace = RestAddr.featureName;
    notifyListeners();
    return RestAddr;
  }

  //Add Restaurant Data to DB

  Future<void> saveRestaurantdataToDB(
      {required String url,
      required String shopName,
      required String mobile,
      required String dialog}) async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentReference _restaurants =
        FirebaseFirestore.instance.collection('Restaurants').doc(this.email);
    _restaurants.set({
      'imageUrl': url,
      'uid': user!.uid,
      'restaurantName': shopName,
      'mobile': mobile,
      'email': this.email,
      'dialog': dialog,
      'adderss': '${this.restPlace}: ${this.restAddress}',
      'location': GeoPoint(this.shopLat, this.shopLng),
      'shopOpen': true,
      'rating': 0.00,
      'rating': 0.00,
      'totalRating': 0,
      'isTopPicked': true,
      'restVerified': true,
    });
    this.isPicAvail = false;
  }
}
