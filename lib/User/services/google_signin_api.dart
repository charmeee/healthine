import 'dart:developer';

import 'package:healthin/User/services/social_api.dart';

import 'social_api.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogin implements SocialLogin {
  @override
  Future<LoginState> login() async {
    final _googleSignIn = GoogleSignIn(
      clientId:
          "812774997300-qmjr67kjsue5up5vupt9f9teicnq49r9.apps.googleusercontent.com",
    );
    try {
      var googleLoginResult = await _googleSignIn.signIn();
      if (googleLoginResult != null) {
        var ggauth = await googleLoginResult.authentication;
        if (ggauth != null) {
          log("ggauth.accessToken: ${ggauth.accessToken}");
          log("ggauth.idToken: ${ggauth.idToken}");
          return LoginState(isLogin: true, isFreshman: false);
        }
        //SignInRequest(googleLoginResult.email, "fiowfef", context);
        return LoginState(isLogin: true, isFreshman: false);
      } else {
        return LoginState(isLogin: false, isFreshman: false);
      }
    } catch (e) {
      print("\n---LoginFailed\n");
      print(e);
      return LoginState(isLogin: false, isFreshman: false);
    }
  }

  @override
  Future<bool> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
