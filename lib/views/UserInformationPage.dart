import 'package:flutter/material.dart';
import 'package:mec3mobileflutter/models/UserModel.dart';
import 'package:mec3mobileflutter/config/AppState.dart';
import 'package:mec3mobileflutter/views/LandingPage.dart';

class UserInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informace o uživateli'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LandingPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vítejte, ${AppState.user.customerName}!',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text('Customer Name: ${AppState.user.customerName}'),
            Text('Email: ${AppState.user.email}'),
            Text('Username: ${AppState.user.userName}'),
            SizedBox(height: 25.0),

            ElevatedButton(
              onPressed: () {
            
                AppState.isLogged = false;
                AppState.user = UserModel(
                  id: 0,
                  organizationName: "",
                  customerName: "",
                  email: "",
                  telNumber: "",
                  userName: "",
                  password: "",
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LandingPage()),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Odhlášení proběhlo úspěšně.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFA3AE03),
                onPrimary: Colors.white,
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Odhlásit se',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
