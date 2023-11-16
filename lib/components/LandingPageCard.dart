import 'package:flutter/material.dart';
import '../models/LandingPageCardModel.dart';
import '../views/categoryPage.dart';

class LandingPageCard extends StatelessWidget {
  final LandingPageCardModel cardModel;

  LandingPageCard(this.cardModel);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        print('Dlaždice s názvem ${cardModel.name} byla klepnuta!');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryPage(cardModel.name),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFA3AE03), // Barva rámečku
            width: 2.0,
          ),
          color: Colors.white, // Barva pozadí
        ),
        child: Stack(
          children: [
            Image.asset(
              cardModel.image,
              height: 100.0,
              width: 100.0,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Color(0xFFA3AE03), 
                child: Text(
                  cardModel.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
