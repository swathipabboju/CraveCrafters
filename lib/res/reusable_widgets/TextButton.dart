import 'package:flutter/material.dart';

class ReusableTextButton extends StatelessWidget {
  const ReusableTextButton(
      {super.key,
      required this.onPressed,
      required this.ButtonText,
      this.decoration});

  final String ButtonText;
  final Function()? onPressed;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          ButtonText,
          style: TextStyle(decoration: decoration),
        ));
  }
}
