import 'package:flutter/material.dart';
import 'package:mec3mobileflutter/components/landingPageCard.dart';
import 'package:mec3mobileflutter/models/LandingPageCardModel.dart';
import 'package:mec3mobileflutter/settings/AppState.dart';
import 'package:mec3mobileflutter/views/LoginPage.dart';
import 'package:mec3mobileflutter/views/NewsPage.dart';
import 'package:mec3mobileflutter/views/SettingsPage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  bool isUserLogged() {
    if (AppState.isLogged == true) {
      return true;
    } else {
      return false;
    }
  }

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

    List<Widget> landingPageCards =
        cardModels.map((cardModel) => LandingPageCard(cardModel)).toList();

    return landingPageCards;
  }

  @override
  Widget build(BuildContext context) {
    bool isLogged = isUserLogged();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF262626),
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(Icons.person),
          iconSize: 40,
          color: isLogged ? Color(0xFFA3AE03) : Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/mec3fixed.png',
              height: 60,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            iconSize: 40,
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsPage()),
              );
            },
            child: Container(
              width: 250,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.03,
              ),
              decoration: BoxDecoration(
                color: Color(0xFFA3AE03),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Novinky',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
