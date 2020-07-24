import 'dart:async';

import 'package:donationsystem/models/campaign/campaign.dart';
import 'package:donationsystem/models/gift/Gift.dart';
import 'package:donationsystem/models/user/user.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';
import 'dart:convert';

abstract class BaseGiftRepository {
  Future<List<Gift>> fetchGift(int campaignID);
  Future<Campaign> getCampaign(int giftId);
  Future<String> donate(int campaignId, double money, User userDonate);
  //List<Gift> fetchFakeGift(int campaignID);
}

class GiftRepository implements BaseGiftRepository {
  @override
  Future<List<Gift>> fetchGift(int campaignID) async {
    List<Gift> tmpList = null;
    try {
      final response = await http
          .get('https://swdapi.azurewebsites.net/api/GiftDetail/$campaignID');
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        tmpList = new List();
        data.forEach((element) {
          tmpList.add(Gift.fromJson(element));
        });
        return tmpList;
      }
    } catch (e) {
      print(e);
    } finally {
      return tmpList;
    }
  }

  String campaignId = "";

  Future<Campaign> getCampaign(int giftId) async {
    Campaign campaign;
    var response = await http.get(
        "https://swdapi.azurewebsites.net/api/GiftDetail/CampaignByGiftId/$giftId");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      campaign = Campaign.fromJson(data[0]);
    }
    return campaign;
  }

  Future<String> getToken(String userId) async {
    print(userId + " co user");
    var empData = await http.get(
        "https://prm391-project.herokuapp.com/api/accounts/gettoken/$userId");
    var token = json.decode(empData.body);
    print(token);
    return token["deviceToken"];
  }

  final String serverToken =
      "AAAAySqQXNM:APA91bFlj_fsnmeZrS6sYEKXtrzo4hMjLM_NR31VuA4BuvxjVY106G73x94tL90TU_BQDcWgGpksSK7E4VJKzTRWqQSXdAue1xqLSTEFRuTj5b0mgZhI0YzWSOSxDUr76uuwG5HazNOa";
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Future<Map<String, dynamic>> sendMessage(
      String userId, String body, String title) async {
    String token = await getToken(userId);

    await http
        .post(
          'https://fcm.googleapis.com/fcm/send',
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'key=$serverToken',
          },
          body: jsonEncode(
            <String, dynamic>{
              'notification': <String, dynamic>{
                'body': '$body',
                'title': '$title'
              },
              'priority': 'high',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'id': '1',
                'status': 'done'
              },
              'to': '$token',
            },
          ),
        )
        .then((value) => print(value.body));

    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );
    return completer.future;
  }

  User user;

  Future<User> getUserByCampaignId(int campaignId) async {
    var response = await http.get(
        "https://swdapi.azurewebsites.net/api/user/UserByCampaign/$campaignId");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      user = User.fromJson(data[0]);
    }
    return user;
  }

  Future<String> donate(int campaignId, double money, User userDonate) async {
    String url =
        'https://swdapi.azurewebsites.net/api/GiftDetail/$campaignId/$money';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = jsonEncode(userDonate);
    Response response = await put(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    await getUserByCampaignId(campaignId);
    if (statusCode == 200) {
      sendMessage(
          user.id.toString(),
          "You have a new donation !!!",
          '${userDonate.firstName}' +
              ' ' +
              '${userDonate.lastName}' +
              ' ' +
              "donated for you + ' ' + '${money.toString()}'+' ' + dollar");
    }
    String body = response.body;
    return "OK";
  }

  @override
  Future<List<Gift>> addGift(Gift gift) async {
    String url = 'https://swdapi.azurewebsites.net/api/GiftDetail';
    Map<String, String> headers = {"Content-type": "application/json"};
    String passingJson = jsonEncode(gift);
    Response response = await post(url, headers: headers, body: passingJson);
    return json.decode(response.body);
  }
}
