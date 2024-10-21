import 'package:flutter/cupertino.dart';
import 'package:sample_app/res/constants/string_constants.dart';


class SuccessCustomCupertinoAlert {
  showAlert(
      {required BuildContext context,
      required String title,
      void Function()? onPressed}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title:  Column(
            children: <Widget>[
              const Icon(
                CupertinoIcons.checkmark_alt_circle,
                size: 60.0,
                color: CupertinoColors.systemGreen,
              ),
              const SizedBox(height: 8.0),
              Text(
                   '${AppStrings.version}',
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 8.0),
              const Text(
                AppStrings.appName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(title),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: onPressed,
              child: const Text(
                AppStrings.ok,
              ),
            ),
          ],
        );
      },
    );
  }
}
