import 'package:flutter/material.dart';
import 'package:mec3mobileflutter/components/landingPageCard.dart';
import 'package:mec3mobileflutter/models/LandingPageCardModel.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  List<Widget> buildLandingPageCards() {
    List<LandingPageCardModel> cardModels = [
      LandingPageCardModel(
          id: 100, name: 'Kopečková zmrzlina', image: 'assets/icecream1.png'),
      LandingPageCardModel(
          id: 200, name: 'Točená zmrzlina', image: 'assets/icecream2.png'),
      LandingPageCardModel(
          id: 400, name: 'Cukrařina', image: 'assets/cake.png'),
      LandingPageCardModel(
          id: 600, name: 'Kakao a čokoláda', image: 'assets/chocolate.png'),
      LandingPageCardModel(
          id: 700, name: 'Servisní položky', image: 'assets/dough.png'),
      LandingPageCardModel(
          id: 900, name: 'Eshop', image: 'assets/cart_empty.png'),
    ];

    List<Widget> landingPageCards = cardModels
        .map((cardModel) => LandingPageCard(cardModel))
        .toList();

    return landingPageCards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF262626),
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(Icons.person),
          iconSize: 40,
          onPressed: () {},
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/mec3logo.png',
              height: 60,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            iconSize: 40,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              padding: const EdgeInsets.all(10.0),
              children: buildLandingPageCards(),
            ),
          ),
          Container(
            width: 250,
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03), // Úprava zde
            decoration: const BoxDecoration(
              color: Color(0xFFA3AE03),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            padding: const EdgeInsets.all(15.0),
            child: const Text(
              'Novinky',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
