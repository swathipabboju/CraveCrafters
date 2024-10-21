import 'package:flutter/material.dart';
import 'package:sample_app/res/constants/text_styles.dart';

class TextWidget extends StatelessWidget {
  final String? msg;
  final bool? header;
  const TextWidget({super.key, this.msg, this.header});

  @override
  Widget build(BuildContext context) {
    return Text(
      msg.toString(),
      style: (header ?? false) ?TextStyles.header: TextStyle(),
    );
  }
}
