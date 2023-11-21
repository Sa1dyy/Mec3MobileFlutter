import 'package:flutter/material.dart';
import 'package:mec3mobileflutter/models/UserModel.dart';
import 'package:mec3mobileflutter/settings/AppState.dart';
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
                // Add the functionality you want when the button is clicked
                // For example, set the app state and show a SnackBar.
                AppState.isLogged = false;
                AppState.user = UserModel(
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

                // Show a SnackBar with a message
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
            // You might not want to display the password for security reasons
            // Text('Password: ${AppState.user.password}'),
            // Add more widgets to display other user information as needed
          ],
        ),
      ),
    );
  }
}
