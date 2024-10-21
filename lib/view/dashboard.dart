import 'package:flutter/material.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/constants/string_constants.dart';
import 'package:sample_app/res/reusable_widgets/corousal_widget.dart';
import 'package:sample_app/res/reusable_widgets/custom_appbar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
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
      body: Stack(children: [
        // const SizedBox(width: 30),
        HorizontalImageCarousel()
      ]), /*   bottomNavigationBar: const FooterComponent() */
    );
  }
}
