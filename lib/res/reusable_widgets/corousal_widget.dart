import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sample_app/model/food_items_details.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/constants/string_constants.dart';
import 'package:sample_app/res/constants/text_styles.dart';
import 'package:sample_app/res/reusable_widgets/individual_food_item.dart';

// Import for smooth indicators
import 'package:sample_app/res/app_assets/assetpath.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HorizontalImageCarousel extends StatefulWidget {
  final List<Menu>? menuList;

  const HorizontalImageCarousel({super.key, this.menuList});
  @override
  _HorizontalImageCarouselState createState() =>
      _HorizontalImageCarouselState();
}

class _HorizontalImageCarouselState extends State<HorizontalImageCarousel> {
  int currentIndex = 0; // Keep track of the current page index

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
              child: ListView.builder(
                itemCount: widget.menuList?.length ?? 0,
                itemBuilder: (context, imageurlIndex) {
                  return IndividualFoodItem(
                    imageUrls: widget.menuList,
                    index: imageurlIndex,
                  );
                },
              ),
            ),
          ] else ...[
            Center(
              child: Text('No menu items available.'),
            ),
          ]
        ],
      ),
    );
  }
}
