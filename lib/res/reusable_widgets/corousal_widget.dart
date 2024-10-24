import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/model/food_category_details.dart';
import 'package:sample_app/model/food_items_details.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/constants/string_constants.dart';
import 'package:sample_app/res/constants/text_styles.dart';
import 'package:sample_app/res/reusable_widgets/individual_food_item.dart';
import 'package:sample_app/res/app_assets/assetpath.dart';
import 'package:sample_app/res/reusable_widgets/item_counter.dart';
import 'package:sample_app/res/reusable_widgets/nutritions_info_card.dart';
import 'package:sample_app/res/reusable_widgets/tab_barr_view.dart';
import 'package:sample_app/viewModel/dashboard_view_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HorizontalImageCarousel extends StatefulWidget {
  final List<Menu>? menuList;
  final List<FoodCategories>? categoryList;

  const HorizontalImageCarousel({
    super.key,
    this.menuList,
    this.categoryList,
  });

  @override
  _HorizontalImageCarouselState createState() =>
      _HorizontalImageCarouselState();
}

class _HorizontalImageCarouselState extends State<HorizontalImageCarousel> {
  int currentIndex = 0; // Keep track of the current page index

  void showFoodItemDetails(
      Menu menuItem, List<NutritionalInfo>? nutritionalInfo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow scrolling
      backgroundColor: Colors.transparent, // Makes the background transparent
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior
              .opaque, // Ensures taps outside the content are detected
          onTap: () {
            Navigator.pop(context); // Close the bottom sheet on tap outside
          },
          child: DraggableScrollableSheet(
            initialChildSize: 0.9, // Height of the bottom sheet when opened
            minChildSize: 0.5, // Minimum height when sheet is scrolled down
            builder: (context, scrollController) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                }, // Prevents closing when tapping inside the sheet
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    // Allow scrolling
                    child: Card(
                      child: Column(
                        children: [
                          Image.network(
                            menuItem.imageUrl ?? "",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(AppAssets.AppIcon);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              menuItem.name ?? "", // Use menu item name
                              style: TextStyles.header.copyWith(fontSize: 24),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              menuItem.description ?? '',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add in poke",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                  weight: 50,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100, // Set a fixed height for ItemCounter
                            child: ItemCounter(
                              selectedItem: menuItem,
                              ontap: () {
                                Navigator.pop(context);
                                showCustomToast(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void showCustomToast(BuildContext context) {
    // Get the overlay state from the context
    final overlay = Overlay.of(context);

    // Define an entry for the overlay
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50, // Adjust the position as per your requirement
        left: 20, // Adjust the horizontal position
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              showCartPageDetails();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.black, // Customize the background color
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Toast message
                  Text(
                    'Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "24 min. \$90",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry into the overlay
    overlay?.insert(overlayEntry);

    // Remove the toast after a delay
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  void showCartPageDetails() {
    final dashboardProvider = Provider.of<DashboardViewModel>(context,listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow scrolling
      backgroundColor: Colors.transparent,
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.hitOftheWeek,
            style: TextStyles.header,
          ),
          const SizedBox(height: 30),
          if (widget.menuList != null && widget.menuList!.isNotEmpty) ...[
            CarouselSlider.builder(
              itemCount: widget.menuList?.length ?? 0,
              itemBuilder: (context, index, realIndex) {
                return Center(
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        width: double.infinity,
                        widget.menuList?[index].imageUrl ?? "",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(AppAssets.AppIcon);
                        },
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.center,
              child: AnimatedSmoothIndicator(
                activeIndex: currentIndex,
                count: widget.menuList?.length ?? 0,
                effect: ExpandingDotsEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: AppColors.black,
                  dotColor: Colors.grey,
                ),
              ),
            ),
            Expanded(
                child: CustomHorizontalTabs(
              categoryList: widget.categoryList,
            )),
            Expanded(
              child: ListView.builder(
                itemCount: widget.menuList?.length ?? 0,
                itemBuilder: (context, menuIndex) {
                  return GestureDetector(
                    onTap: () {
                      showFoodItemDetails(widget.menuList![menuIndex],
                          widget.menuList?[menuIndex].nutritionalInfo);
                    },
                    child: IndividualFoodItem(
                      imageUrls: widget.menuList,
                      index: menuIndex,
                    ),
                  );
                },
              ),
            ),
          ] else ...[
            Center(
              child: Text('No menu items available.'),
            ),
          ],
        ],
      ),
    );
  }
}
