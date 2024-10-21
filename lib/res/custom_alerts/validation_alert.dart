import 'package:flutter/cupertino.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/constants/string_constants.dart';


class ValidationAlert {
  showAlert(
      {required BuildContext context,
      required String title,
      void Function()? onPressed}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Column(
            children: <Widget>[
              Icon(
                CupertinoIcons.exclamationmark_circle,
                size: 60.0,
                color: AppColors.appbarColour,
              ),
              SizedBox(height: 8.0),
              Text(
                AppStrings.appName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(title),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: onPressed ??
                  () {
                    Navigator.pop(context);
                  },
              child: const Text(
                AppStrings.ok,
                style: TextStyle(
                  color: AppColors.appbarColour,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
