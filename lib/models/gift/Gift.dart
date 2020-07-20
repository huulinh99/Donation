class Gift {
  final int ID;
  final int campaignID;
  final String name;
  final double amount;
  final String description;


  Gift({this.ID, this.campaignID, this.name, this.amount, this.description});

  factory Gift.fromJson(Map<String, dynamic> json) {
    return Gift(
      ID: json['ID'],
      campaignID: json['campaignID'],
      name: json['name'],
      amount: json['amount'],
      description: json['description'],
    );
  }

}