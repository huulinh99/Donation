class Gift {
  final int id;
  final int campaignID;
  final String giftName;
  final double amount;
  final String description;
  final String image;
  final int quantity;


  Gift({this.id, this.campaignID, this.giftName, this.amount, this.description, this.image, this.quantity});

  factory Gift.fromJson(Map<String, dynamic> json) {
    return Gift(
      id: json['id'],
      campaignID: json['campaignID'],
      giftName: json['giftName'],
      amount: json['amount'],
      description: json['description'],
      image: json['image'],
      quantity: json['quantity']
    );
  }

}