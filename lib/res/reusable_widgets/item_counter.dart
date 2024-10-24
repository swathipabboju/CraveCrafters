import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/model/food_items_details.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/constants/text_styles.dart';
import 'package:sample_app/res/reusable_widgets/text_widget.dart';
import 'package:sample_app/viewModel/dashboard_view_model.dart';

class ItemCounter extends StatefulWidget {
  final Menu? selectedItem;
  final Function()? ontap;

  const ItemCounter({
    Key? key,
    this.selectedItem, this.ontap,
  }) : super(key: key);

  @override
  _ItemCounterState createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  // Show Cart Details in a Modal BottomSheet
  

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardViewModel>(context);

    // Set a fixed height for the cards
    double cardHeight = MediaQuery.of(context).size.height * 0.08;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      onPressed: dashboardProvider.onRemoveItem,
                      icon: const Icon(
                        Icons.remove,
                        size: 30,
                      ),
                      color: AppColors.black,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '${dashboardProvider.count}', // Display current count
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      onPressed: dashboardProvider.onAddItem,
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
          GestureDetector(
            onTap: widget.ontap,
            child: SizedBox(
              height: cardHeight,
              child: Card(
                color: AppColors.black,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextWidget(
                          msg: "Add to cart",
                          textStyle: TextStyle(
                              color: AppColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextWidget(
                        msg:
                            "\$${(widget.selectedItem?.price ?? 0).toInt() * dashboardProvider.count}",
                        textStyle: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
