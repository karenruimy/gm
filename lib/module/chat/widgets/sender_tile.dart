import 'package:flutter/material.dart';

import '../../../components/text_view.dart';
import '../../../constants/app_colors.dart';

class SenderTile extends StatelessWidget {
  final String message;
  final String time;
  final String msgType;
  final bool status;

  const SenderTile({
    Key? key,
    required this.message,
    required this.time,
    required this.msgType,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 90, right: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryDark1,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          msgType == 'text'
              ? Padding(
                  padding: const EdgeInsets.only(left: 12, top: 10, right: 8),
                  child: TextView(
                    message,
                    fontSize: 16,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                    overflow: TextOverflow.visible,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(4),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: message != ''
                        ? Image.network(message)
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(right: 6, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextView(
                  time,
                  fontSize: 12,
                  textAlign: TextAlign.end,
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteColor,
                ),
                SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.done_all,
                  color: status ? AppColors.blue : AppColors.whiteColor,
                  size: 18,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
