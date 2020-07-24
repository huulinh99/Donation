

import 'package:donationsystem/models/user/user.dart';
import 'package:donationsystem/repository/user_repository.dart';
import 'package:donationsystem/models/category/category.dart';
import 'package:donationsystem/models/custom_user/custom_user.dart';
import 'package:donationsystem/screens/campaign/campaign_screen_by_category.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:donationsystem/services/Auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

typedef void onSignOut();

class SideMenu extends StatefulWidget {
  final void Function() onSignOut;
  final void Function(String) handelFragmentOption;
  final User currentUser;

  SideMenu(this.onSignOut, this.currentUser, this.handelFragmentOption);

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu> {
  bool clickCategory = false;
  User user;
  UserCustom userProfile;
  SideMenuState();
  bool refresh = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchCategory();
    this.getCurrentUser();
  }
  List<String> tmpList = null;
  @override
  Future<List<String>> fetchCategory() async {
    try{
      final response = await http.get(
          'https://swdapi.azurewebsites.net/api/Category');
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        tmpList = new List();
        data.forEach((element) {
          tmpList.add(CategoryModel.fromJson(element).name);
        });
        return tmpList;
      }
    }catch(e){
      print(e);
    }finally{
      return tmpList;
    }
  }

  getCurrentUser() async {
    Auth auth = new Auth();
    UserRepository userRepository = new UserRepository();
    String email;
    await auth.getCurrentUser().then((value) => email = value.email);
    userRepository.fetchUserByEmail(email).then((value) => user = value).whenComplete(() => setState(() {
      print(user.toString() + ' sfsdf');
      }));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(     
      child: Container(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Align(
            alignment:Alignment.topLeft,
              child: CircleAvatar(
                radius: 70,
                backgroundColor:Color(0xff476cfb),
                  child: ClipOval(
                    child: SizedBox(
                      width: 180.0,
                      height: 180.0,
                        child: user==null
                        ? Text('')
                        :Image.network(user.image,
                                fit: BoxFit.fill),
                    ),
                  ),
              ),
          ),
           Align(
            alignment:Alignment.centerRight,
              child: user==null
                    ? Text('')
                    :Text(
                'Welcome, ${user.lastName}',
                style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w400))
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              this.widget.handelFragmentOption("home");
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Category'),
            onTap: () => categoryTap(),
          ),
          Column(
            children: renderSubMenu(),
          ),
          ListTile(
            leading: Icon(Icons.play_circle_filled),
            title: Text('Campaigns'),
            onTap: () {
              this.widget.handelFragmentOption("campaign_newest");
              Navigator.of(context).pop();
            },
            //campaignTap(context)
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle),
            title: Text('Profile'),
            onTap: () {
              this.widget.handelFragmentOption("profile");
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: this.widget.onSignOut,
          ),
        ],
      ),
    ));
  }

  renderSubMenu() {
    final List<Widget> tmp = new List();
    if (clickCategory) {    
      tmpList.forEach((item) {
        tmp.add(Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 5),
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.black, width: 0.4))),
          child: 
          GestureDetector(
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => CampaignByCategoryScreen(item)),)},
            child:  ListTile(
            title: Text(item),
          ),),
        ));
      });
    }

    return tmp;
  }

  categoryTap() {
    setState(() {
      clickCategory = !clickCategory;
    });
  }

}
