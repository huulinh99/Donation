import 'package:donationsystem/models/user/user.dart';
import 'package:donationsystem/screens/main/main_screen_view_model.dart';
import 'package:donationsystem/screens/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
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
  SideMenuState();
  bool refresh = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/banner1.jpg'))),
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
      final List<String> item = [
        'Caster',
        'Gaming',
        'Youtuber',
        'Reviewer',
        'Singer'
      ];
      item.forEach((item) {
        tmp.add(Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 5),
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.black, width: 0.4))),
          child: ListTile(
            title: Text(item),
          ),
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