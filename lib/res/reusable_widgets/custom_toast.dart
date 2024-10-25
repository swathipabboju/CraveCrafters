import 'package:flutter/material.dart';
import 'package:sample_app/res/reusable_widgets/show_cart_page_details.dart';

class CustomToast {
  static void show(BuildContext context, String title, String subtitle) {
    // Get the overlay state from the context
    final overlay = Overlay.of(context);

    // Define an entry for the overlay
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50, // Adjust the position as per your requirement
        left: 20, // Adjust the horizontal position
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return CartDetailWidget();
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.black, // Customize the background color
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Toast message
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry into the overlay
    overlay.insert(overlayEntry);

    // Remove the toast after a delay
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
