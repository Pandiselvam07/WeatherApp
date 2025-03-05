import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;

  const CustomText(this.text, {super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: size),
    );
  }
}
