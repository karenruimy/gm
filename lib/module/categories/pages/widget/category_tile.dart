import 'package:flutter/cupertino.dart';
import 'package:goddessmembership/components/text_view.dart';

class CategoryTile extends StatefulWidget {
  final String goddessItemName;

  const CategoryTile({super.key, required this.goddessItemName});

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  String backgroundImagePath = "assets/images/jpg/latest_posts.jpg";

  @override
  void initState() {
    if (widget.goddessItemName.toString() == "All") {
      backgroundImagePath = "assets/images/jpg/latest_posts.jpg";
    } else if (widget.goddessItemName.toString() == "Ask Karen") {
      backgroundImagePath = "assets/images/jpg/ask_karen.jpg";
    } else if (widget.goddessItemName.toString() == "Exclusive Meditations") {
      backgroundImagePath = "assets/images/jpg/exclusive_meditation.jpg";
    } else if (widget.goddessItemName.toString() ==
        "Goddess Inspirational Guidance") {
      backgroundImagePath = "assets/images/jpg/goddess_inspiration.jpg";
    } else if (widget.goddessItemName.toString() == "Goddess Messages") {
      backgroundImagePath = "assets/images/jpg/goddess_messages.jpg";
    } else if (widget.goddessItemName.toString() ==
        "Meditations &amp; Activations") {
      backgroundImagePath = "assets/images/jpg/meditations_and_activations.jpg";
    } else if (widget.goddessItemName.toString() == "News") {
      backgroundImagePath = "assets/images/jpg/announcements.jpg";
    } else if (widget.goddessItemName.toString() == "Webinars") {
      backgroundImagePath = "assets/images/jpg/webinars_icon.jpg";
    } else if (widget.goddessItemName.toString() == "Weekly Oracle Readings") {
      backgroundImagePath = "assets/images/jpg/oracle_reading.jpg";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      height: 90,
      alignment: Alignment.centerLeft,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage(backgroundImagePath)),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: TextView(
        widget.goddessItemName.replaceAll('&amp;', '\u0026').replaceAll(
            "Goddess Inspirational Guidance", "Goddess Inspirational").replaceAll("All", "Latest Posts")
            .replaceAll("Weekly Oracle Readings", "Oracle Readings"),
        fontSize: 20,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
