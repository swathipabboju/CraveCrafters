import 'package:flutter/material.dart';
import 'package:sample_app/model/food_items_details.dart';
import 'package:sample_app/res/constants/color_constants.dart';

class NutritionsInfoCard extends StatelessWidget {
  final List<NutritionalInfo>? nutritionalInfoList;

  const NutritionsInfoCard({super.key, this.nutritionalInfoList});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Adds shadow effect to the card
      margin: const EdgeInsets.all(16), // Outer margin of the card
      child: Padding(
        padding: const EdgeInsets.all(16), // Inner padding of the card
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Even spacing
          children: nutritionalInfoList!.map((item) {
            return Column(
              mainAxisSize: MainAxisSize.min, // Minimum size for column
              children: [
                Text(
                  item.value.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8), // Space between text elements
                Text(
                   item.nutritionName.toString(),
                  style: TextStyle(
                    fontSize: 16,
                       color: AppColors.black
                    
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
