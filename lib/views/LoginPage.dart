import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mec3mobileflutter/views/LandingPage.dart';
import 'package:mec3mobileflutter/views/RegisterPage.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    final String url = 'https://mec3.cz/mec3mobile/UserMobile/LoginUser';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, String> body = {
      'UserName': usernameController.text,
      'Password': passwordController.text,
    };

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData['customerId'] != null) {
        // Login successful, show success snackbar and navigate to LandingPage
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Přihlášení proběhlo úspěšně. Vítejte,' +
                responseData['userName'] +
                "!"),
            duration: Duration(seconds: 2),
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
      } else {
        // Handle null UserName or Password in response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Přihlášení selhalo. Zkontrolujte své údaje.'),
            duration: Duration(seconds: 2),
          ),
        );

        print('Login failed. Null UserName or Password in response.');
      }
    } else {
      // Handle login error, show error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Přihlášení selhalo. Zkontrolujte své údaje.'),
          duration: Duration(seconds: 2),
        ),
      );

      print('Login failed. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 50.0),
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/mec3fixed.png',
                height: 80.0,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Přihlašovací jméno',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Heslo',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  loginUser(context);
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
                  'Přihlásit se',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(16.0),
                ),
                child: Text(
                  'Registrovat',
                  style: TextStyle(
                    fontSize: 18.0,
                    decoration: TextDecoration.underline,
                    color: Color(0xFFA3AE03),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
