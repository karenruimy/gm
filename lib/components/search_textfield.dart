import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_colors.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key, this.readOnly = true,required this.hint,this.onValueChange}) : super(key: key);
  final bool readOnly;
  final String hint;
  final Function(String value)? onValueChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: readOnly
          ? () {

            }
          : null,
      onChanged: (String? newValue) {
        if(onValueChange!=null){
          onValueChange!(newValue!);
        }
      },
      cursorColor: AppColors.primaryDark,
      readOnly: readOnly,
      decoration: InputDecoration(
        filled: true,
        enabled: true,
        isDense: true,
        hintText: hint,
        hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: AppColors.greyColor),
        suffixIconConstraints: const BoxConstraints(),
        prefixIconConstraints: const BoxConstraints(),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12,right: 12.0),
          child: SvgPicture.asset("assets/images/svg/ic_search.svg",),
        ),
        contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 24),
        fillColor: AppColors.lightGreyColor,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none),
      ),
    );
  }
}
