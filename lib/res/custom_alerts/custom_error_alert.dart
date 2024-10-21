import 'package:flutter/cupertino.dart';
import 'package:sample_app/res/constants/string_constants.dart';


class ErrorCustomCupertinoAlert {
  showAlert(BuildContext context,
      {required String message, void Function()? onPressed}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title:  Column(
            children: <Widget>[
              const Icon(
                CupertinoIcons.xmark_circle,
                size: 60.0,
                color: CupertinoColors.systemBlue,
              ),
              const SizedBox(height: 8.0),
              Text("${AppStrings.version}",
                  style: const TextStyle(fontWeight: FontWeight.normal)),
              const SizedBox(height: 8.0),
              const Text(
                AppStrings.appName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: onPressed ?? () => Navigator.pop(context),
              child: const Text(
                AppStrings.ok,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}
