import 'package:donationsystem/models/campaign/campaign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OwnerCampaignScreen extends StatefulWidget {
  final List<Campaign> listCampaign;
  OwnerCampaignScreen(this.listCampaign);
  @override
  OwnerCampaignScreenState createState() => OwnerCampaignScreenState();
}

class OwnerCampaignScreenState extends State<OwnerCampaignScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 80, bottom: 20, left: 20, right: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Your campaign",
                  style: TextStyle(fontSize: 24, fontFamily: "Roboto"),
                ),
              ),
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: renderCampaign(),
              ))
            ]),
      ),
    ));
  }

  renderCampaign() {
    List<Container> tmp = new List();
    widget.listCampaign.forEach((element) {
      tmp.add(Container(
        width: MediaQuery.of(context).size.width,
        height: 490,
        //padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(1, 2), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.only(bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: Image.network(
                element.image,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Text(
                element.campaignName,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              margin: EdgeInsets.only(top: 5, bottom: 2),
              child: Text(
                  convertDate(element.startDate) +
                      " ~ " +
                      convertDate(element.endDate),
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w400,
                      color: Colors.red)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: [
                  Container(
                    child: Text(
                        element.currentlyMoney.toString() +
                            "\$/" +
                            element.amount.toString() +
                            "\$",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400)),
                  ),
                  // Container(
                  //   child: Text(
                  //     element.careless.toString(),
                  //     style: TextStyle(),
                  //     overflow: TextOverflow.ellipsis,
                  //     maxLines: 3,
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              height: 90,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                element.description,
                style: TextStyle(),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 0.5,
              height: 1,
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    child: DropdownButton<String>(
                      hint: Text(
                          'Choose a category'), // Not necessary for Option 1
                      items: ["Active", "Not Active"].map((value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {},
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ));
    });
    return tmp;
  }

  convertDate(String date) {
    return date.split("T")[0];
  }
}
