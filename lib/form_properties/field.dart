import 'package:flutter/material.dart';

class WidgetTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool obscureText;
  final String labelText;
  final Widget suffixIcon;
  const WidgetTextField({
    super.key,
    required this.textEditingController,
    required this.obscureText,
    required this.labelText,
    required this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: TextField(
        controller: textEditingController,
        obscureText: obscureText,
        cursorColor: Colors.black,
        cursorWidth: 1.5,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 20,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 20,
            color: Colors.black,
          ),
          suffixIcon: suffixIcon,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 0.5),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 0.5),
          ),
        ),
      ),
    );
  }
}
