import 'package:flutter/material.dart';
import 'package:sample_app/res/reusable_widgets/dropdown_component.dart';

Widget buildDropdownWidget<T>(
  BuildContext context,
  List<T> items,
  T? selectedValue,
  String Function(T)? displayText, {
  ValueChanged<T?>? onChanged,
  String? label,
  double? width,
}) {
  return DropdownReusable<T>(
    width: width ?? MediaQuery.of(context).size.width * 0.95,
    height: MediaQuery.of(context).size.height * 0.08,
    items: items
        .map<DropdownMenuItem<T>>(
          (T item) => DropdownMenuItem<T>(
            value: item,
            child: Text(
              displayText?.call(item) ?? item.toString(),
              overflow: TextOverflow.visible,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        )
        .toList(),
    onChanged: onChanged,
    selectedValue: selectedValue,
    label: label,
  );
}
