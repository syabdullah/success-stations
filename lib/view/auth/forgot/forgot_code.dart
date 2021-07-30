
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/utils/page_util.dart';
import 'package:success_stations/view/auth/forgot/reset_password.dart';

class ForgotCode extends StatefulWidget {
  _ForgotCodeState createState() => _ForgotCodeState();
}
class _ForgotCodeState extends State<ForgotCode> {
  TextEditingController emailController = TextEditingController();
  final FocusNode _textNode = FocusNode();
  
  final formKey = new GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

    // List<Widget> getField(size) {
    //   final List<Widget> result = <Widget>[];
    //   for (int i = 1; i <= count; i++) {
    //     result.add(
    //       ShakeAnimatedWidget(
    //         enabled: shake,
    //         duration: const Duration(
    //           milliseconds: 100,
    //         ),
    //         shakeAngle: Rotation.deg(
    //           z: 20,
    //         ),
    //         curve: Curves.linear,
    //         child: Column(
    //           children: <Widget>[
    //             if (code.length >= i)
    //             Padding(
    //               padding:  const EdgeInsets.symmetric(
    //                 horizontal:  5.0,
    //               ),
    //               child: Text(
    //                 code[i - 1],
    //                 style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 30,
    //                   fontWeight: FontWeight.w700,
    //                 ),
    //               ),
    //             ),
    //             Padding(
    //               padding:  const EdgeInsets.symmetric(horizontal:  5.0, ),
    //               child: Center(
    //                 child: Container(
    //                   margin: EdgeInsets.only(left:10,right: 10),
    //                   height: 5.0,
    //                   width:size.width/9.8,
    //                   color: Colors.green,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   }
    //   return result;
    // }
  @override
  Widget build(BuildContext context) {
    final space10 = SizedBox(height: getSize(10, context));
    final space20 = SizedBox(height: getSize(20, context));
    final space50 = SizedBox(height: getSize(50, context));
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
        key: formKey,
          child: Column(
            children: [
              space50, 
              Container(
                margin: EdgeInsets.only(top: 60),
                child: Center(
                  child: Image.asset(
                    AppImages.appLogo, height: Get.height / 4.40
                  ),
                ),
              ),
              space50,
              textHint(),
              space10,
              // digitscode(),
              space20,
              submitButton(
                bgcolor: AppColors.appBarBackGroundColor,  
                textColor: AppColors.appBarBackGroun,
                buttonText: AppString.next,
                fontSize: 18.toDouble(),
                callback: navigateToHomeScreen
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget textHint(){
    final space20 = SizedBox(height: getSize(20, context));
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left:30),
          child: Text(AppString.digitsCode, style: TextStyle(fontSize: 23,color: AppColors.inputTextColor))
        ),
        space20, 
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left:30),
          child: Text(AppString.codeMail, style: TextStyle(fontSize: 13, color: AppColors.inputTextColor),)
        ),
      ],
    );
  }
//   Widget digitscode() {
//     return Container(
//       height: 90,
//       margin: EdgeInsets.only(left:8, right: 10),
//         child: Stack(
//           children: <Widget>[
//             Opacity(
//               opacity: 0.0,
//               child: TextFormField(
//                 controller: _controller,
//                 focusNode: _textNode,
//                 // keyboardType: TextInputType.number,
//                 onChanged: onCodeInput,
//                 maxLength: count == 5 ? 5:6,
//               ),
//             ),
//             Positioned(
//               bottom: 40,
//               child: Row(
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 children: getField(screenSize),
//               ),
//             )
//           ],
//         ),
//       );
// }
   Widget submitButton({buttonText, fontSize, callback, bgcolor, textColor, fontFamily, fontWeight,height,width,borderColor,image}) {
    return AppButton(
      buttonText: buttonText, 
      callback: callback,
      bgcolor: bgcolor,
      textColor: textColor,
      fontFamily: fontFamily ,
      fontWeight: fontWeight ,
      fontSize: fontSize,    
      // borderColor: borderColor,
      image: image,
      width: width,  
    );
  }
  void navigateToHomeScreen() {
    PageUtils.pushPage(ResetPassword());
  } 
}
 