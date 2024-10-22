import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sample_app/model/food_category_details.dart';
import 'package:sample_app/model/food_items_details.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/constants/string_constants.dart';
import 'package:sample_app/res/constants/text_styles.dart';
import 'package:sample_app/res/reusable_widgets/individual_food_item.dart';

// Import for smooth indicators
import 'package:sample_app/res/app_assets/assetpath.dart';
import 'package:sample_app/res/reusable_widgets/item_counter.dart';
import 'package:sample_app/res/reusable_widgets/tab_barr_view.dart';
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

  void showFoodItemDetails(Menu menuItem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow scrolling
      backgroundColor: Colors.transparent, // Makes the background transparent
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height *
                0.9, // 80% of screen height
            decoration: BoxDecoration(
              color: Colors.white, // Background color for the bottom sheet
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                // Add the image

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
                // Add other details here
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    menuItem.description ?? '',
                    style: TextStyles.regular,
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  children: [
                    ItemCounter(
                      selectedItem: menuItem,
                    )
                  ],
                ),
                // Close button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  child: Text('Close'),
                ),
              ],
            ),
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
                itemBuilder: (context, imageurlIndex) {
                  return GestureDetector(
                    onTap: () =>
                        showFoodItemDetails(widget.menuList![imageurlIndex]),
                    child: IndividualFoodItem(
                      imageUrls: widget.menuList,
                      index: imageurlIndex,
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
