import 'package:flutter/material.dart';
import 'package:sample_app/model/food_items_details.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/reusable_widgets/text_widget.dart';
import 'package:sample_app/viewModel/dashboard_view_model.dart';

class ItemCounter extends StatelessWidget {
  final Items? selectedItem;
  final Function()? ontap;
  final DashboardViewModel? dashboardProvider;

  const ItemCounter({
    Key? key,
    this.selectedItem,
    this.ontap,
    this.dashboardProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set a fixed height for the cards
    double cardHeight = MediaQuery.of(context).size.height * 0.08;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Counter Card
            Expanded(
              child: SizedBox(
                height: cardHeight,
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize:
                        MainAxisSize.min, // Use min size to avoid overflow
                    children: [
                      IconButton(
                        onPressed: () {
                          WidgetsBinding.instance.addPostFrameCallback(
                            (timeStamp) {
                              dashboardProvider
                                  ?.onRemoveItem(selectedItem?.price);
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.remove,
                          size: 30,
                        ),
                        color: AppColors.black,
                      ),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '${dashboardProvider?.count}', // Display current count
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          WidgetsBinding.instance.addPostFrameCallback(
                            (timeStamp) {
                              dashboardProvider?.onAddItem(selectedItem?.price);
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                        ),
                        color: AppColors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8.0), // Space between the cards

            // Add to Cart Card
            Expanded(
              child: GestureDetector(
                onTap: ontap,
                child: SizedBox(
                  height: cardHeight,
                  child: Card(
                    color: AppColors.black,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextWidget(
                              msg: "Add to cart",
                              textStyle: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: FittedBox(
                            child: TextWidget(
                              // msg: "\$${(widget.selectedItem?.price ?? 0).toInt() * dashboardProvider.count}",
                              msg: "\$${dashboardProvider?.individulaPrice}",
                              textStyle: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        /*  Flexible(
                          flex: 1,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextWidget(
                                                          msg: "\$${dashboardProvider.individulaPrice}",

                              textStyle: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ), */
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
