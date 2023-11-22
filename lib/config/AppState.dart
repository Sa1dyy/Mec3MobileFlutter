import 'package:flutter/material.dart';
import 'package:mec3mobileflutter/models/UserModel.dart';

class AppState {
  static UserModel user = UserModel(
    id: 0,
      organizationName: "",
      customerName: "",
      email: "",
      telNumber: "",
      userName: "",
      password: "");
  static bool isLogged = false;
  static Brightness brightnessMode = Brightness.light;
}
