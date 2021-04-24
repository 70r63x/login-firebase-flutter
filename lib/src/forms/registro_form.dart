import 'package:flutter/material.dart';

import '../utils/utils.dart';
import '../bloc/provider.dart';
import '../providers/usuario_provider.dart';

class RegistroForm extends StatefulWidget {
  @override
  RegistroFormState createState() {
    return RegistroFormState();
  }
}

class RegistroFormState extends State<RegistroForm> {
  final _formKey = GlobalKey<FormState>();
  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = Provider.of(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Crear cuenta',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 30.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _emailInput(bloc),
                      SizedBox(height: 20.0),
                      _passwordInput(bloc),
                      SizedBox(height: 30.0),
                      _submitButton(bloc),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            child: Text('¿Ya tienes cuenta? Login'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _emailInput(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.deepPurple),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electrónico',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _passwordInput(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.deepPurple),
              labelText: 'Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _submitButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ElevatedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 13.0),
              child: Text(
                'Crear cuenta',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 0.0,
              primary: Colors.deepPurple,
            ),
            onPressed:
                snapshot.hasData ? () => _onSubmit(bloc, context) : null);
      },
    );
  }

  void _onSubmit(LoginBloc bloc, BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      print('faltan campos');
    } else {
      Map info = await usuarioProvider.nuevoUsuario(bloc.email, bloc.password);
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
