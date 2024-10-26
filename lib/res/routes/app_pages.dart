import 'package:flutter/material.dart';
import 'package:sample_app/res/custom_alerts/order_confirmed_screen.dart';
import 'package:sample_app/view/dashboard.dart';
import 'package:sample_app/view/splashscreen.dart';
import 'app_routes.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.dashboard: (context) => Dashboard(),
      AppRoutes.orderConfirmed: (context) => OrderConfirmedScreen(),
      AppRoutes.splash: (context) => SplashScreen(),
      
    };
  }
}
