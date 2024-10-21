import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  const ReusableButton({super.key, this.onPressed, required this.ButtonText});
  final Function()? onPressed;
  final String ButtonText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ElevatedButton(
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                ButtonText,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            )),
      ),
    );
  }
}
