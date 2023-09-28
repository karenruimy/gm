import 'package:flutter/cupertino.dart';
import 'package:goddessmembership/components/text_view.dart';
import 'package:goddessmembership/constants/app_colors.dart';
import 'package:goddessmembership/module/search/models/seach_response.dart';

class SearchTile extends StatefulWidget {
  final SearchPostModel searchModel;

  const SearchTile({super.key, required this.searchModel});

  @override
  State<SearchTile> createState() => _SearchTileState();
}

class _SearchTileState extends State<SearchTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.offWhiteColor,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 90,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image:
                            AssetImage("assets/images/jpg/dummy_image.jpg"))),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    widget.searchModel.title,
                    fontWeight: FontWeight.w800,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14,
                    color: AppColors.blackColor,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextView(
                    'Brief description of the post goes here',
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.left,
                    fontSize: 13,
                    color: AppColors.blackColor,
                  )
                ],
              )),
            ],
          ),
          Container(
            height: .5,
            color: AppColors.primaryLight,
          )
        ],
      ),
    );
  }
}
