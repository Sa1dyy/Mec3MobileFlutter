import 'package:flutter/material.dart';
import 'package:mec3mobileflutter/components/landingPageCard.dart';

import 'categoryPage.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Landing Page'),
      ),
      body: GridView.count(
        crossAxisCount: 2, 
        mainAxisSpacing: 10.0, 
        crossAxisSpacing: 10.0, 
        padding: EdgeInsets.all(10.0),
        children: [
          LandingPageCard('Category 1', 'assets/category1.jpg'),
          LandingPageCard('Category 2', 'assets/category2.jpg'),
          LandingPageCard('Category 3', 'assets/category3.jpg'),
          LandingPageCard('Category 4', 'assets/category4.jpg'),
          LandingPageCard('Category 5', 'assets/category5.jpg'),
          LandingPageCard('Category 6', 'assets/category6.jpg'),
        ],
      ),
    );
  }
}
