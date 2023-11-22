import 'package:flutter/material.dart';
import 'package:mec3mobileflutter/config/AppState.dart';
import 'views/LandingPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    );
  }
}
