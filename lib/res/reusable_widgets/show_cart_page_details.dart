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

class CartDetailWidget extends StatelessWidget {
  const CartDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
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
            Expanded(
              child: ListView.builder(
                itemCount: dashboardProvider.cartItemsList?.length ?? 0,
                itemBuilder: (context, index) {
                  return CartItemRow(index: index);
                },
              ),
            ),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.local_drink_outlined),
                      ),
                      TextWidget(
                        msg: "Cluttery",
                      ),
                      Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.remove, size: 30),
                              color: AppColors.black,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '${dashboardProvider.count}',
                                style: const TextStyle(
                                  color: AppColors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add, size: 30),
                              color: AppColors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                //decoration: BoxDecoration(border: Border.all()),
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
                        "\$0.00",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Price:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${dashboardProvider.individulaPrice}', // Implement calculateTotalPrice in DashboardViewModel
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            PaymentPlatformSelector(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PayButton(
                title: "Pay",
                subtitle: "24 min. \$${dashboardProvider.individulaPrice}",
                onPressed:
                    () {
                      Navigator.pop(context);
                    }, // This can represent the number of items in the cart
              ),
            ),
            /*  PayButton.show(
          context, 'Cart', '24 min. \$${dashboardProvider.individulaPrice}'); */
            /* ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Checkout'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                minimumSize: const Size(double.infinity, 50),
              ),
            ), */
          ],
        ),
      ),
    );
  }
}

class CartItemRow extends StatelessWidget {
  final int index;

  const CartItemRow({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardViewModel>(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              dashboardProvider.cartItemsList?[index].cartItem?.imageUrl ?? "",
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(AppAssets.AppIcon);
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextWidget(
                  msg: dashboardProvider.cartItemsList?[index].cartItem?.name ??
                      "",
                  textStyle: TextStyles.header,
                ),
                Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () =>
                            dashboardProvider.onDecrementOfCartItem(
                                dashboardProvider
                                    .cartItemsList?[index].cartItem,
                                index),
                        icon: const Icon(Icons.remove, size: 30),
                        color: AppColors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '${dashboardProvider.cartItemsList?[index].count}',
                          style: const TextStyle(
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            dashboardProvider.onIncrementOfCartItem(
                          dashboardProvider.cartItemsList?[index].cartItem,
                        ),
                        icon: const Icon(Icons.add, size: 30),
                        color: AppColors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: TextWidget(
              msg: "\$${dashboardProvider.individulaPrice}",
            ),
          ),
        ],
      ),
    );
  }
}
