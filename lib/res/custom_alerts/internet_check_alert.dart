import 'package:flutter/cupertino.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/constants/string_constants.dart';


class InternetCheckAlert {
  showAlert(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            AppStrings.appName,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Column(
            children: [
              Text(
                "No Internet Connection",
                style: TextStyle(fontSize: 13, color: AppColors.black),
              ),
              SizedBox(height: 8.0),
              Text(
                "Please check your internet connection and try again.",
                style: TextStyle(fontSize: 12, color: AppColors.black),
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                AppStrings.ok,
                style: TextStyle(color: AppColors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
