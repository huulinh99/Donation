import 'package:donationsystem/models/campaign/campaign.dart';
import 'package:donationsystem/models/user/user.dart';
import 'package:donationsystem/services/Auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final User currentUser;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();

  ProfileScreen({this.currentUser});
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Auth auth = new Auth();
    auth.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/prm391-study.appspot.com/o/avatars%2Fdefault.png?alt=media&token=eb223c2f-d198-4583-af3a-d5007f74e763"),
                          ),
                        ),

                        // Text(widget.currentUser.firstName +
                        //     " " +
                        //     widget.currentUser.lastName),
                        Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              "Nguyen Huynh Phu",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w600),
                            ))
                      ],
                    )),
                Container(
                  padding: EdgeInsets.only(top: 18),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 1, color: Colors.black))),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                "15",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Campaigns",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                "\$150000",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Balance",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                "\$15",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Spent",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "More Information",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: EdgeInsets.only(top: 15),
                  padding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 1,
                        spreadRadius: 2,
                        offset: Offset(1, 2))
                  ]),
                  child: FlatButton(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 9,
                            child: Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Username"),
                                  Container(
                                    margin: EdgeInsets.only(top: 0, bottom: 1),
                                    child: Text(
                                      "Nguyen Huynh Phu",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Roboto",
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Text(
                                    "Nguyen Huynh Phu",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Roboto",
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            )),
                        Expanded(
                          flex: 1,
                          child: Container(
                              // width: double.infinity,
                              // height: double.infinity,
                              child: Icon(Icons.arrow_forward)),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 15),
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your Campaign",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 1,
                        spreadRadius: 2,
                        offset: Offset(1, 1))
                  ]),
                  child: Column(
                    children: renderListCampagin(),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          color: Colors.black,
                          onPressed: () => print("object"),
                          child: Text(
                            "Create new Campaign",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        RaisedButton(
                          color: Colors.black,
                          onPressed: () => print("object"),
                          child: Text(
                            "Request Money",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          )),
    );
  }

  renderListCampagin() {
    List<Campaign> tmp = new List();
    tmp.add(new Campaign(
        campaignId: 1,
        campaignName: "asasd",
        careless: 155,
        description: 'asdaasdasd',
        endDate: 'asdasdasd',
        firstName: 'asdasdsd',
        lastName: "asdasd",
        startDate: 'asdasdad'));
    tmp.add(new Campaign(
        campaignId: 1,
        campaignName: "asasd",
        careless: 155,
        description: 'asdaasdasd',
        endDate: 'asdasdasd',
        firstName: 'asdasdsd',
        lastName: "asdasd",
        startDate: 'asdasdad'));

    tmp.add(new Campaign(
        campaignId: 1,
        campaignName: "asasd",
        careless: 155,
        description: 'asdaasdasd',
        endDate: 'asdasdasd',
        firstName: 'asdasdsd',
        lastName: "asdasd",
        startDate: 'asdasdad'));

    tmp.add(new Campaign(
        campaignId: 1,
        campaignName: "asasd",
        careless: 155,
        description: 'asdaasdasd',
        endDate: 'asdasdasd',
        firstName: 'asdasdsd',
        lastName: "asdasd",
        startDate: 'asdasdad'));

    tmp.add(new Campaign(
        campaignId: 1,
        campaignName: "asasd",
        careless: 155,
        description: 'asdaasdasd',
        endDate: 'asdasdasd',
        firstName: 'asdasdsd',
        lastName: "asdasd",
        startDate: 'asdasdad'));
    List<Container> tmp2 = new List();
    tmp.forEach((element) {
      tmp2.add(Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        child: Row(
          children: [
            Expanded(
                flex: 9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        element.campaignName,
                        style: TextStyle(
                            fontSize: 19,
                            fontFamily: "roboto",
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      child: Text(
                        element.startDate + "~" + element.endDate,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "roboto",
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Text(element.careless.toString()),
            )
          ],
        ),
      ));
    });
    return tmp2;
  }
}