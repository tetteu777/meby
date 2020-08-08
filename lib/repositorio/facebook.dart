import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class Facebook {
  Future<FacebookAccessToken> getAccessToken() async {
    FacebookLogin facebookLogin = FacebookLogin();
    final facebookLoginResult =
        await facebookLogin.logIn(['email', 'public_profile']).catchError((e) {
      print(e.toString());
    });

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.loggedIn:
        return facebookLoginResult.accessToken;
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Facebook login cancelado pelo usuário');
        break;
      case FacebookLoginStatus.error:
        print('${facebookLoginResult.errorMessage}');
        break;
    }
  }

  Future<AuthCredential> getAuthCredential() async {
    final accessToken = await getAccessToken();
    final authCredential =
        FacebookAuthProvider.getCredential(accessToken: accessToken.token);
    return authCredential;
  }
}
