import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/res/app_assets/assetpath.dart';
import 'package:sample_app/res/constants/string_constants.dart';
import 'package:sample_app/res/custom_alerts/exit_alert.dart';
import 'package:sample_app/res/reusable_widgets/corousal_widget.dart';
import 'package:sample_app/res/reusable_widgets/custom_appbar.dart';
import 'package:sample_app/res/reusable_widgets/food_item_card.dart';
import 'package:sample_app/res/reusable_widgets/show_cart_page_details.dart';
import 'package:sample_app/viewModel/dashboard_view_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final dashboardProvider =
            Provider.of<DashboardViewModel>(context, listen: false);
        await dashboardProvider.loadRestaurantData();
        debugPrint("cate ${dashboardProvider.totalCategoryList?.length}");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          ExitAlert().showAlert(context: context);
        }
      },
      child: Scaffold(
          key: _scaffoldKey,
          appBar: CustomAppBar(
            title: AppStrings.dashboard,
            onMenuTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            onHomeTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return CartDetailWidget();
                },
              );
            },
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height *
                      0.2, // Adjust this height as needed
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.app_launcher),
                      fit: BoxFit
                          .cover, // Ensure the image covers the entire container
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Dashboard',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: /* FoodItemCard(
            imageUrl:
                "https://againstthegraingourmet.com/cdn/shop/products/Pepperoni_Pizza_Beauty_1200x1200.jpg?v=1658703726",
                
            price: '30',
          )  */HorizontalImageCarousel(),
          ),
    );
  }
}
