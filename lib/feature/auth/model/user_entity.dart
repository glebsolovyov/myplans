base class UserEntity{
  const UserEntity({
    required this.id, 
    required this.login, 
    required this.password
    });

  final int id;
  final String login;
  final String password;
}