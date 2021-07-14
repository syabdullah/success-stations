import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FaceBookSignIn {
    
  GetStorage dataStore = GetStorage();

   final fb = FacebookLogin();

   String message = 'Log in/out by pressing the buttons below.';

    Future<Null> login() async {
      
      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      switch (res.status) {
        case FacebookLoginStatus.success:

          print('Access token: ${res.accessToken!.token}');
          // var accessToken = res.accessToken!.token.split(":");
          if(res.accessToken != null ) {
            dataStore.write("access_token",res.accessToken!.token);
            Get.toNamed('/home');
          }
          // Get profile data
          final profile = await fb.getUserProfile();
          print('Hello, ${profile!.name}! You ID: ${profile.userId}');

          // Get user profile image url
          final imageUrl = await fb.getProfileImageUrl(width: 100);
          print('Your profile image: $imageUrl');

          // Get email (since we request email permission)
          final email = await fb.getUserEmail();
          // But user can decline permission
          if (email != null)
            print('And your email is $email');

          break;
        case FacebookLoginStatus.cancel:
          // User cancel log in
          break;
        case FacebookLoginStatus.error:
          // Log in failed
          print('Error while log in: ${res.error}');
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