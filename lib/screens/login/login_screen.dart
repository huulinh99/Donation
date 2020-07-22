
import 'package:donationsystem/screens/login/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final Future<String> Function(String, String) signIn;
  final Future<String> Function() signInWithGoogle;

  LoginScreen(this.signIn, this.signInWithGoogle);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  LoginViewModel viewModel;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = new LoginViewModel();
    emailController.addListener(() => viewModel.emailSink.add(emailController.text));
    passwordController.addListener(() => viewModel.passwordSink.add(passwordController.text));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 50, right: 50, top: 150),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/banner0.jpg",),
            fit: BoxFit.fill
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Text("Login", style: TextStyle(fontSize: 25, color: Colors.white)),
            ),
            Container(
                margin: new EdgeInsets.only(bottom: 10),
                height: 38,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: emailController,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                      focusedBorder: InputBorder.none,
                      prefixIcon: Icon(Icons.account_box, color: Colors.black)),
                )
            ),
            Container(
                height: 38,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: passwordController,
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: true,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                      focusedBorder: InputBorder.none,
                      prefixIcon: Icon(Icons.lock, color: Colors.black, size: 20,)),
                )
            ),
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
                            side: BorderSide(color: Colors.white)
                        ),
                        onPressed: () => {widget.signIn(emailController.text, passwordController.text)},
                        child: Text('Login', style: TextStyle(color: Colors.white))
                    )
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text("Or Sign In With", style: TextStyle(color: Colors.white, fontSize: 15),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: () => {widget.signInWithGoogle()},
                  child: Text(
                    'Google', style: TextStyle(color: Colors.white),),
                ),
              ],

            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text("Don't have an account ?", style: TextStyle(color: Colors.white, fontSize: 14),),
            ),
            Container(
                margin: EdgeInsets.all(10),
                child:
                GestureDetector(
                  onTap: () {print("Do something here");},
                  child: Text('Sign Up', style: TextStyle(color: Colors.blue),),
                )
            ),
          ],
        ),
      )
    );
  }
}
