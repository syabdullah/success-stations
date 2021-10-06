import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/action/sign_up_action.dart';
import 'package:success_stations/utils/snack_bar.dart';

class SignUpController extends GetxController{
  bool isLoading = false;
  var signup, indiviualSignup, companySignUp;
  var result = false;

  createAccountData(data) async{
    isLoading = true;
    await createAccount(data).then((res){
      
        signup = jsonDecode(res.body);
        print("sign up studend......$signup");
      if(res.statusCode == 200 || res.statusCode < 400){
       
        isLoading = false; 
        Get.toNamed('/login');
        SnackBarWidget().showToast("",signup['message'] );
      }
      else {
        var key;
         signup['errors'].forEach((k,v){  
        print('-=-==0-0-00--0-0000--0$k,$v');   
        SnackBarWidget().showToast("", signup['errors'][k][0]);                                        
    });
        // key = signup['errors'].keys
         
      }
    });
    update();
  }

  individualAccountData(data) async{
    isLoading = true;
   
    await individualUser(data).then((res){
       print(res.body);
      if(res.statusCode == 200 || res.statusCode < 400){
        indiviualSignup = jsonDecode(res.body);
        isLoading =false;
        Get.toNamed('/login');
        SnackBarWidget().showToast("", indiviualSignup['message']);  
      } else {
        var key;
         indiviualSignup['errors'].forEach((k,v){  
        print('-=-==0-0-00--0-0000--0$k,$v');   
        SnackBarWidget().showToast("", indiviualSignup['errors'][k][0]);                                        
       });
        // key = signup['errors'].keys
         
      }
    });
    update();
  }

  companyAccountData(data) async{
    isLoading = true;
    await companyUser(data).then((res){
      print(res.body);
      if(res.statusCode == 200 ||res.statusCode < 400 ){
        companySignUp = jsonDecode(res.body);
        isLoading = false;
        Get.toNamed('/login');
        SnackBarWidget().showToast("", companySignUp['message']);  
      }
     else {
        var key;
         companySignUp['errors'].forEach((k,v){  
        print('-=-==0-0-00--0-0000--0$k,$v');   
        SnackBarWidget().showToast("", companySignUp['errors'][k][0]);                                        
       });
        // key = signup['errors'].keys
         
      }
    });
    update();
  }
}