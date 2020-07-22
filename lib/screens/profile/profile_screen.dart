
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
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/prm391-study.appspot.com/o/avatars%2Fdefault.png?alt=media&token=eb223c2f-d198-4583-af3a-d5007f74e763"),),
                  //Text(widget.currentUser.firstName + " " + widget.currentUser.lastName)
                ],
              )
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(width: 0.5, color: Colors.black12))
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        children: [
                          Text("15"),
                          Text("Campaigns")
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        children: [
                          Text("\$150000"),
                          Text("Balance")
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        children: [
                          Text("\$15"),
                          Text("Spent")
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Text("More Information"),
            ),
            Container(
              child: FlatButton(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Image.network("https://firebasestorage.googleapis.com/v0/b/prm391-study.appspot.com/o/avatars%2Fdefault.png?alt=media&token=eb223c2f-d198-4583-af3a-d5007f74e763", fit: BoxFit.fill,),
                      )
                    ),
                    Expanded(
                      flex: 8,
                      child: Column(
                        children: [],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
