import 'package:flutter/material.dart';
import 'package:galeri_foto/form.dart';

void main() => runApp(const GaleriFoto());

class GaleriFoto extends StatelessWidget {
  const GaleriFoto({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormWidget(),
    );
  }
}
