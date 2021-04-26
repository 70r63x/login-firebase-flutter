import 'package:flutter/material.dart';

// import 'src/pages/login_page.dart';
// import 'src/pages/registro_page.dart';
//
import 'src/pages/login/login_screen.dart';
import 'src/pages/home_page.dart';
import 'src/pages/signup/signup_screen.dart';
import 'src/pages/welcome/welcome_screen.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    'welcome': (BuildContext context) => WelcomeScreen(),
    'login': (BuildContext context) => LoginScreen(),
    'registro': (BuildContext context) => SignUpScreen(),
    'home': (BuildContext context) => HomePage(),
  };

  // return <String, WidgetBuilder>{
  //   'login': (BuildContext context) => LoginPage(),
  //   'registro': (BuildContext context) => RegistroPage(),
  //   'home': (BuildContext context) => HomePage(),
  // };
}
