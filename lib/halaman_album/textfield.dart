import 'package:flutter/material.dart';

widgetTextField(TextEditingController textEditingController, String hintText) {
  return Container(
    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: TextField(
      controller: textEditingController,
      cursorColor: Colors.black,
      cursorWidth: 1.5,
      style: const TextStyle(
        fontFamily: 'Nunito',
        fontSize: 20,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 20,
          color: Colors.black,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: Color.fromRGBO(54, 76, 225, 1),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: Color.fromRGBO(54, 76, 225, 1),
          ),
        ),
      ),
    ),
  );
}
