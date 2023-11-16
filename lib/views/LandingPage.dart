import 'package:flutter/material.dart';
import 'package:mec3mobileflutter/components/landingPageCard.dart';
import 'package:mec3mobileflutter/models/LandingPageCardModel.dart';
import 'package:mec3mobileflutter/views/LoginPage.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.person), // You can change the icon as needed
          onPressed: () {
            // Navigate to LoginPage when the icon is pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        padding: EdgeInsets.all(10.0),
        children: [
          LandingPageCard(new LandingPageCardModel(
              id: 100,
              name: 'Kopečková zmrzlina',
              image: 'assets/icecream1.png')),
          LandingPageCard(new LandingPageCardModel(
              id: 200, name: 'Točená zmrzlina', image: 'assets/icecream2.png')),
          LandingPageCard(new LandingPageCardModel(
              id: 400, name: 'Cukrařina', image: 'assets/cake.png')),
          LandingPageCard(new LandingPageCardModel(
              id: 600,
              name: 'Kakao a čokoláda',
              image: 'assets/chocolate.png')),
          LandingPageCard(new LandingPageCardModel(
              id: 700, name: 'Servisní položky', image: 'assets/dough.png')),
          LandingPageCard(new LandingPageCardModel(
              id: 900, name: 'Eshop', image: 'assets/cart_empty.png')),
        ],
      ),
    );
  }
}
