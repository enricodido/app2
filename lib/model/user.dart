class UserModel {
  UserModel({
    required this.fullname,
    required this.username,
  });

  final String fullname;
  final String username;

  factory UserModel.fromData(Map<String, dynamic> data) {
    final String fullname = data['fullname'];
    final String username = data['username'];

    return UserModel(
      fullname: fullname,
      username: username,
    );
  }
}
