import 'package:flutter/material.dart';
import 'package:mec3mobileflutter/config/AppState.dart';
import 'package:mec3mobileflutter/views/EshopPage.dart';
import '../models/LandingPageCardModel.dart';
import '../views/categoryPage.dart';

class LandingPageCard extends StatelessWidget {
  final LandingPageCardModel cardModel;

  const LandingPageCard(this.cardModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (cardModel.id != 900) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryPage(cardModel.id),
            ),
          );
        } else {
          if (AppState.isLogged) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EshopPage(false),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Pro přístup do E-shopu se prosím přihlaste.'),
              ),
            );
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFA3AE03),
            width: 2.0,
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              height: 100.0,
              width: 100.0,
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
