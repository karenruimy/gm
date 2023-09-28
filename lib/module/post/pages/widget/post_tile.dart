import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:goddessmembership/components/text_view.dart';
import 'package:goddessmembership/constants/app_colors.dart';
import 'package:goddessmembership/module/membership/repo/membership_repo.dart';
import 'package:html/parser.dart';

import '../../../../config/routes/nav_router.dart';
import '../../../../core/di/service_locator.dart';
import '../../models/posts_response.dart';
import '../post_detail_screen.dart';

class PostTile extends StatefulWidget {
  final PostModel postModel;

  const PostTile({super.key, required this.postModel});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  String removeHtmlTags(String htmlString) {
    final document = parse(htmlString);
    final text = parse(document.body!.text).documentElement!.text;
    return text;
  }

  final MembershipRepository _membershipRepository = sl<MembershipRepository>();

  bool isMembershipAvailable() {
    if (_membershipRepository.getCategoriesIds().isEmpty) {
      return false;
    } else {
      List<int>? matchingItems = _membershipRepository
          .getCategoriesIds()
          .where((item) => widget.postModel.categories.contains(item))
          .toList();
      if (matchingItems.isEmpty) {
        return false;
      } else {
        return true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8), topLeft: Radius.circular(8)),
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                  sigmaX: isMembershipAvailable() ? 0.1 : 4,
                  sigmaY: isMembershipAvailable() ? 0.1 : 4),
              child: Image.network(
                widget.postModel.yoastHeadJson.ogImage.first.url,
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
                child: TextView(
                  widget.postModel.title.rendered,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: AppColors.blackColor,
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Html(
                  data: widget.postModel.excerpt.rendered,
                  style: {
                    'p': Style(color: Colors.black, fontSize: FontSize(13)),
                  },
                ),
              )
            ],
          ),
          isMembershipAvailable()
              ? Padding(
                  padding: EdgeInsets.all(14),
                  child: GestureDetector(
                    onTap: () {
                      NavRouter.push(
                          context,
                          PostDetailScreen(
                            postModel: widget.postModel,
                            pageTitle: widget.postModel.title.rendered,
                          ));
                    },
                    child: TextView(
                      "Read More",
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w800,
                      textAlign: TextAlign.end,
                      fontSize: 14,
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(14),
                  child: TextButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      // splashFactory:
                      //     isEnabled ? InkRipple.splashFactory : NoSplash.splashFactory,
                      backgroundColor: AppColors.primaryDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: TextView(
                      'Join Now',
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
