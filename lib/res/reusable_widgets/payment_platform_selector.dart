import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/model/payment_platform_model.dart';
import 'package:sample_app/res/reusable_widgets/build_dropdown_widget.dart';
import 'package:sample_app/viewModel/dashboard_view_model.dart';
import 'package:sample_app/res/reusable_widgets/dropdown_component.dart'; // Ensure this path is correct

class PaymentPlatformSelector extends StatefulWidget {
  @override
  _PaymentPlatformSelectorState createState() =>
      _PaymentPlatformSelectorState();
}

class _PaymentPlatformSelectorState extends State<PaymentPlatformSelector> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final provider =
            Provider.of<DashboardViewModel>(context, listen: false);
        await provider.loadPaymentPlatformData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardViewModel>(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.payment, size: 30), // Payment icon
                SizedBox(width: 10),
                // Display selected platform name
                Text(
                  provider.selectedPlatform?.name ?? "Select Payment",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            // Dropdown button to open the dropdown menu
            /* IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: () {
                // Triggering dropdown change in a different manner
                setState(() {
                  provider.isDropdownOpen =
                      !provider.isDropdownOpen; // Toggle dropdown visibility
                });
              },
            ), */
          ],
        ),
        // Build the dropdown widget

        buildDropdownWidget<PaymentPlatform>(
          context,
          provider.paymentPlatforms ??
              [], // List of payment platforms from the provider
          provider.selectedPlatform, // Currently selected platform
          (platform) => platform.name, // Function to display platform name
          onChanged: (newValue) {
            setState(() {
              provider.selectedPlatform = newValue; // Update selected platform
              // provider.isDropdownOpen = false; // Close dropdown after selection
            });
          },
        ),
      ],
    );
  }
}
