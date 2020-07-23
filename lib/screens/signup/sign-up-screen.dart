import 'package:donationsystem/screens/login/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen();

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // viewModel = new LoginViewModel();
    // emailController.addListener(() => viewModel.emailSink.add(emailController.text));
    // passwordController.addListener(() => viewModel.passwordSink.add(passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(left: 50, right: 50, top: 150),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/banner0.jpg",
              ),
              fit: BoxFit.fill)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Text("Sign Up",
                style: TextStyle(fontSize: 25, color: Colors.white)),
          ),
          Container(
              margin: new EdgeInsets.only(bottom: 10),
              height: 38,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Email",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: TextFormField(
                      controller: emailController,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(14),
                        focusedBorder: InputBorder.none,
                        prefixText: "Username",

                        //prefixIcon: Icon(Icons.account_box, color: Colors.black)
                      ),
                    ),
                  )
                ],
              )),
          Container(
              height: 38,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: TextFormField(
                controller: passwordController,
                textAlignVertical: TextAlignVertical.center,
                obscureText: true,
                style: TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(14),
                    focusedBorder: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black,
                      size: 20,
                    )),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonTheme(
                  buttonColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  minWidth: 220.0,
                  hoverColor: Colors.transparent,
                  child: RaisedButton(
                      color: Colors.black,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4),
                          side: BorderSide(color: Colors.white)),
                      onPressed: () => {},
                      child: Text('Sign Up',
                          style: TextStyle(color: Colors.white))))
            ],
          ),
        ],
      ),
    ));
  }
}
