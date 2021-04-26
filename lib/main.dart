import 'package:flutter/material.dart';

import 'src/bloc/provider.dart';
import './routes.dart';
import './src/pref_user/user_pref.dart';

import './theme_colors.dart';

import './src/pages/error_404.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'welcome',
        routes: getAplicationRoutes(),
        onGenerateRoute: (RouteSettings settings) {
          print('Ruta llamada ${settings.name}');

          return MaterialPageRoute(builder: (context) => Page404());
        },
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
      ),
    );
  }
}
