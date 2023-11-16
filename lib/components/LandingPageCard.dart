import 'package:flutter/material.dart';
import '../models/LandingPageCardModel.dart';
import '../views/categoryPage.dart';

class LandingPageCard extends StatelessWidget {
  final LandingPageCardModel cardModel;

  const LandingPageCard(this.cardModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryPage(cardModel.name),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFA3AE03), // Barva rámečku
            width: 2.0,
          ),
          color: Colors.white, // Barva pozadí
        ),
        child: Column(
          children: [
            Container(
              height: 100.0, // výška obrázku
              width: 100.0, // šířka obrázku
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(cardModel.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10), 
            Expanded(
              child: Container(
                color: const Color(0xFFA3AE03),
                child: Center(
                  child: Text(
                    cardModel.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
