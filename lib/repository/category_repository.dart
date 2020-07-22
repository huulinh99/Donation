
import 'dart:convert';

import 'package:donationsystem/models/category/category.dart';
import 'package:http/http.dart' as http;

abstract class BaseCategoryRepository{
  Future<List<Category>> fetchCategory();
}

class CategoryRepository  implements BaseCategoryRepository{

  @override
  Future<List<Category>> fetchCategory() async {
    List<Category> tmpList = null;
    try{
      final response = await http.get(
          'https://swdapi.azurewebsites.net/api/Category');
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        tmpList = new List();
        data.forEach((element) {
          tmpList.add(Category.fromJson(element));
        });
        return tmpList;
      }
    }catch(e){
      print(e);
    }finally{
      return tmpList;
    }
  }
}