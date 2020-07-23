import 'dart:convert';

import 'package:donationsystem/models/campaign/campaign.dart';
import 'package:donationsystem/models/custom_user/custom_user.dart';
import 'package:donationsystem/models/user/user.dart';
import 'package:donationsystem/screens/new_campaign/new_campaign_screen.dart';
import 'package:donationsystem/repository/user_repository.dart';
import 'package:donationsystem/services/Auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();

}

class _ProfileScreenState extends State<ProfileScreen> {

  User user;
  UserCustom userProfile;
  List<Campaign> renderCampaign = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getCurrentUser();
    this.getUserCampaign();
    this._getCampaign();
  }

  Future<User> getCurrentUser() async {
    
    Auth auth = new Auth();
    UserRepository userRepository = new UserRepository();
    String email;
    await auth.getCurrentUser().then((value) => email = value.email);
    await userRepository.fetchUserByEmail(email).then((value) => user = value);
  }

  getUserCampaign() async {
    Auth auth = new Auth();
    UserRepository userRepository = new UserRepository();
    String email;
    await auth.getCurrentUser().then((value) => email = value.email);
    await userRepository.fetchUserProfile(email).then((value) => userProfile=value).whenComplete(() => setState(() {
      
    }));
    return userProfile;
  }


  @override
  Widget build(BuildContext context) {
    if(user==null && userProfile==null){
      return Text("");
    }
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
                            backgroundImage: NetworkImage(user.image),
                          ),
                        ),

                        // Text(widget.currentUser.firstName +
                        //     " " +
                        //     widget.currentUser.lastName),
                        Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              user.firstName + " " + user.lastName,
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
                                userProfile.totalCampaign.toString(),
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
                                userProfile.balance.toString(),
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
                                userProfile.like.toString(),
                                style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Like",
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
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewCampaignScreen()),
                            )
                          },
                          child: Text(
                            "Create new Campaign",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        RaisedButton(
                          color: Colors.black,
                          onPressed: () => requestPopup(),
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

  requestPopup() {
    showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text(
            "Request Money",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18, fontFamily: "ROBOTO"),
          ),
          content: Container(
            height: 220,
            width: 500,
            child: Column(
              children: [
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text("Money",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                    ),
                    TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,

                        //prefixIcon: Icon(Icons.account_box, color: Colors.black)
                      ),
                    ),
                  ],
                )),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 5, top: 8),
                          child: Text("Desciption",
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                        ),
                        TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          maxLines: 2,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            focusedBorder: InputBorder.none,

                            //prefixIcon: Icon(Icons.account_box, color: Colors.black)
                          ),
                        ),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () => {},
                      child: Text(
                        'Send Request',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }


  
   _getCampaign() async {
    String email = user.email;
    var empData = await http.get("https://swdapi.azurewebsites.net/api/campaign/CampaignOfUser/$email"); 
    var jsonData = json.decode(empData.body);
    for (var cam in jsonData) {
      Campaign campaign = Campaign.fromJson(cam);
      renderCampaign.add(campaign);
    }
    print(renderCampaign.toString() + " asdas");
  }
  renderListCampagin() async{ 
  print(renderCampaign.toString() + " tmp  test");
  List<Container> render = new List();
  renderCampaign.forEach((element) {
      render.add(Container(
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
    return render;
  }
}
