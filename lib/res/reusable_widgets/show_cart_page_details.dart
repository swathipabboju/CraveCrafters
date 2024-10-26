import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/res/app_assets/assetpath.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/constants/string_constants.dart';
import 'package:sample_app/res/constants/text_styles.dart';
import 'package:sample_app/res/reusable_widgets/pay_widget.dart';
import 'package:sample_app/res/reusable_widgets/payment_platform_selector.dart';
import 'package:sample_app/res/reusable_widgets/text_widget.dart';
import 'package:sample_app/viewModel/dashboard_view_model.dart';

class CartDetailWidget extends StatefulWidget {
  const CartDetailWidget({Key? key}) : super(key: key);

  @override
  State<CartDetailWidget> createState() => _CartDetailWidgetState();
}

class _CartDetailWidgetState extends State<CartDetailWidget> {
  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final dashboardProvider =
            Provider.of<DashboardViewModel>(context, listen: false);
        dashboardProvider.calculateTotalAmount();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(
                msg: AppStrings.cartMsg,
                textStyle: TextStyles.header,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextWidget(msg: AppStrings.address),
                    TextWidget(
                      msg: AppStrings.changeAddress,
                      textStyle: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              (dashboardProvider.cartItemsList ?? []).isNotEmpty
                  ? ListView.builder(
                      itemCount: dashboardProvider.cartItemsList?.length ?? 0,
                      shrinkWrap:
                          true, // Ensures ListView takes up only the needed space
                      physics:
                          NeverScrollableScrollPhysics(), // Disables scrolling for ListView
                      itemBuilder: (context, itemIndex) {
                        return CartItemRow(itemIndex: itemIndex);
                      },
                    )
                  : Card(
                      elevation: 6.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            // Empty cart icon or image
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 120,
                              color: Colors.grey.shade400,
                            ),
                            SizedBox(height: 24), // Spacing

                            // Title text
                            Text(
                              "Your Cart is Empty",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            SizedBox(height: 12), // Spacing

                            // Subtitle text
                            Text(
                              "Looks like you haven't added anything to your cart yet!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delivery",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Free delivery from \$30")
                        ],
                      ),
                      Text(
                        "\$${dashboardProvider.totalAmout}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              PaymentPlatformSelector(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PayButton(
                  title: "Pay",
                  subtitle: "24 min. \$${dashboardProvider.count}",
                  onPressed: () {
                    dashboardProvider.onPay(context);
                    // Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItemRow extends StatelessWidget {
  final int itemIndex;

  const CartItemRow({Key? key, required this.itemIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardViewModel>(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: Row(
        children: [
          // Image widget with flexible width and proportional scaling
          Expanded(
            flex: 2,
            child: Image.network(
              dashboardProvider.cartItemsList?[itemIndex].cartItem?.imageUrl ??
                  "",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(AppAssets.app_logo, fit: BoxFit.cover);
              },
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.03), // 2% of screen width
          // Details column with flexible width
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  msg: dashboardProvider
                          .cartItemsList?[itemIndex].cartItem?.name ??
                      "",
                  textStyle: TextStyles.header.copyWith(
                    fontSize: MediaQuery.of(context).size.width *
                        0.04, // 5% of screen width
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () =>
                            dashboardProvider.onDecrementOfCartItem(
                                dashboardProvider
                                    .cartItemsList?[itemIndex].cartItem,
                                itemIndex),
                        icon: const Icon(Icons.remove, size: 28),
                        color: AppColors.blackCode,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '${dashboardProvider.cartItemsList?[itemIndex].count}',
                          style: TextStyle(
                            color: AppColors.blackCode,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            dashboardProvider.onIncrementOfCartItem(
                                dashboardProvider
                                    .cartItemsList?[itemIndex].cartItem,
                                itemIndex),
                        icon: const Icon(Icons.add, size: 28),
                        color: AppColors.blackCode,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.03), // Spacer for better alignment
          // Price widget with flexible width

          Expanded(
            flex: 2,
            child: TextWidget(
              msg:
                  "\$${((dashboardProvider.cartItemsList?[itemIndex].count ?? 0) * (dashboardProvider.cartItemsList?[itemIndex].cartItem?.price ?? 0))}",
              textStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
