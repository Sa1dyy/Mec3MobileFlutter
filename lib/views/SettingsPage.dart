import 'package:flutter/material.dart';
import 'package:mec3mobileflutter/models/UserModel.dart';
import 'package:mec3mobileflutter/settings/AppState.dart';
import 'package:mec3mobileflutter/views/LandingPage.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isToggleOn = false;
  bool switchValue = false;

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(26.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/mec3fixed.png',
                  height: 80.0,
                ),
                SizedBox(height: 16.0),
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
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFA3AE03),
                    onPrimary: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Načíst offline data',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wb_sunny, color: Colors.amber),
                    Switch(
                      value: switchValue,
                      onChanged: (value) {
                        setState(() {
                          switchValue = value;
                        });

                        if (switchValue) {
                          // Call the first method or perform the desired action
                          method1();
                        } else {
                          // Call the second method or perform the desired action
                          method2();
                        }
                      },
                      activeColor: Color(0xFFA3AE03),
                    ),
                    Icon(Icons.nightlight_round, color: Colors.blue),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xFFA3AE03),
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            child: Center(
              child: Text(
                'O aplikaci',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void method1() {
    // Add functionality for the first method
    setState(() {
      AppState.brightnessMode = Brightness.light;
    });
  }

  void method2() {
    // Add functionality for the second method
    setState(() {
      AppState.brightnessMode = Brightness.dark;
    });
  }
}
