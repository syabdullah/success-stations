import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInC {

  GoogleSignInAccount? currentUser;

  GoogleSignIn googleSignIn = GoogleSignIn(   
    scopes: <String>[
      'email',
      // 'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
   
  singIn() {
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {

      currentUser = account;
      // if (_currentUser != null) {
      //   _handleGetContact(_currentUser!);
      // }
    });
    googleSignIn.signInSilently();
  }

  Future<void> handleSignIn() async {
    print("..........................");
    try {
      await googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleSignOut() => googleSignIn.disconnect();


}