import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goddessmembership/components/text_view.dart';

import '../constants/app_colors.dart';

class CustomDropDown extends StatefulWidget {
  final String hint;
  final List<String> items;
  final bool disable;
  final Color borderColor;
  final Color hintColor;
  final Color iconColor;
  final bool isOutline;
  final String? suffixIconPath;
  final double allPadding;
  final double verticalPadding;
  final double horizontalPadding;
  final Function(String value)? onSelect;

  const CustomDropDown(
      {Key? key,
      required this.hint,
      required this.items,
      this.iconColor = AppColors.grey4,
      this.hintColor = AppColors.grey3,
      this.suffixIconPath,
      this.disable = false,
      this.borderColor = AppColors.whiteColor,
      this.onSelect,
      this.isOutline = true,
      this.allPadding = 10,
      this.horizontalPadding = 16,
      this.verticalPadding = 0})
      : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: _boxDecoration(widget.isOutline),
      child: IgnorePointer(
        ignoring: widget.disable,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: DropdownButtonFormField(
            icon: SvgPicture.asset(
              'assets/images/svg/ic_drop_down.svg',
              color: AppColors.primaryDark,
            ),
            style: const TextStyle(
                fontSize: 16,
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w500),
            hint: TextView(widget.hint,
                fontSize: 16,
                color: widget.hintColor,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintStyle: const TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w500),
              enabled: false,
              filled: true,
              fillColor: AppColors.lightGreyColor,
              contentPadding: EdgeInsets.all(widget.allPadding) +
                  EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
              suffixIconConstraints:
                  const BoxConstraints(maxHeight: 33, maxWidth: 33),
              border: _outlineInputBorder,
              enabledBorder: _outlineInputBorder,
              disabledBorder: _outlineInputBorder,
            ),
            dropdownColor: const Color(0xffF4F4F4),
            value: dropdownValue,
            onChanged: (String? newValue) {
              if (widget.onSelect != null) {
                widget.onSelect!(newValue!);
              }
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: widget.items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: TextView(
                  value,
                  fontSize: 16,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12.0),
  borderSide: const BorderSide(color: AppColors.lightGreyColor),
);

BoxDecoration _boxDecoration(bool isOutline) {
  if (isOutline) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryDark,
          width: 1, //                   <--- border width here
        ));
  } else {
    return const BoxDecoration(
        color: AppColors.lightGreyColor,
        borderRadius: BorderRadius.all(Radius.circular(12)));
  }
}
