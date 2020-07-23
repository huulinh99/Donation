
import 'package:donationsystem/repository/user_repository.dart';
import 'package:donationsystem/screens/effects/loading_cricle/LoadingCircle.dart';

import 'package:donationsystem/screens//main/main_screen.dart';
import 'package:donationsystem/screens/login/login_screen.dart';
import 'package:donationsystem/models/user/user.dart';
import 'package:donationsystem/services/Auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatelessWidget {
  final Auth auth = new Auth();
  UserRepository userRepository = new UserRepository();
  User currentUser;
  @override
  Future<String> signIn(String email, String password) async {
    try{
        auth.signIn(email, password);
        userRepository.fetchUserByEmail(email.toString().trim()).then((value) => currentUser=value);
    }catch(e){
        return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<String>(
          stream: auth.onAuthStateChanged,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.active){
              //return MainScreen(auth.signOut);
              return snapshot.hasData ? MainScreen(auth.signOut) : LoginScreen(signIn, auth.signInWithGoogle);
            }
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: LoadingCircle(50, Colors.black),
            );
          }
      )
    );
  }
}
