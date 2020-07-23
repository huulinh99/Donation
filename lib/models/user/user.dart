class User {
  int id;
  String email;
  String firstName;
  String lastName;
  int roleId;
  int count;
  double balance;

  User(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.roleId,
      this.count,
      this.balance});

  User.id(
      {this.email,
      this.firstName,
      this.lastName,
      this.roleId,
      this.count,
      this.balance});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        roleId: json['roleId'],
        count: json['count']);
  }

  Map toJson() => {
        'id': id,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'roleId': roleId,
        'count': count
      };
}
