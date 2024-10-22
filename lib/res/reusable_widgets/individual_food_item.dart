import 'package:flutter/material.dart';
import 'package:sample_app/model/food_items_details.dart';
import 'package:sample_app/res/app_assets/assetpath.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/reusable_widgets/text_widget.dart';

class IndividualFoodItem extends StatefulWidget {
  final List<Menu>? imageUrls;
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
            Expanded(
                child: Image.network(
                    widget.imageUrls?[widget.index].imageUrl ?? "",
                     errorBuilder: (context, error, stackTrace) {
          return Image.asset(
              AppAssets.AppIcon); // Local placeholder if the image fails to load
        },)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    msg: widget.imageUrls?[widget.index].name,
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
                          msg: "\$${ widget.imageUrls?[widget.index].price}",
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
