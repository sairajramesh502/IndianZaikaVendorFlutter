import 'dart:io';

import 'package:flutter/material.dart';
import 'package:indian_zaika_vendor/constants/constants.dart';
import 'package:indian_zaika_vendor/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class RestaurantPicCard extends StatefulWidget {
  const RestaurantPicCard({Key? key}) : super(key: key);

  @override
  _RestaurantPicCardState createState() => _RestaurantPicCardState();
}

class _RestaurantPicCardState extends State<RestaurantPicCard> {
  File? _image;
  @override
  Widget build(BuildContext context) {
    final _imagePickerProvider = Provider.of<AuthenticationHelper>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: InkWell(
        onTap: () {
          _imagePickerProvider.getImage().then((image) {
            setState(() {
              _image = image;
            });
            if (image != null) {
              _imagePickerProvider.isPicAvail = true;
            }
          });
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            width: screenWidth,
            height: screenWidth / 2.5,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: kCardBackColor,
              child: _image == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate,
                          size: screenWidth / 8,
                          color: kHintTextColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Add Restaurant Photo', style: kHintText),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        _image!,
                        fit: BoxFit.fill,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
