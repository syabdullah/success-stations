import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:success_stations/view/auth/sign_up.dart';

class GoogleSignInC {
  GetStorage dataStore = GetStorage();
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
      await googleSignIn.signIn().then((value) {
        value!.authentication.then((googleKey){
          dataStore.write("access_token", googleKey.accessToken);
          dataStore.write("id_token", googleKey.idToken);
              print(googleKey.accessToken);
              print(googleKey.idToken);
              if(googleKey.accessToken != null) {
                Get.toNamed('/home');
              }
              // print(googleSignIn.currentUser.displayName);
        }).catchError((err){
            print('inner error');
        });
      } 
      );
      Get.to(SignUp());
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleSignOut() => googleSignIn.disconnect();


}