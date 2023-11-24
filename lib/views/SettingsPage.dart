import 'package:flutter/material.dart';
import 'package:mec3mobileflutter/models/UserModel.dart';
import 'package:mec3mobileflutter/config/AppState.dart';
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

  void switchMethod1() {
    setState(() {
      AppState.brightnessMode = Brightness.light;
    });
  }

  void switchMethod2() {
    setState(() {
      AppState.brightnessMode = Brightness.dark;
    });
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
                          switchMethod1();
                        } else {
                          switchMethod2();
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
}
