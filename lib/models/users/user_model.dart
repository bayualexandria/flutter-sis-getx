class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final int statusId;

  const UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.statusId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'username': String username,
        'email': String email,
        'status_id': int statusId,
      } =>
        UserModel(
          id: id,
          name: name,
          username: username,
          email: email,
          statusId: statusId,
        ),
      _ => throw const FormatException('Gagal load data user.'),
    };
  }
}
