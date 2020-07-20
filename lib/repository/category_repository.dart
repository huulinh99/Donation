
import 'dart:convert';

import 'package:donationsystem/models/campaign/campaign.dart';
import 'package:http/http.dart' as http;

abstract class BaseCategoryRepository{
  Future<List<Campaign>> fetchCategory();
}

class CategoryRepository  implements BaseCategoryRepository{
  @override
  Future<List<Campaign>> fetchCategory() {
    // TODO: implement fetchCategory
    throw UnimplementedError();
  }


}