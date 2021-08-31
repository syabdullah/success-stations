import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:success_stations/controller/sign_in_controller.dart';
import 'package:success_stations/view/auth/sign_up/student_sign_up.dart';

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
   final login =  Get.put(LoginController());
    print("..........................");
    try {
      await googleSignIn.signIn().then((value) {
        print(value);
        var json = {
           "email" : value!.email,
           'name' : value.displayName,
           'provider_id' : value.id
        };
        login.loginSocial(json);
        value.authentication.then((googleKey){
          // dataStore.write("access_token", googleKey.accessToken);
          // dataStore.write("id_token", googleKey.idToken);
              print(googleKey);
              print(googleKey.idToken);
              if(googleKey.accessToken != null) {
                // Get.toNamed('/tabs');
              }
              // print(googleSignIn.currentUser.displayName);
        }).catchError((err){
        });
      } 
      );
      // Get.to(StudentSignUp());
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleSignOut() => googleSignIn.disconnect();


}
