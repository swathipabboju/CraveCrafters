import 'package:flutter/material.dart';
import 'package:sample_app/res/constants/text_styles.dart';

class TextWidget extends StatelessWidget {
  final String? msg;
  final TextAlign? align;
  final TextStyle? textStyle;

  const TextWidget({super.key, this.msg,  this.align, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: align,
      msg.toString(),
      style: textStyle
    );
  }
}
