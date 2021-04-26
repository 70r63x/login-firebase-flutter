import 'package:flutter/material.dart';

import '../../theme_colors.dart';
import '../components/rounded_password_field.dart';
import '../components/rounded_input_field.dart';

import '../utils/utils.dart';
import '../bloc/provider.dart';
import '../providers/usuario_provider.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = Provider.of(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // SafeArea(
          //   child: Container(
          //     height: 180.0,
          //   ),
          // ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            //padding: EdgeInsets.symmetric(vertical: 50.0),
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.circular(5.0),
            //   boxShadow: <BoxShadow>[
            //     BoxShadow(
            //         color: Colors.black26,
            //         blurRadius: 3.0,
            //         offset: Offset(0.0, 5.0),
            //         spreadRadius: 3.0)
            //   ],
            // ),
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      RoundedInputField(
                        hintText: "ejemplo@correo.com",
                        labelText: 'Correo electrónico',
                        icon: Icons.email,
                        onChanged: bloc.changeEmail,
                        typeInput: TextInputType.emailAddress,
                        bloc: bloc,
                      ),
                      RoundedPasswordField(
                        labelText: "Contraseña",
                        icon: Icons.lock,
                        onChanged: bloc.changePassword,
                        bloc: bloc,
                      ),
                      // RoundedButton(
                      //   text: "INGRESAR",
                      //   press: () {},
                      // ),
                      _submitButton(bloc),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Text('¿Olvido la contraseña?'),
          // TextButton(
          //   child: Text('Crear cuenta'),
          //   onPressed: () =>
          //       Navigator.pushReplacementNamed(context, 'registro'),
          // ),
          // SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _submitButton(LoginBloc bloc) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: size.width * 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              ),
              child: Text(
                "INGRESAR",
                style: TextStyle(color: Colors.white),
              ),
              onPressed:
                  snapshot.hasData ? () => _onSubmit(bloc, context) : null,
            ),
          ),
        );
      },
    );
  }

  void _onSubmit(LoginBloc bloc, BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      print('faltan campos');
    } else {
      Map info = await usuarioProvider.login(bloc.email, bloc.password);
      print(info);
      if (info['ok']) {
        _formKey.currentState.save();
        Navigator.pushReplacementNamed(context, 'home');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login correcto'),
          ),
        );
      } else {
        openDialogAlert(context, info['mensaje']);
      }
    }
  }
}
