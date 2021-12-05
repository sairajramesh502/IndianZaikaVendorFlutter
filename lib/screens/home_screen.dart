import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:indian_zaika_vendor/components/main_screen.dart';
import 'package:indian_zaika_vendor/components/menu_screen.dart';
import 'package:indian_zaika_vendor/constants/constants.dart';
import 'package:indian_zaika_vendor/providers/auth_provider.dart';
import 'package:indian_zaika_vendor/screens/onboarding_screen.dart';
import 'package:indian_zaika_vendor/services/drawer_services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<SliderMenuContainerState> _key =
      GlobalKey<SliderMenuContainerState>();
  String? title;

  DrawerServices _drawerServices = DrawerServices();
  @override
  Widget build(BuildContext context) {
    final _homeScreenProvider = Provider.of<AuthenticationHelper>(context);
    return Scaffold(
      body: SliderMenuContainer(
          drawerIconColor: kAccentColor,
          appBarColor: kPrimaryColor,
          key: _key,
          sliderMenuOpenSize: 200,
          isTitleCenter: false,
          title: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Indian Zaika',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search,
                        size: 25, color: Colors.white)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications,
                        size: 25, color: Colors.white)),
              ],
            ),
          ),
          sliderMenu: MenuWidget(
            onItemClick: (title) {
              _key.currentState!.closeDrawer();
              setState(() {
                this.title = title;
              });
            },
          ),
          sliderMain: _drawerServices.drawerScreen(title, _homeScreenProvider)),
    );
  }
}
