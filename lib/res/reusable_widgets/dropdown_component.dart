import 'package:flutter/material.dart';

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
            iconEnabledColor: Colors.black,
            style: const TextStyle(
              color: Colors.black,
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



/* import 'package:flutter/material.dart';

class DropdownTextFormField<T> extends StatelessWidget {
  final String label;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final T value;
  final FormFieldSetter<T>? onSaved;
  final FormFieldValidator<T>? validator;
  final bool isEnabled;

  const DropdownTextFormField({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    required this.value,
    required this.isEnabled,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 60.0, // Adjust this height as needed
          child: InputDecorator(
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white, // Change border color here
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white, // Change border color here
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white, // Change border color here
                ),
              ),
              /* filled: true,
              fillColor: Colors.grey[200], */ // Change fill color here
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                hint: Text(label),
                value: value,
                items: items,
                onChanged: isEnabled ? onChanged : null,
                isDense: true,
                isExpanded: true,
                dropdownColor:
                    Colors.white, // Change dropdown button color here
                icon: const Icon(Icons.arrow_drop_down,
                    color:
                        Colors.black), // Change dropdown button icon color here
                disabledHint: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    value.toString(),
                    style: const TextStyle(color: Colors.black,
                    ),
                  ),
                ),
                // menuMaxHeight: 250,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
 */