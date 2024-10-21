import 'package:flutter/material.dart';
import 'package:sample_app/view/dashboard.dart';
import 'app_routes.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.dashboard: (context) => Dashboard(),
      
    };
  }
}
