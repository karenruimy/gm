import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:goddessmembership/components/base_scaffold.dart';
import 'package:goddessmembership/components/custom_appbar.dart';
import 'package:goddessmembership/components/text_view.dart';
import 'package:goddessmembership/constants/app_colors.dart';
import 'package:html/parser.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

import '../models/posts_response.dart';


class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({Key? key,required this.pageTitle,required this.postModel,}) : super(key: key);
  final PostModel postModel;
  final String pageTitle;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}



class _PostDetailScreenState extends State<PostDetailScreen> {
  String removeHtmlTags(String htmlString) {
    final document = parse(htmlString);
    final text = parse(document.body!.text).documentElement!.text;
    return text;
  }

  @override
  void initState() {
    super.initState();
  }

  String extractVideoLink(String htmlContent) {
    final document = htmlParser.parse(htmlContent);
    final iframeElement = document.querySelector('iframe');

    if (iframeElement != null) {
      final srcAttribute = iframeElement.attributes['src'];
      return srcAttribute ?? 'Video link not found';
    } else {
      return 'Video link not found';
    }
  }


  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        hMargin: 0,
        appBar: CustomAppbar(
          widget.pageTitle,
          centerTitle: true,
        ),
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 1,
                color: AppColors.primaryLight1,
              ),
              Stack(
                children: [
                  Container(
                    //height: 150,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 0.35, .9],
                      colors: [
                        AppColors.primaryDark2,
                        Color(0xFF9B6380),
                        Color(0xfff6f4f1),
                      ],
                    )),
                    padding: EdgeInsets.all(40),
                    child: TextView(
                      widget.postModel.title.rendered,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.whiteColor,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 250,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(widget.postModel
                                        .yoastHeadJson.ogImage.first.url))),
                          ),
                          Html(
                            data: widget.postModel.content.rendered,
                            style: {
                              'p': Style(
                                  color: Colors.black,
                                  textAlign: TextAlign.start,
                                  fontSize: FontSize(13)),
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: VimeoPlayer(
                            videoId: "257555229",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              
              /*Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextView(
                  'Comments',
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Row(
                  children: const [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Leave your comments',
                        fillColor: AppColors.whiteColor,
                        height: 40,
                        fontSize: 13,
                        textColor: AppColors.blackColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextView(
                        'Post',
                        color: AppColors.primaryDark,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: List.generate(6, (index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius:
                          BorderRadius.all(Radius.circular(8))),
                      child: RichText(
                        text: const TextSpan(
                          text: 'Diana' + " ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Great post than you so much',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),*/
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
