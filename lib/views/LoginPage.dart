import 'package:flutter/material.dart';
import 'package:mec3mobileflutter/views/LandingPage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          IconButton(
            icon: Icon(Icons.home), // Ikona pro domovskou stránku
            onPressed: () {
              // Přejít na LandingPage při kliknutí na ikonu domovské stránky
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LandingPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/mec3fixed.png', // Cesta k obrázku
            height: 80.0, // Nastavte výšku obrázku podle potřeby
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(labelText: 'Username'),
          ),
          SizedBox(height: 16.0),
          TextField(
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Provést přihlašovací logiku zde
              // Pro jednoduchost přejděte zpět na úvodní stránku
              Navigator.pop(context);
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
