import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/res/app_assets/assetpath.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/constants/string_constants.dart';
import 'package:sample_app/res/constants/text_styles.dart';
import 'package:sample_app/res/reusable_widgets/corousal_widget.dart';
import 'package:sample_app/res/reusable_widgets/custom_appbar.dart';
import 'package:sample_app/res/reusable_widgets/individual_food_item.dart';
import 'package:sample_app/viewModel/dashboard_view_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardViewModel>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: AppStrings.dashboard,
        onMenuTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        onHomeTap: () {},
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: AppColors.appbarColour,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      
       body: HorizontalImageCarousel(menuList: dashboardProvider.menuDeatilsList,),

      /*   bottomNavigationBar: const FooterComponent() */
    );
  }
}
