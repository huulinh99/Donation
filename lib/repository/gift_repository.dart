
import 'package:donationsystem/models/campaign/campaign.dart';
import 'package:donationsystem/models/gift/Gift.dart';

abstract class BaseGiftRepository{
  Future<List<Gift>> fetchGift(int campaignID);
  List<Gift> fetchFakeGift(int campaignID);

}

class GiftRepository  implements BaseGiftRepository{

  @override
  List<Gift> fetchFakeGift(int campaignID) {
    List<Gift> tmpList = new List();
    tmpList.add(
        new Gift(
          description: "asdasdasdasdasdasda",
          ID: 1,
          name: "asdasdasdqweqwe",
          amount: 4545,
          campaignID: 1
        )
    );
    tmpList.add(
        new Gift(
            description: "21321asdaxz",
            ID: 2,
            name: "asdasdaxzasdqwqeqwesdqweqwe",
            amount: 452235,
            campaignID: 1
        )
    );
    tmpList.add(
        new Gift(
            description: "asdazzxczxasdadsqwsdasdasdasda",
            ID: 3,
            name: "ssadzxczxc",
            amount: 42545,
            campaignID: 1
        )
    );
    tmpList.add(
        new Gift(
            description: "azc cvsdasdasdasdasdasda",
            ID: 4,
            name: "asdasdasdqweqwe",
            amount: 4521345,
            campaignID: 2
        )
    );
    tmpList.add(
        new Gift(
            description: "asdasdasdz cvxcvasdasdasda",
            ID: 5,
            name: "asdasdasdqweqwe",
            amount: 454,
            campaignID: 2
        )
    );
    return tmpList;
  }

  @override
  Future<List<Gift>> fetchGift(int campaignID) {
    // TODO: implement fetchGift
    throw UnimplementedError();
  }

}