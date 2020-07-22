
import 'dart:convert';

import 'package:donationsystem/models/campaign/campaign.dart';
import 'package:http/http.dart' as http;

abstract class BaseCampaignRepository{
  Future<List<Campaign>> fetchCampaign();
  List<Campaign> fetchFakeCampaign();

}

class CampaignRepository  implements BaseCampaignRepository{

  @override
  Future<List<Campaign>> fetchCampaign() async {
    List<Campaign> tmpList = null;
    try{
      final response = await http.get(
          'https://donation-system-api.herokuapp.com/api/campaign/CampaignsNewest/4');
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        tmpList = new List();
        data.forEach((element) {
          tmpList.add(Campaign.fromJson(element));
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
  List<Campaign> fetchFakeCampaign() {
    List<Campaign> tmpList = new List();
    tmpList.add(
      new Campaign(
        lastName: "Huynh",
        firstName: "Phu",
        description: "Lỏemasdjgasdhjasgdkgqywtouqwetnqiyuwetiuyqwtdiasyud",
        startDate: "2020-08-05",
        endDate: "2020-08-25",
        careless: 150,
        campaignId: 1,
        campaignName: "SADASDASDASDASDASD"
      )
    );
    tmpList.add(
        new Campaign(
            lastName: "Huynh",
            firstName: "Phu",
            description: "Lỏemasdjgasdhjasgdkgqywtouqwetnqiyuwetiuyqwtdiasyud",
            startDate: "2020-08-05",
            endDate: "2020-08-25",
            careless: 150,
            campaignId: 5,
            campaignName: "SADASDASDASDASDASD"
        )
    );
    tmpList.add(
        new Campaign(
            lastName: "Huxcvxcvynh",
            firstName: "Pxcvvxcvxcvxhu",
            description: "Lỏemasdjgasdhjasgdkgqywtouqwetnqiyuwetiuyqwtdiasyud",
            startDate: "2020-08-05",
            endDate: "2020-08-25",
            careless: 150,
            campaignId: 4,
            campaignName: "SADASDASDASDASDASD"
        )
    );
    tmpList.add(
        new Campaign(
            lastName: "Hu213123ynh",
            firstName: "Ph123123u",
            description: "Lỏemasdjgasdhjasgdkgqywtouqwetnqiyuwetiuyqwtdiasyud",
            startDate: "2020-08-05",
            endDate: "2020-08-25",
            careless: 150,
            campaignId: 2,
            campaignName: "SADASDASDASDASDASD"
        )
    );
    tmpList.add(
        new Campaign(
            lastName: "ádasdsd",
            firstName: "Phádasdasdasdasdasdu",
            description: "Lỏemasdjgasdhjasgdkgqywtouqwetnqiyuwetiuyqwtdiasyud",
            startDate: "2020-08-05",
            endDate: "2020-08-25",
            careless: 150,
            campaignId: 3,
            campaignName: "SADASDASDASDASDASD"
        )
    );
    return tmpList;
  }


}