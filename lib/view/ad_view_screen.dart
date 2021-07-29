import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/custom_list.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:success_stations/utils/third_step.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdViewScreen extends StatefulWidget {
  const AdViewScreen({ Key? key }) : super(key: key);

  @override
  _AdViewScreenState createState() => _AdViewScreenState();
}

class _AdViewScreenState extends State<AdViewScreen> {
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize( preferredSize: Size.fromHeight(70.0),
        child: appbar(_scaffoldKey,context,AppImages.appBarLogo,AppImages.appBarSearch),
       ),
       body: SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 5),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
             ThirdStep(),
             SizedBox(height: 10.h,),
             listTileRow(),
              SizedBox(height: 14.h,),
              Text(AppString.adpostedat,
                style:AppTextStyles.appTextStyle(fontSize: 14.h, fontWeight: FontWeight.bold, color:AppColors.inputTextColor,
                ),
              ),
              commentInput(),
              SizedBox(height: 10.h,),
              commentButton(),
              SizedBox(height: 5.h,),
              Text("3 People Commented on this ad.",
                style:AppTextStyles.appTextStyle(fontSize: 14.h, fontWeight: FontWeight.bold, color:AppColors.inputTextColor,
                ),
              ),
              SizedBox(height: 3.h,),
              CustomListTile(
                title:listTileRow2(),
                
              ),
              SizedBox(height: 3.h,),
              CustomListTile(
                title:listTileRow2(),
                
              ),
              SizedBox(height: 3.h,),
              CustomListTile(
                title:listTileRow2(),
               
              ),
              SizedBox(height: 8.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  previousButton(AppImages.heart,AppString.fav,Colors.grey,),
                  previousButton(AppImages.contact,AppString.contact,Colors.blue,)
                ],
              ),
              SizedBox(height: 8.h,),
            ],
           ),
         )
       ),
    );
  }
}


Widget listTileRow(){
  return ListTile(
    title: Row(
      children: [
        CircleAvatar(
        backgroundColor: Colors.white54,
        radius: 30.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child:Image.asset(
            AppImages.profile,
          ),
        )
      ),
      Padding(
        padding: const EdgeInsets.only(left:8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("User Name",style:
              AppTextStyles.appTextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey,
              ),
            ),
            Text("Owner",style:
            AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey,
            ),
          ),
         ],
        ),
      )
     ],
    ),
    trailing: 
      Text("${AppString.seeProfile} >",style:
      AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.appBarBackGroundColor,
      ),
    ),
  );
}

Widget listTileRow2(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
            backgroundColor: Colors.white54,
            radius: 30.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child:Image.asset(
                AppImages.profile,
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("User Name",style:
                  AppTextStyles.appTextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey,
                  ),
                ),
                  Text("comment will be seen here.",style:
                  AppTextStyles.appTextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
          ],
        ),
        mytraling()
      ],
    ),
  );
}
Widget mytraling(){
  return Column(
    children: [
      Row(
        children: [
          Image.asset(AppImages.flag),
          SizedBox(width: 4.w,),
          Text(AppString.report,
            style:AppTextStyles.appTextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey,
           )
         )       
        ],
      ),
      Text( "09-07-2020 12:00",
        style:AppTextStyles.appTextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey,
        )
      ),
    ],
  );
}

Widget commentButton() {
    return Container(
      height: 40.h,
      width: Get.width,
      child: ElevatedButton(
        style:  ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
         borderRadius: BorderRadius.all(Radius.circular(5)),
         side: BorderSide(color: Colors.blue)
      )
    )
  ),
    onPressed:  () { },
      child: Text('ADD COMMENT'),
      ),
    );
  }

  /// Returns the previous button.
  Widget previousButton(image,text,Color color) {
    return Container(
      height: 40.h,
      width: 150.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        primary: color,
        textStyle: TextStyle(
        fontSize: 12.h,
        fontWeight: FontWeight.bold)),
        onPressed: () {}, 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(image),
            Text(text,),
          ],
        ),
      ),
    );
  }

Widget commentInput(){
  return  TextFormField(
    textAlignVertical: TextAlignVertical.top,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    },
    style: TextStyle(color:AppColors.inputTextColor,fontSize: 15.h,fontWeight: FontWeight.bold),
    decoration:InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 80.0),
      hintText: "Write comment here.",
      border: OutlineInputBorder( 
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: AppColors.inputTextColor),
      ),
    ) ,
  );
}