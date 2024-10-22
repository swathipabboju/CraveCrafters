import 'package:flutter/material.dart';
import 'package:sample_app/model/food_category_details.dart';
import 'package:sample_app/res/constants/color_constants.dart';

class CustomHorizontalTabs extends StatefulWidget {
  final List<FoodCategories>? categoryList;

  const CustomHorizontalTabs({super.key, this.categoryList});
  
  @override
  _CustomHorizontalTabsState createState() => _CustomHorizontalTabsState();
}

class _CustomHorizontalTabsState extends State<CustomHorizontalTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0; // Track selected tab index

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.categoryList?.length ?? 0, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });
    _tabController.animateTo(index); // Animate to selected tab
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70), // Height of the tab bar
          child: Container(
            color: Colors.white, // Background color of tabs
            child: SingleChildScrollView( // Make tabs scrollable
              scrollDirection: Axis.horizontal,
              child: TabBar(
                controller: _tabController,
                isScrollable: true, // Enable scrollable tabs
                indicatorColor: Colors.transparent, // No default indicator
                tabs: List.generate(widget.categoryList?.length ?? 0, (index) {
                  return ElevatedButton(
                    onPressed: () => _onTabTapped(index), // Call the tab tap handler
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                      elevation: _selectedIndex == index ? 5 : 0, // Add elevation for selected tab
                     // padding: EdgeInsets.symmetric(horizontal: 5), // Horizontal padding
                    ),
                    child: Text(
                      widget.categoryList?[index].name ?? '', // Use category name
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: _selectedIndex == index
                            ? AppColors.orange // Text color for selected tab
                            : AppColors.black, // Text color for unselected tab
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(widget.categoryList?.length ?? 0, (index) {
          return Center(
            child: Text('${widget.categoryList?[index].name} Tab Content'),
          ); // Dynamic content for each tab
        }),
      ),
    );
  }
}
