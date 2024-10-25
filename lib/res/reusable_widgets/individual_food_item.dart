import 'package:flutter/material.dart';
import 'package:sample_app/model/food_items_details.dart';
import 'package:sample_app/res/app_assets/assetpath.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/constants/text_styles.dart';
import 'package:sample_app/res/reusable_widgets/text_widget.dart';

class IndividualFoodItem extends StatelessWidget {
  final Items? items;

  const IndividualFoodItem({
    super.key,
    this.items,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child: Image.network(
              items?.imageUrl ?? "",
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(AppAssets
                    .AppIcon); // Local placeholder if the image fails to load
              },
            )),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextWidget(
                      msg: items?.name,
                      align: TextAlign.center,
                      textStyle: TextStyles.regular,
                    ),
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
                          msg: "\$${items?.price}",
                        ),
                      ),
                      TextWidget(
                        msg: "${items?.nutritionalInfo?[0].value} ${items?.nutritionalInfo?[0].nutritionName}",
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
