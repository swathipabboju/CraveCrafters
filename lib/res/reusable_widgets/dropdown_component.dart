import 'package:flutter/material.dart';
import 'package:sample_app/res/constants/color_constants.dart';

class DropdownReusable<T> extends StatefulWidget {
  final String? label;
  final List<DropdownMenuItem<T>> items;
  final void Function(T? value)? onChanged;
  final T? selectedValue;
  final double? width;
  final double? height;

  const DropdownReusable(
      {super.key,
      this.label,
      required this.items,
      required this.onChanged,
      required this.selectedValue,
      this.width,
      this.height});

  @override
  State<DropdownReusable<T>> createState() => _DropdownReusableState<T>();
}

class _DropdownReusableState<T> extends State<DropdownReusable<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Add border color
        borderRadius: BorderRadius.circular(5), // Rounded corners
        color: Colors.white, // Background color of the containerr
      ),
      width: widget.width ?? MediaQuery.of(context).size.width * 0.9,
      height: widget.height ?? 50,
      child: InputDecorator(
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            hint: Text("${widget.label}"),
            dropdownColor: Colors.white,
            value: widget.selectedValue,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            iconEnabledColor: AppColors.blackCode,
            style: const TextStyle(
              color: AppColors.blackCode
            ),
            onChanged: widget.onChanged,
            items: widget.items,
            // to handle text overflow
            isExpanded: true,
          ),
        ),
      ),
    );
  }
}



