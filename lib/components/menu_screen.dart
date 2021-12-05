import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indian_zaika_vendor/constants/constants.dart';

class MenuWidget extends StatelessWidget {
  final Function(String)? onItemClick;

  const MenuWidget({Key? key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kAccentColor,
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: kPrimaryColor,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Nick',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          sliderItem('Dashboard', Icons.dashboard),
          sliderItem('Menu', Icons.menu_book),
          sliderItem('Coupons', CupertinoIcons.gift_alt_fill),
          sliderItem('Orders', Icons.list_alt_sharp),
          sliderItem('Reports', Icons.stacked_bar_chart),
          sliderItem('Setting', Icons.settings),
          sliderItem('LogOut', Icons.arrow_back_ios_new_sharp)
        ],
      ),
    );
  }

  Widget sliderItem(String title, IconData icons) => ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: kPrimaryColor,
        ),
      ),
      leading: Icon(
        icons,
        color: kPrimaryColor,
      ),
      onTap: () {
        onItemClick!(title);
      });
}
