import 'package:flutter/material.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/bottom_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({ Key? key }) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomBottomBar(),
      appBar: PreferredSize( preferredSize: Size.fromHeight(70.0),    
       child: stringAppbar('','ABOUT US',AppImages.appBarSearch),
      ),
     body: Column(
      children: [
        // CustomTabBar(),
        Padding(
          padding: const EdgeInsets.only(top:50),
          child: Image.asset(AppImages.logo,height: 150.h,),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
          child: Text("Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of  (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum,  comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s  accompanied by English versions from the 1914 translation by H. Rackham ....",textAlign: TextAlign.start,
          style: AppTextStyles.appTextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.inputTextColor
      ),),
        ),
        
      ],
    ),
    );
  }
}