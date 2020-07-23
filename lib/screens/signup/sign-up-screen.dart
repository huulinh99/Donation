import 'package:donationsystem/models/user/user.dart';
import 'package:donationsystem/repository/user_repository.dart';
import 'package:donationsystem/screens/login/login_view_model.dart';
import 'package:donationsystem/services/Auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen();

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final Auth auth = new Auth();
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
      child: SingleChildScrollView(
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
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text("Your Name",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        controller: userNameController,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          focusedBorder: InputBorder.none,
                          //prefixIcon: Icon(Icons.account_box, color: Colors.black)
                        ),
                      ),
                    )
                  ],
                )),
            Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5, top: 8),
                      child: Text("Email",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        controller: emailController,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          focusedBorder: InputBorder.none,
                          //prefixIcon: Icon(Icons.account_box, color: Colors.black)
                        ),
                      ),
                    )
                  ],
                )),
            Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5, top: 8),
                      child: Text("Password",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        controller: passwordController,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          focusedBorder: InputBorder.none,

                          //prefixIcon: Icon(Icons.account_box, color: Colors.black)
                        ),
                      ),
                    )
                  ],
                )),
            Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5, top: 8),
                      child: Text("Confirm Password",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        controller: confirmPasswordController,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          focusedBorder: InputBorder.none,
                          //prefixIcon: Icon(Icons.account_box, color: Colors.black)
                        ),
                      ),
                    )
                  ],
                )),
            Container(
                margin: EdgeInsets.only(top: 15),
                child: ButtonTheme(
                  buttonColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  minWidth: 220.0,
                  hoverColor: Colors.transparent,
                  child: RaisedButton(
                      color: Colors.black,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4),
                          side: BorderSide(color: Colors.white)),
                      onPressed: () => signUp(),
                      child: Text('Sign Up',
                          style: TextStyle(color: Colors.white))),
                )),
          ],
        ),
      ),
    ));
  }

  signUp() async {
    try {
      await auth
          .signUp(emailController.text.trim(), passwordController.text.trim())
          .whenComplete(() async {
        String name = userNameController.text.trim();
        String firstName = name.substring(0, name.indexOf(" "));
        String lastName = name.substring(name.indexOf(" ") + 1, name.length);
        User user = new User(
            id: 0,
            count: 0,
            email: emailController.text.trim(),
            firstName: firstName,
            balance: 0,
            lastName: lastName,
            roleId: 1);
        UserRepository repo = new UserRepository();
        String result = await repo.insertUser(user);
        print(result);
      });
    } catch (e) {
      print(e);
    }
  }
}
