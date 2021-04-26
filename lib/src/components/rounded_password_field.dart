import 'package:flutter/material.dart';

import '../bloc/provider.dart';

import './text_field_container.dart';
import '../../theme_colors.dart';

class RoundedPasswordField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final ValueChanged onChanged;
  final LoginBloc bloc;
  const RoundedPasswordField({
    Key key,
    this.labelText,
    this.icon,
    this.onChanged,
    this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFieldContainer(
          child: TextFormField(
            obscureText: true,
            onChanged: onChanged,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
              labelText: labelText,
              icon: Icon(
                icon,
                color: kPrimaryColor,
              ),
              suffixIcon: Icon(
                Icons.visibility,
                color: kPrimaryColor,
              ),
              border: InputBorder.none,
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
          ),
        );
      },
    );
  }
}
