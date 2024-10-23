import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/model/food_items_details.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/constants/text_styles.dart';
import 'package:sample_app/res/reusable_widgets/text_widget.dart';
import 'package:sample_app/viewModel/dashboard_view_model.dart';

class ItemCounter extends StatefulWidget {
  final Menu? selectedItem;

  const ItemCounter({
    Key? key,
    this.selectedItem,
  }) : super(key: key);

  @override
  _ItemCounterState createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  void showCartPageDetails(DashboardViewModel dashboardProvider) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: dashboardProvider.cartItemsList?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = dashboardProvider.cartItemsList?[index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Item Image
                            Image.network(
                              item?.imageUrl.toString() ?? "",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            // Item Details
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item?.name.toString() ?? "",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '\$${item?.price?.toStringAsFixed(2)}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Item Counter and Total Price per Item
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ItemCounter(),
                                const SizedBox(height: 8),
                                Text(
                                  'Total: \$${(item?.price?.toInt() ?? 0) * (item?.price?.toInt() ?? 0)}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              // Final Price Display
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${dashboardProvider.count.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle checkout or payment process
                },
                child: Text('Checkout'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardViewModel>(context);

    // Set a fixed height for the cards
    double cardHeight = MediaQuery.of(context).size.height * 0.08;
    // double cardwidthe = MediaQuery.of(context).size.width * 0.05;

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
          ),

          const SizedBox(width: 8.0), // Space between the cards

          // Add to Cart Card
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: GestureDetector(
                    onTap: () {
                      if (mounted) {
                        // Check if the widget is still mounted
                        showCartPageDetails(dashboardProvider);
                      }
                    },
                    child: Card(
                      color: AppColors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cart',
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            "24 min. \$90",
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  duration: Duration(seconds: 2),
                  backgroundColor: AppColors.black,
                ),
              );
            },
            child: SizedBox(
              height: cardHeight,
              child: Card(
                color: AppColors.black,
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min, // Use min size to avoid overflow
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
                        msg:
                            "\$${(widget.selectedItem?.price ?? 0).toInt() * (dashboardProvider.count)}",
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
