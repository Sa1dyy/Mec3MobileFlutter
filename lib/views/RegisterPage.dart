import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mec3mobileflutter/views/LandingPage.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController organizationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telNumberController = TextEditingController();
  final TextEditingController customerNameController = TextEditingController();

  Future<void> registerUser(BuildContext context) async {
    final String url = 'https://mec3.cz/mec3mobile/UserMobile/CreateUser';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> body = {
      'OrganizationName': organizationController.text,
      'CustomerName': customerNameController.text,
      'Email': emailController.text,
      'TelNumber': telNumberController.text,
      'UserName': usernameController.text,
      'Password': passwordController.text,
    };

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registrace proběhla úspěšně.'),
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registrace selhala. Zkontrolujte své údaje.'),
          duration: Duration(seconds: 2),
        ),
      );

      print('Registration failed. Status code: ${response.statusCode}');
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
                controller: customerNameController,
                decoration: InputDecoration(
                  labelText: 'Jméno uživatele',
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
              TextField(
                controller: organizationController,
                decoration: InputDecoration(
                  labelText: 'Název organizace',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'E-mailová adresa',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: telNumberController,
                decoration: InputDecoration(
                  labelText: 'Telefonní číslo',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  registerUser(context);
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
                  'Registrovat se',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
