
import 'package:flutter/material.dart';

class CampaignCard extends StatefulWidget {
  final String title;
  final String ownerId;
  final String description;
  final int careless;
  CampaignCard(this.title, this.ownerId, this.description, this.careless);

  @override
  _CampaignCardState createState() => _CampaignCardState();

}

class _CampaignCardState extends State<CampaignCard> {

  bool isFavourite = false;
  Color _iconColor = Color.fromRGBO(0, 0, 0, .4);
  @override
  Widget build(BuildContext context) {
    List <String> listImage = new List();
    listImage.add('assets/images/banner1.jpg');
    return Container(
        margin: EdgeInsets.fromLTRB(5, 0, 5, 15),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(1),
            spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(1, 1), // changes position of shadow
            )]),
        child: Column(
          children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/donation-system-22f8e.appspot.com/o/banner.jpg?alt=media&token=84a654c3-3554-4940-b0e9-3532db2c1754",
                fit: BoxFit.fill,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
                  padding: const EdgeInsets.only(left: 15),
                  child: Text("${widget.title}", style: Theme.of(context).textTheme.headline5, overflow: TextOverflow.ellipsis, ),
                ),
                Container(
                    child:
                    Text(
                        '${widget.ownerId}',
                        style: TextStyle(fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w600)),
                        padding: const EdgeInsets.only(left: 15),
                ),
                Container(
                  padding: new EdgeInsets.fromLTRB(15, 5, 15, 0),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse vulputate finibus dignissim. Vestibulum ut elit in turpis condimentum gravida. Aenean sodales, dui efficitur gravida...",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    softWrap: true,
                    style: TextStyle(height: 1.75, fontWeight: FontWeight.normal, fontSize: 15),
                  ),

                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Divider(
                      thickness: 1,
                      color: Colors.black
                  )
                ),
                Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          flex: 8,
                          child: Text("View more..."),
                        ),

                        IconButton(
                          icon: putFavourite(),
                          onPressed: handelFavourite,
                        ),
                        Text("${widget.careless}")
                      ],
                    )
                ),

              ],
          )],
        )
    );
  }
  void favouriteCampaign(){
    if(_iconColor == Color.fromRGBO(0, 0, 0, .4)){
      this.setState(() {
        _iconColor = Colors.red;
      });
    }else{
      this.setState(() {
        _iconColor = Color.fromRGBO(0, 0, 0, .4);
      });
    }
  }
  handelFavourite(){
    print(isFavourite);
    setState(() {
      isFavourite = !isFavourite;
    });
  }

  putFavourite(){
    if(isFavourite == true){
      return Icon(
          Icons.favorite_border
      );
    }else{
      return Icon(
        Icons.favorite,
        color: Colors.red,
      );
    }
  }


}
