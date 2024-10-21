import 'package:flutter/cupertino.dart';
import 'package:sample_app/res/constants/string_constants.dart';


class WarningCustomCupertinoAlert {
  showAlert(BuildContext context,
      {required String message, required void Function()? onPressed}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Column(
            children: <Widget>[
              const Icon(
                CupertinoIcons.info,
                size: 60.0,
                color: CupertinoColors.systemBlue,
              ),
              const SizedBox(height: 8.0),
              Text("Version : ${AppStrings.version}",
                  style: const TextStyle(fontWeight: FontWeight.normal)),
              const SizedBox(height: 8.0),
              /*  Text(
                AppStrings.appName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ), */
            ],
          ),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: onPressed ?? () => Navigator.pop(context),
              child: const Text(
                'OK',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}
