import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:indian_zaika_vendor/providers/auth_provider.dart';
import 'package:indian_zaika_vendor/providers/location_provider.dart';
import 'package:indian_zaika_vendor/screens/forgot_password.dart';
import 'package:indian_zaika_vendor/screens/home_screen.dart';
import 'package:indian_zaika_vendor/screens/login_screen.dart';
import 'package:indian_zaika_vendor/screens/onboarding_screen.dart';
import 'package:indian_zaika_vendor/screens/registration_screen.dart';
import 'package:indian_zaika_vendor/screens/splash_screen.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthenticationHelper(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Rubik'),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        OnboardingScreen.id: (context) => const OnboardingScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        ForgotPassword.id: (context) => const ForgotPassword(),
        HomeScreen.id: (context) => const HomeScreen(),
      },
    );
  }
}
