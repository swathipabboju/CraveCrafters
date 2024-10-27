import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/constants/string_constants.dart';
import 'package:sample_app/res/constants/text_styles.dart';
import 'package:sample_app/res/reusable_widgets/food_item_card.dart';
import 'package:sample_app/res/reusable_widgets/individual_food_item.dart';
import 'package:sample_app/res/reusable_widgets/category_type_widget.dart';
import 'package:sample_app/res/reusable_widgets/show_food_item_details.dart';
import 'package:sample_app/viewModel/dashboard_view_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HorizontalImageCarousel extends StatefulWidget {
  const HorizontalImageCarousel({
    super.key,
  });

  @override
  _HorizontalImageCarouselState createState() =>
      _HorizontalImageCarouselState();
}

class _HorizontalImageCarouselState extends State<HorizontalImageCarousel> {
  int currentIndex = 0; // Keep track of the current page index

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardViewModel>(context);
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
          if (dashboardProvider.totalCategoryList != null &&
              dashboardProvider.totalCategoryList!.isNotEmpty) ...[
            CarouselSlider.builder(
              itemCount: dashboardProvider.totalCategoryList?.length ?? 0,
              itemBuilder: (context, index, realIndex) {
                return Center(
                    child: FoodItemCard(
                  imageUrl: dashboardProvider
                          .totalCategoryList?[index].items?.first.imageUrl ??
                      "",
                  price: dashboardProvider
                          .totalCategoryList?[index].items?.first.price
                          .toString() ??
                      "",
                ));
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
                count: dashboardProvider.totalCategoryList?.length ?? 0,
                effect: ExpandingDotsEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: AppColors.blackCode,
                  dotColor: Colors.grey,
                ),
              ),
            ),
            Expanded(
                child: CategoryTypeWidget(
              categoryList: dashboardProvider.totalCategoryList,
              categorWiseWidget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: dashboardProvider.categoryWiseList?.length ?? 0,
                  itemBuilder: (context, categoryIndex) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return FoodItemDetailsBottomSheet(
                              menuItem: dashboardProvider
                                  .categoryWiseList?[categoryIndex],
                              nutritionalInfo: dashboardProvider
                                  .categoryWiseList?[categoryIndex]
                                  .nutritionalInfo,
                            );
                          },
                        );
                      },
                      child: IndividualFoodItem(
                        items:
                            dashboardProvider.categoryWiseList?[categoryIndex],
                      ),
                    );
                  },
                ),
              ),
            )),
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
