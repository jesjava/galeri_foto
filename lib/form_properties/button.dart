import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  final double width;
  final String buttonText;
  const WidgetButton({
    super.key,
    required this.width,
    required this.buttonText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: 45,
      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(54, 76, 225, 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
