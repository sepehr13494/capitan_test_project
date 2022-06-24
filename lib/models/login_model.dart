class LoginModel{
  final String username;
  final String password;
  final bool? isAdmin;

  LoginModel({required this.username , required this.password, this.isAdmin});
}