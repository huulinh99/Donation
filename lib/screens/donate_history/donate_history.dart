import 'dart:convert';

import 'package:donationsystem/models/campaign/campaign.dart';
import 'package:donationsystem/models/custom_user/custom_user.dart';
import 'package:donationsystem/models/donate_detail/donate_detail_custom.dart';
import 'package:donationsystem/repository/donate_detail_repository.dart';
import 'package:intl/intl.dart';
import 'package:donationsystem/models/request_money/request_money.dart';
import 'package:donationsystem/models/user/user.dart';
import 'package:donationsystem/repository/request_money_repository.dart';
import 'package:donationsystem/screens/new_campaign/new_campaign_screen.dart';
import 'package:donationsystem/repository/user_repository.dart';
import 'package:donationsystem/services/Auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DonateHistoryScreen extends StatefulWidget {
  final String campaignId;
  DonateHistoryScreen(this.campaignId);
  @override
  _DonateHistoryScreenState createState() => _DonateHistoryScreenState();
}

class _DonateHistoryScreenState extends State<DonateHistoryScreen> {
  User user;
  UserCustom userProfile;
  RequestMoneyRepository requestMoneyRepository = new RequestMoneyRepository();
  
  List<DonateDetailCustom> listDonateDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.campaignId);
    DonateDetailRepository donateDetailRepository = new DonateDetailRepository();
    donateDetailRepository.getDonateDetail(widget.campaignId).then((value) => setState(() {
      listDonateDetail = value;
    }));
  }


  @override
  Future<User> fetchUser(String userId) async {
    User user;
    try {
      final response = await http.get(
          'https://swdapi.azurewebsites.net/api/user/UserById/$userId');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        user = User.fromJson(data[0]);
        return user;
      }
    } catch (e) {
      print(e);
    } finally {
      return user;
    }
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
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 1,
                            spreadRadius: 2,
                            offset: Offset(1, 1))
                      ]),
                      child: Column(
                        children: renderListCampagin(),
                      )),
                ],
              ),
            )),
      );
  }


  renderListCampagin() {
    List<Container> render = new List();
    if(listDonateDetail == null){
  print(" nul vccc");      
        return render;
    }else{
      print(" co chayyy vccc");
      listDonateDetail.forEach((element) {             
          render.add(
          Container(
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
                        child:Text(
                          element.firstName + " " + element.lastName,
                          style: TextStyle(
                              fontSize: 19,
                              fontFamily: "roboto",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        child: Text(
                          element.date,
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
                child: Text(element.amount.toString()),
              )
            ],
          ),
        ));           
      });
    }       
    return render;
  }
}
