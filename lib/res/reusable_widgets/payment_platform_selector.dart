import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/model/payment_platform_model.dart';
import 'package:sample_app/res/reusable_widgets/build_dropdown_widget.dart';
import 'package:sample_app/viewModel/dashboard_view_model.dart';

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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.payment, size: 30), // Payment icon
              SizedBox(width: 10),
              // Display selected platform name
              Text(
                provider.selectedPlatform?.name ?? "Select Payment Platform",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        // Build the dropdown widget

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildDropdownWidget<PaymentPlatform>(
            context,
            provider.paymentPlatforms ??
                [], // List of payment platforms from the provider
            provider.selectedPlatform, // Currently selected platform
            (platform) => platform.name, // Function to display platform name
            onChanged: (newValue) {
              provider.onSelectedPlatform(newValue);
            },
          ),
        ),
      ],
    );
  }
}
