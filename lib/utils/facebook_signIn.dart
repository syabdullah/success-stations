import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/sign_in_controller.dart';

class FaceBookSignIn {
    
  GetStorage dataStore = GetStorage();

   final fb = FacebookLogin();

   String message = 'Log in/out by pressing the buttons below.';
   var id;
   var name;
   var email;
    Future<Null> login() async {
      final login =  Get.put(LoginController());
      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);
      switch (res.status) {
        case FacebookLoginStatus.success:
          if(res.accessToken != null ) {
            dataStore.write("access_token",res.accessToken!.token);
          }
          final profile = await fb.getUserProfile();
          print('Hello, ${profile!.name}! You ID: ${profile.userId}');
          id = profile.userId;
          name = profile.name;
          final imageUrl = await fb.getProfileImageUrl(width: 100);
          print('Your profile image: $imageUrl');
           email = await fb.getUserEmail();
          // But user can decline permission
          if (email != null)
            print('And your email is $email');
           var json = {
            "email" :email,
            'name' : name,
            'provider_id' : id
          };
          login.loginSocial(json);
          // Get.toNamed('/tabs');
          break;
        case FacebookLoginStatus.cancel:
          // User cancel log in
          break;
        case FacebookLoginStatus.error:
          // Log in failed
           break;
      }


  }

  Future<Null> logOut() async {
    await fb.logOut();
    showMessage('Logged out.');
  }

  void showMessage(String message) {
    // setState(() {
      message = message;
    // });
  }

}
