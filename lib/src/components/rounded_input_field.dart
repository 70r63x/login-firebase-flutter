import 'package:flutter/material.dart';

import '../bloc/provider.dart';

import './text_field_container.dart';
import '../../theme_colors.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData icon;
  final ValueChanged onChanged;
  final TextInputType typeInput;
  final LoginBloc bloc;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.labelText,
    this.icon,
    this.onChanged,
    this.typeInput,
    this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFieldContainer(
          child: TextFormField(
            keyboardType: typeInput,
            onChanged: onChanged,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
              icon: Icon(
                icon,
                color: kPrimaryColor,
              ),
              hintText: hintText,
              labelText: labelText,
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
