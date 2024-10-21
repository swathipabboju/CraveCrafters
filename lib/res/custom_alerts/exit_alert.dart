import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitAlert {
  showAlert({
    required BuildContext context,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Exit application?",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Are you sure you want to Exit from this application?",
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'NO',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },
                  child: const Text(
                    'YES',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
