import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/constants/string_constants.dart';
import 'package:sample_app/res/constants/text_styles.dart';
import 'package:sample_app/res/reusable_widgets/food_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Import for smooth indicators
import 'package:sample_app/res/app_assets/assetpath.dart';

class HorizontalImageCarousel extends StatefulWidget {
  @override
  _HorizontalImageCarouselState createState() =>
      _HorizontalImageCarouselState();
}

class _HorizontalImageCarouselState extends State<HorizontalImageCarousel> {
  final List<String> imageUrls = [
    AppAssets.pizza,
    AppAssets.manchuria,
    AppAssets.momo,
  ];

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
          SizedBox(
            height: 30,
          ),
          CarouselSlider.builder(
            itemCount: imageUrls.length,
            itemBuilder: (context, index, realIndex) {
              return Center(
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15.0), // Set the border radius here
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        15.0), // Match the card's border radius
                    child: Image.asset(
                      width: double.infinity,
                      imageUrls[index],
                      fit: BoxFit.cover, // Ensure image fits the container
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
                pageSnapping: true,
                // height: 200.0, // Height of the carousel
                autoPlay: true, // Auto-scroll feature
                enlargeCenterPage: true, // Highlight the center item
                enableInfiniteScroll: true, // Loop the carousel infinitely
                scrollDirection: Axis.horizontal, // Horizontal scrolling
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index; // Update the current index
                  });
                }),
          ),
          SizedBox(height: 16.0),
          Align(
            alignment: Alignment.center,
            child: AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: imageUrls.length,
              effect: ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: AppColors.black, // Active dot color
                dotColor: Colors.grey, // Inactive dot color
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: imageUrls.length,
              itemBuilder: (context, imageurlIndex) {
                return IndividualFoodItem(
                  imageUrls: imageUrls,
                  index: imageurlIndex,
                ); // Replace with your item widget
              },
            ),
          ),
        ],
      ),
    );
  }
}
