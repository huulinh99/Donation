import 'package:donationsystem/models/gift/Gift.dart';
import 'package:donationsystem/repository/gift_repository.dart';
import 'package:donationsystem/screens/effects/loading_cricle/LoadingCircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GiftDetailScreen extends StatefulWidget{
  final Gift gift;
  final Future<String> Function(int) donateGift;
  GiftDetailScreen(this.gift, this.donateGift);

  @override
  GiftDetailScreenState createState() => GiftDetailScreenState();
}

class GiftDetailScreenState extends State<GiftDetailScreen>{
  GiftRepository giftRepository;
  bool isDonated;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    giftRepository = new GiftRepository();
    isDonated = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Image.asset("assets/images/banner1.jpg", fit: BoxFit.cover,),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, top: 15, bottom: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  "${widget.gift.giftName}",
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w600,
                      fontSize: 30
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  "\$${widget.gift.amount.toString()}",
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.blue,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Divider(
                    color: Colors.black,
                    thickness: .8,
                  )
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                margin: EdgeInsets.only(bottom: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "${widget.gift.description}",
                  style: TextStyle(
                      height: 1.5,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w300,
                      fontSize: 18
                  ),
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 100, right: 100),
                    child: FlatButton(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      onPressed: () {
                        setState(() {
                          isDonated = true;
                        });
                        Future.delayed(const Duration(milliseconds: 2000), () {
                          setState(() {
                            isDonated = false;
                          });
                        }).whenComplete(() {
                          String campaignId = "";
                          giftRepository.getCampaign(widget.gift.id).then((value) => campaignId=value);
                          //giftRepository.donate(int.parse(campaignId, money, userDonate);
                          Navigator.pop(context);
                          widget.donateGift(widget.gift.id);
                        });
                      },
                      color: Colors.black,
                      child:
                        isDonated != true ?
                        Text("Donate", style: TextStyle(color: Colors.white),) :
                        LoadingCircle(15, Colors.white)
                      ,
                    )
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}