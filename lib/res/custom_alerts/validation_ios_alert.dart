import 'package:flutter/cupertino.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/constants/string_constants.dart';


class ValidationIoSAlert {
  showAlert(BuildContext context, {required String? description}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            AppStrings .appName,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.appbarColour,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            children: [
              const SizedBox(height: 8.0),
              Text(
                "$description",
                style: const TextStyle(fontSize: 12, color: AppColors.black),
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                AppStrings .ok,
                style: TextStyle(color: AppColors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
