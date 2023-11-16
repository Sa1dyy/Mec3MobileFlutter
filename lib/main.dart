import 'package:flutter/material.dart';

import 'views/LandingPage.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Mec3MobileFluttter());

}

class Mec3MobileFluttter extends StatelessWidget {
  const Mec3MobileFluttter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mec3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
    );
  }
}




