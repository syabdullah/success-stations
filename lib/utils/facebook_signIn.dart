import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FaceBookSignIn {

   final FacebookLogin facebookSignIn = FacebookLogin();
   
   String message = 'Log in/out by pressing the buttons below.';

    Future<Null> login() async {
    final FacebookLoginResult result =
    await facebookSignIn.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        showMessage('''
         Logged in!
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        // showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        // showMessage('Something went wrong with the login process.\n'
        //     'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<Null> logOut() async {
    await facebookSignIn.logOut();
    showMessage('Logged out.');
  }

  void showMessage(String message) {
    // setState(() {
      message = message;
    // });
  }

}