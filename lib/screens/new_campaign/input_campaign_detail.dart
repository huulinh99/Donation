import 'dart:io';

import 'package:donationsystem/models/campaign/campaign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class InputCampaignDetail extends StatefulWidget {
  final Function(Campaign) setCampaign;
  InputCampaignDetail(this.setCampaign);

  @override
  InputCampaignDetailState createState() => InputCampaignDetailState();
}

class InputCampaignDetailState extends State<InputCampaignDetail> {
  final pageViewController = PageController();
  String choiceStartTime = "";
  String choiceEndTime = "";
  DateTime limitEndTime;
  DateTime limitStartTime;
  List<String> listCategory = new List();
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  String choiceCategory;
  final descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    choiceStartTime = convertToString(DateTime.now());
    limitStartTime = DateTime.now();

    choiceEndTime = convertToString(DateTime.now());
    limitEndTime = DateTime.now();

    listCategory.add("Youtube");
    listCategory.add("Streaming");
    listCategory.add("Gamming");
  }

  //https://swdapi.azurewebsites.net/api/Category
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage(
              "assets/images/imageBanner.jpg",
            ),
            fit: BoxFit.cover),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(left: 15),
                margin: EdgeInsets.only(bottom: 45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "More about your Campaign",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          fontFamily: 'roboto'),
                    ),
                  ],
                )),
            Container(
                height: 80,
                width: 200,
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          fontFamily: 'roboto'),
                    ),
                    TextFormField(
                        controller: nameController,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(14),
                          focusedBorder: InputBorder.none,
                        )),
                  ],
                )),
            Container(
                height: 80,
                width: 200,
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Amount",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          fontFamily: 'roboto'),
                    ),
                    TextFormField(
                        controller: amountController,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(14),
                          focusedBorder: InputBorder.none,
                        )),
                  ],
                )),
            Container(
              padding: EdgeInsets.only(right: 150),
              child: FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        maxTime: limitStartTime, onConfirm: (date) {
                      handelLimitEndTime(date);
                      setState(() => {choiceStartTime = convertToString(date)});
                    }, currentTime: DateTime.now(), locale: LocaleType.vi);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 4,
                          child: Text(
                            'Start Time',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 14),
                          )),
                      Expanded(
                          flex: 4,
                          child: Text(
                            choiceStartTime.toString(),
                            style: TextStyle(color: Colors.black54),
                          )),
                    ],
                  )),
            ),
            Container(
              padding: EdgeInsets.only(right: 150),
              child: FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: limitEndTime, onConfirm: (date) {
                      handelLimitStartTime(date);
                      setState(() => {choiceEndTime = convertToString(date)});
                    }, currentTime: DateTime.now(), locale: LocaleType.vi);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: Text(
                            'End Time',
                            style: TextStyle(color: Colors.black54),
                          )),
                      Expanded(
                          flex: 2,
                          child: Text(
                            choiceEndTime.toString(),
                            style: TextStyle(color: Colors.black54),
                          )),
                    ],
                  )),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 15,
              ),
              padding: EdgeInsets.only(right: 150),
              child: FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: limitEndTime, onConfirm: (date) {
                      handelLimitStartTime(date);
                      setState(() => {choiceEndTime = convertToString(date)});
                    }, currentTime: DateTime.now(), locale: LocaleType.vi);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          flex: 4,
                          child: DropdownButton<String>(
                            hint: Text(
                                'Choose a category'), // Not necessary for Option 1
                            //value: _selectedLocation,
                            items: listCategory.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                choiceCategory = value;
                              });
                            },
                          )),
                    ],
                  )),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    width: 200,
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              fontFamily: 'roboto'),
                        ),
                        TextFormField(
                            controller: descriptionController,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            maxLines: 3,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(14),
                              focusedBorder: InputBorder.none,
                            )),
                      ],
                    )),
                Expanded(
                    child: Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.only(left: 15),
                        child: ButtonTheme(
                            buttonColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            child: RaisedButton(
                                color: Colors.black,
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(4),
                                    side: BorderSide(color: Colors.white)),
                                onPressed: () => sendDataBack(),
                                child: Text('Start Campaign',
                                    style: TextStyle(color: Colors.white))))))
              ],
            )
          ]),
    )));
  }

  handelLimitEndTime(DateTime date) {
    print(date.month);
    setState(() {
      limitEndTime = DateTime(date.year, date.month, date.day);
    });
  }

  handelLimitStartTime(DateTime date) {
    setState(() {
      limitStartTime = DateTime(date.year, date.month, date.day);
    });
  }

  convertToString(DateTime date) {
    return "${convertTwoDigitNumber(date.day)}-${convertTwoDigitNumber(date.month)}-${date.year}";
  }

  convertTwoDigitNumber(int str) {
    if (str < 10) {
      return "0" + str.toString();
    }
    return str;
  }

  convertToReverse(String date) {
    List tmp = date.split("-");
    return "${tmp[2]}-${tmp[1]}-${tmp[0]}";
  }

  sendDataBack() {
    Campaign tmp = new Campaign(
        amount: double.parse(amountController.text.trim()),
        campaignId: 0,
        campaignName: nameController.text.trim(),
        careless: 0,
        currentlyMoney: 0,
        description: descriptionController.text.trim(),
        endDate: convertToReverse(choiceEndTime),
        firstName: "",
        lastName: "",
        image: "",
        categoryId: 1,
        startDate: convertToReverse(choiceEndTime));
    widget.setCampaign(
      tmp,
    );
  }

  fetchCategory() {
    List<Text> tmp = new List();
    if (listCategory != null) {
    } else {}
    return tmp;
  }
}
