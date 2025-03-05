import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final double? size;
  final String? hintText;
  final double width; // New parameter to control width

  const CustomSearchBar({
    super.key,
    this.size,
    this.controller,
    this.hintText,
    this.width = 300, // Default width
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // Set width dynamically
      child: TextField(
        controller: controller,
      ),
    );
  }
}
