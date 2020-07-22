class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final int roleId;
  final int count;

  User({
      this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.roleId,
      this.count
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        roleId: json['roleId'],
        count: json['count']
    );
  }
}