import 'package:flutter/material.dart';
import 'package:sample_app/res/app_assets/assetpath.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/constants/text_styles.dart';
import 'package:sample_app/res/reusable_widgets/text_widget.dart';

class IndividualFoodItem extends StatefulWidget {
  final List? imageUrls;
  final int index;
  const IndividualFoodItem({super.key, this.imageUrls, required this.index});

  @override
  State<IndividualFoodItem> createState() => _IndividualFoodItemState();
}

class _IndividualFoodItemState extends State<IndividualFoodItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: Image.asset(widget.imageUrls?[widget.index])),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
               // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    msg: "Pizza",
                    header: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            textStyle: WidgetStateProperty.all(
                                TextStyle(color: AppColors.black))),
                        child: TextWidget(
                          msg: "\$250",
                        ),
                      ),
                      TextWidget(
                        msg: "327kCal",
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
