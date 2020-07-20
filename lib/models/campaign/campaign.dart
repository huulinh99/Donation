class Campaign {
  final int campaignId;
  final String campaignName;
  final String firstName;
  final String lastName;
  final int careless;
  final String startDate;
  final String endDate;
  final String description;

  Campaign(
      {
        this.campaignId,
        this.campaignName,
        this.description,
        this.careless,
        this.endDate,
        this.firstName,
        this.lastName,
        this.startDate
      }
    );

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      campaignId: json['campaignId'],
      campaignName: json['campaignName'],
      description: json['description'],
      careless: json['careless'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

}