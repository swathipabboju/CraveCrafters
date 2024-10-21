import 'package:flutter/material.dart';
import 'package:sample_app/res/app_assets/assetpath.dart';
import 'package:sample_app/res/constants/string_constants.dart';
import 'package:sample_app/res/routes/app_routes.dart';

class LogOutAlert {
  showAlert({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10, top: 50, right: 10, bottom: 10),
                    margin: const EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(0, 10),
                              blurRadius: 10),
                        ]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          AppStrings.appName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          AppStrings.logoutApplMsg,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, AppRoutes.dashboard);
                              },
                              child: const Text(
                                AppStrings.yes,
                                style: TextStyle(
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                AppStrings.no,
                                style: TextStyle(
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 10,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(35)),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Image.asset(AppAssets.warningblue),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
