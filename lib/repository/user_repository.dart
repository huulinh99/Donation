
import 'dart:convert';

import 'package:donationsystem/models/user/user.dart';
import 'package:http/http.dart' as http;

abstract class BaseCategoryRepository{
  Future<List<User>> fetchUserMostFavourite();
}

class UserRepository  implements BaseCategoryRepository{

  @override
  Future<List<User>> fetchUserMostFavourite() async {
    List<User> tmpList = null;
    try{
      final response = await http.get(
          'https://swdapi.azurewebsites.net/api/Category');
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        tmpList = new List();
        data.forEach((element) {
          tmpList.add(User.fromJson(element));
        });
        return tmpList;
      }
    }catch(e){
      print(e);
    }finally{
      return tmpList;
    }
  }


  @override
   Future<User> fetchUserByEmail(String email) async {    
      User user; 
      print(email);
      final response = await http.get(
          'https://swdapi.azurewebsites.net/api/user/CurrentUser/$email');        
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        user = User.fromJson(data[0]);
      }
      return user;
      
  }
}