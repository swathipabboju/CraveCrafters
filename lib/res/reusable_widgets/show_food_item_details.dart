import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/model/food_items_details.dart';
import 'package:sample_app/res/app_assets/assetpath.dart';
import 'package:sample_app/res/constants/text_styles.dart';
import 'package:sample_app/viewModel/dashboard_view_model.dart';
 
import 'nutritions_info_card.dart'; // Adjust the import according to your project structure
import 'item_counter.dart'; // Adjust the import according to your project structure
 
class FoodItemDetailsBottomSheet extends StatelessWidget {
  final Items? menuItem;
  final List<NutritionalInfo>? nutritionalInfo;
 
  const FoodItemDetailsBottomSheet({
    Key? key,
    required this.menuItem,
    required this.nutritionalInfo,
  }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardViewModel>(context);
 
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context);
        dashboardProvider.resetCount(menuItem);
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            dashboardProvider.resetCount(menuItem);
            Navigator.pop(context);
          }
        },
        child: DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return GestureDetector(
              onTap: () {
                Navigator.pop(context);
                dashboardProvider.resetCount(menuItem);
                // Prevents closing when tapping inside the sheet
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  controller: scrollController, // Attach scroll controller
                  child: Stack(
                    children: [
                      Card(
                        child: Column(
                          children: [
                            Image.network(
                              menuItem?.imageUrl ?? "",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(AppAssets.app_logo);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                menuItem?.name ?? "",
                                style: TextStyles.header.copyWith(fontSize: 24),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                menuItem?.description ?? '',
                                style: TextStyles.regular,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            NutritionsInfoCard(
                              nutritionalInfoList: nutritionalInfo,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Add in poke",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              child: ItemCounter(
                                selectedItem: menuItem,
                                ontap: () {
                                  dashboardProvider.onAddToCart(
                                      menuItem, context);
                                  dashboardProvider.resetCount(menuItem);
                                },
                                dashboardProvider: dashboardProvider,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Cancel icon positioned at the top right
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            dashboardProvider.resetCount(menuItem);
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}