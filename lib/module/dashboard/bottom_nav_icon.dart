import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../constants/app_colors.dart';

class BottomNavIcon extends StatelessWidget {
  final VoidCallback callback;
  final String outlinedPath;
  final String filledPath;
  final bool isSelected;

  const BottomNavIcon({
    Key? key,
    required this.callback,
    required this.outlinedPath,
    required this.filledPath,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          outlinedPath.contains('png')
              ? Image.asset(
                  outlinedPath,
                  height: outlinedPath.contains('notifications') ? 55 : 41,
                  width: outlinedPath.contains('notifications') ? 55 : 41,
                  color: isSelected ? AppColors.whiteColor : AppColors.whiteColor.withOpacity(.7),
                )
              : SvgPicture.asset(
                  isSelected ? filledPath : outlinedPath,
                  color: isSelected ? AppColors.primaryDark : AppColors.grey2,
                  height: 17,
                ),
        ],
      ),
    );
  }
}
