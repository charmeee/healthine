import 'social_api.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogin implements SocialLogin {
  @override
  Future<bool> login() async {
    final _googleSignIn = GoogleSignIn(
      clientId:
          "812774997300-qmjr67kjsue5up5vupt9f9teicnq49r9.apps.googleusercontent.com",
    );
    try {
      var googleLoginResult = await _googleSignIn.signIn();
      if (googleLoginResult != null) {
        var ggauth = await googleLoginResult.authentication;
        if (ggauth != null) {}
        //SignInRequest(googleLoginResult.email, "fiowfef", context);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("\n---LoginFailed\n");
      print(e);
      return false;
    }
  }

  @override
  Future<bool> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
