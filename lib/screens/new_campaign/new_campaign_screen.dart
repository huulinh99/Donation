import 'package:donationsystem/screens/new_campaign/input_image.dart';
import 'package:flutter/cupertino.dart';

class NewCampaignScreen extends StatefulWidget {
  @override
  NewCampaignScreenState createState() => NewCampaignScreenState();
}

class NewCampaignScreenState extends State<NewCampaignScreen> {
  final pageViewController = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageViewController,
      scrollDirection: Axis.horizontal,
      children: [InputImage()],
    );
  }
}
