import 'package:flutter/material.dart';

import 'src/pages/home_page.dart';
import 'src/pages/login_page.dart';
import 'src/pages/registro_page.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => LoginPage(),
    'registro': (BuildContext context) => RegistroPage(),
    'home': (BuildContext context) => HomePage(),
  };
}
