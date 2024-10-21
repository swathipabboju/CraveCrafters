import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/constants/string_constants.dart';
import 'package:sample_app/viewModel/loginViewModel.dart';
import 'res/routes/app_pages.dart';
import 'res/routes/app_routes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      
         ChangeNotifierProvider(create: (_) => LoginViewModel()),
     
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        initialRoute: AppRoutes.initial,
        routes: AppPages.routes,
        theme: ThemeData(
          primarySwatch: AppColors.appbarSwatch,
        ),
      ),
    );
  }
}
