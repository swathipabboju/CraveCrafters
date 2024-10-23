import 'package:flutter/material.dart';
import 'package:sample_app/res/constants/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onMenuTap;
  final VoidCallback onHomeTap;

  CustomAppBar({
    required this.title,
    required this.onMenuTap,
    required this.onHomeTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyles.header,
      ),
      //backgroundColor: AppColors.appbarColour,
      leading: IconButton(
        iconSize: 36,
        icon: Icon(Icons.menu), // Side menu icon
        onPressed: onMenuTap,
      ),

      actions: [
        IconButton(
          icon: Icon(Icons.home), // Home icon
          onPressed: onHomeTap,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
