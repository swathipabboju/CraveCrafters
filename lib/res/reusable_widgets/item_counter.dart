import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/model/food_items_details.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/reusable_widgets/text_widget.dart';
import 'package:sample_app/viewModel/dashboard_view_model.dart';

class ItemCounter extends StatefulWidget {
  final Menu selectedItem;

  const ItemCounter({
    Key? key,
    required this.selectedItem,
  }) : super(key: key);

  @override
  _ItemCounterState createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardViewModel>(context);

    // Set a fixed height for the cards
    double cardHeight = MediaQuery.of(context).size.height * 0.08;
    // double cardwidthe = MediaQuery.of(context).size.width * 0.05;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Counter Card
        SizedBox(
          height: cardHeight,
          child: Card(
            child: Row(
              mainAxisSize: MainAxisSize.min, // Use min size to avoid overflow
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0), // Adjust padding
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

        const SizedBox(width: 8.0), // Space between the cards

        // Add to Cart Card
        Container(
          height: cardHeight,
          child: Card(
            color: AppColors.black,
            child: Row(
              mainAxisSize: MainAxisSize.min, // Use min size to avoid overflow
              children: [
                // Flexible widget to allow text to adapt
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0), // Padding inside the card
                    child: TextWidget(
                      msg: "Add to cart",
                      textStyle: TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // Price text
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0), // Padding for the price
                  child: TextWidget(
                    msg: "\$${widget.selectedItem.price}",
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
      ],
    );
  }
}
