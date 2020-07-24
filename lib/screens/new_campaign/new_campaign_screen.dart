import 'dart:io';

import 'package:donationsystem/models/campaign/campaign.dart';
import 'package:donationsystem/screens/new_campaign/input_campaign_detail.dart';
import 'package:donationsystem/screens/new_campaign/input_image.dart';
import 'package:donationsystem/screens/new_campaign/welcome_page.dart';
import 'package:flutter/cupertino.dart';

class NewCampaignScreen extends StatefulWidget {
  @override
  NewCampaignScreenState createState() => NewCampaignScreenState();
}

class NewCampaignScreenState extends State<NewCampaignScreen> {
  final pageViewController = PageController(initialPage: 0);
  File displayImageFile;
  Campaign campaign;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageViewController,
      scrollDirection: Axis.horizontal,
      children: handlePage(),
    );
  }

  handlePage() {
    List<Widget> tmp = [];
    if (displayImageFile != null) {
      tmp = [
        WelcomePage(),
        InputImage(setDisplayImageFile),
        InputCampaignDetail(setCampaign)
      ];
    } else if (displayImageFile != null && campaign != null) {
      tmp = [
        WelcomePage(),
        InputImage(setDisplayImageFile),
        InputCampaignDetail(setCampaign),
        WelcomePage(),
      ];
    } else {
      tmp = [WelcomePage(), InputImage(setDisplayImageFile)];
    }
    return tmp;
  }

  setCampaign(Campaign tmp) {
    print("Run");
    setState(() {
      campaign = tmp;
    });
    pageViewController.jumpToPage(4);
  }

  setDisplayImageFile(File image) {
    setState(() {
      displayImageFile = image;
    });
    pageViewController.jumpToPage(3);
  }
}
