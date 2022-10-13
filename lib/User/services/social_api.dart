abstract class SocialLogin {
  Future<LoginState> login();
  Future<bool> logout();
}

class LoginState {
  bool isLogin = false;
  bool isFreshman = false;
  LoginState({required this.isLogin, required this.isFreshman});
}
