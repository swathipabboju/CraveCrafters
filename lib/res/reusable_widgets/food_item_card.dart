import 'package:flutter/material.dart';
import 'package:sample_app/res/constants/color_constants.dart';
import 'package:sample_app/res/constants/text_styles.dart';

class FoodItemCard extends StatelessWidget {
  final String imageUrl;
  final String price;

  const FoodItemCard({
    Key? key,
    required this.imageUrl,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.blue, // Top-left color
           AppColors.voilet // Bottom-right color
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food Item Image
          Expanded(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height*0.15,
                  width: MediaQuery.of(context).size.width*0.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Price Text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pizza manchridjshd', style: TextStyles.header),
              Text(
                '\$${price}',
                style: TextStyle(
                  color: AppColors.blackCode,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
