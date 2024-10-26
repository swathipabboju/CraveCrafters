import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/model/food_items_details.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/viewModel/dashboard_view_model.dart';

class CategoryTypeWidget extends StatefulWidget {
  final List<Categories>? categoryList;
  final Widget? categorWiseWidget;

  const CategoryTypeWidget(
      {super.key, this.categoryList, this.categorWiseWidget});

  @override
  _CustomHorizontalTabsState createState() => _CustomHorizontalTabsState();
}

class _CustomHorizontalTabsState extends State<CategoryTypeWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.categoryList?.length ?? 0, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final dashboardProvider =
            Provider.of<DashboardViewModel>(context, listen: false);
        dashboardProvider.intializeCategorywiseList();
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TabBar Widget
        Container(
          color: Colors.white, // Background color of tabs
          child: SingleChildScrollView(
            // Make tabs scrollable
            scrollDirection: Axis.horizontal,
            child: TabBar(
              controller: _tabController,
              isScrollable: true, // Enable scrollable tabs
              indicatorColor: Colors.transparent, // No default indicator
              tabs: List.generate(widget.categoryList?.length ?? 0, (index) {
                return ElevatedButton(
                  onPressed: () {
                    dashboardProvider.onCategoryTabChanged(
                        index, _tabController);
                  }, // Call the tab tap handler
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // Rounded corners
                    ),
                    elevation: dashboardProvider.selectedCategoryIndex == index
                        ? 5
                        : 0, // Add elevation for selected tab
                  ),
                  child: Text(
                    widget.categoryList?[index].categoryName ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: dashboardProvider.selectedCategoryIndex == index
                          ? AppColors.orange // Text color for selected tab
                          : AppColors.blackCode, // Text color for unselected tab
                    ),
                  ),
                );
              }),
            ),
          ),
        ),

        // TabBarView Widget for displaying content dynamically
        Expanded(child: widget.categorWiseWidget ?? SizedBox.shrink()),
      ],
    );
  }
}
