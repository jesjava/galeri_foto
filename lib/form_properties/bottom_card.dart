import 'package:flutter/material.dart';

class BottomCard extends StatelessWidget {
  final double width, height;
  final Widget child;
  const BottomCard({
    super.key,
    required this.width,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(42, 45, 50, 0.2),
              offset: Offset(0, 0),
              blurRadius: 3,
              spreadRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: child,
      ),
    );
  }
}
