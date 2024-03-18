import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double width, height;
  const AppLogo({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      width: width,
      height: height,
      curve: Curves.fastEaseInToSlowEaseOut,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage('assets/images/picarus.png'),
        ),
      ),
    );
  }
}
