import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mec3mobileflutter/api/FirebaseApi.dart';
import 'package:mec3mobileflutter/config/AppState.dart';
import 'package:mec3mobileflutter/firebase_options.dart';
import 'package:mec3mobileflutter/views/NewsPage.dart';
import 'views/LandingPage.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifcations();
  runApp(const Mec3MobileFlutter());
}

class Mec3MobileFlutter extends StatelessWidget {
  const Mec3MobileFlutter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define a material color using Color(0xFFA3AE03)
    MaterialColor primarySwatchColor = MaterialColor(0xFFA3AE03, {
      50: Color(0xFFA3AE03),
      100: Color(0xFFA3AE03),
      200: Color(0xFFA3AE03),
      300: Color(0xFFA3AE03),
      400: Color(0xFFA3AE03),
      500: Color(0xFFA3AE03),
      600: Color(0xFFA3AE03),
      700: Color(0xFFA3AE03),
      800: Color(0xFFA3AE03),
      900: Color(0xFFA3AE03),
    });

    return MaterialApp(
      title: 'Mec3',
      theme: ThemeData(
        primarySwatch: primarySwatchColor,
        brightness: Brightness.light,
      ),
      home: LandingPage(),
      navigatorKey: navigatorKey,
      routes: {'notification_screen': ((context) => NewsPage())},
    );
  }
}
