
import 'package:donationsystem/models/campaign/campaign.dart';
import 'package:donationsystem/models/gift/Gift.dart';
import 'package:donationsystem/models/user/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

abstract class BaseGiftRepository{
  Future<List<Gift>> fetchGift(int campaignID);
  Future<Campaign> getCampaign(int giftId);
  Future<String> donate(int campaignId, double money, User userDonate);
  //List<Gift> fetchFakeGift(int campaignID);
}

class GiftRepository  implements BaseGiftRepository{
  @override
  Future<List<Gift>> fetchGift(int campaignID) async {
    List<Gift> tmpList = null;
    try{
      final response = await http.get(
          'https://swdapi.azurewebsites.net/api/GiftDetail/$campaignID');
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        tmpList = new List();
        data.forEach((element) {
          tmpList.add(Gift.fromJson(element));
        });
        return tmpList;
      }
    }catch(e){
      print(e);
    }finally{
      return tmpList;
    }
  }

  String campaignId = "";

  Future<Campaign> getCampaign(int giftId) async {
    Campaign campaign;
    var response = await http.get("https://swdapi.azurewebsites.net/api/GiftDetail/CampaignByGiftId/$giftId");
    if (response.statusCode == 200) {
        var data = json.decode(response.body);
        campaign = Campaign.fromJson(data[0]);
      }
      return campaign;
  }

  Future<String> donate(int campaignId, double money, User userDonate) async {
    String url = 'https://swdapi.azurewebsites.net/api/GiftDetail/$campaignId/$money';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = jsonEncode(userDonate);
    Response response = await put(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    String body = response.body;
    return "OK";
  }

  // @override
  // List<Gift> fetchFakeGift(int campaignID) {
  //   List<Gift> tmpList = new List();
  //   tmpList.add(
  //       new Gift(
  //         description: "asdasdasdasdasdasda",
  //         ID: 1,
  //         name: "asdasdasdqweqwe",
  //         amount: 4545,
  //         campaignID: 1
  //       )
  //   );
  //   tmpList.add(
  //       new Gift(
  //           description: "21321asdaxz",
  //           ID: 2,
  //           name: "asdasdaxzasdqwqeqwesdqweqwe",
  //           amount: 452235,
  //           campaignID: 1
  //       )
  //   );
  //   tmpList.add(
  //       new Gift(
  //           description: "asdazzxczxasdadsqwsdasdasdasda",
  //           ID: 3,
  //           name: "ssadzxczxc",
  //           amount: 42545,
  //           campaignID: 1
  //       )
  //   );
  //   tmpList.add(
  //       new Gift(
  //           description: "azc cvsdasdasdasdasdasda",
  //           ID: 4,
  //           name: "asdasdasdqweqwe",
  //           amount: 4521345,
  //           campaignID: 2
  //       )
  //   );
  //   tmpList.add(
  //       new Gift(
  //           description: "asdasdasdz cvxcvasdasdasda",
  //           ID: 5,
  //           name: "asdasdasdqweqwe",
  //           amount: 454,
  //           campaignID: 2
  //       )
  //   );
  //   return tmpList;
  // }

  // @override
  // Future<List<Gift>> fetchGift(int campaignID) {
  //   // TODO: implement fetchGift
  //   throw UnimplementedError();
  // }

}