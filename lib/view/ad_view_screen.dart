import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/ad_posting_controller.dart';
import 'package:success_stations/controller/all_add_controller.dart';
import 'package:success_stations/controller/friends_controloler.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/custom_list.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:success_stations/utils/third_step.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:success_stations/view/UseProfile/user_profile.dart';
import 'package:success_stations/view/drawer_screen.dart';

class AdViewScreen extends StatefulWidget {
  const AdViewScreen({ Key? key }) : super(key: key);

  @override
  _AdViewScreenState createState() => _AdViewScreenState();
}

class _AdViewScreenState extends State<AdViewScreen> {
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final adpostingController = Get.put(AdPostingController());
  final adDetailCont = Get.put(MyAddsController());
  final friCont = Get.put(FriendsController());
  GetStorage box = GetStorage();
  var id,adId;
  var lang;
  String? comment,myName;
  var user_image;
   @override
  void initState() {
    super.initState();
    id = box.read('user_id');
    lang = box.read('lang_code');
    myName = box.read('name');
    user_image = box.read('user_image');
    adId = Get.arguments;
    adDetailCont.adsDetail(adId);

  }
  postComment() {
    var json = {
      'listing_id':adId,
      'comment': comment,
      'user_name_id':id
    };
    print(json);
    adpostingController.commentPost(json);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
       key: _scaffoldKey,
      appBar:  PreferredSize( preferredSize: Size.fromHeight(70.0),
      child: appbar(_scaffoldKey,context,AppImages.appBarLogo, AppImages.appBarSearch)),
      drawer: Theme(
        data: Theme.of(context).copyWith(
        ),
      child: AppDrawer(),
    ),
       body: SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 5),
           child: 
           GetBuilder<MyAddsController>(
          init: MyAddsController(),
          builder: (val) {
              print("....................>>${val.adsD}");
          return val.isLoading == true ? Center(child: CircularProgressIndicator()) :   val.adsD['data'] == null ? Container(
            child: Center(child: Text("NO Detail Here !"),),
          ): Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
             titleStep(val.adsD['data']),
             SizedBox(height: 10.h,),
             listTileRow(val.adsD),
              SizedBox(height: 14.h,),
              Container(
                margin: EdgeInsets.only(left:30),
                child: Text('ad_posted_at'.tr,
                  style:AppTextStyles.appTextStyle(fontSize: 14.h, fontWeight: FontWeight.bold, color:AppColors.inputTextColor,
                  ),
                ),
              ),
              commentInput(),
              SizedBox(height: 10.h,),
              commentButton(),
              SizedBox(height: 5.h,),
              Text(val.adsD != null ? "${val.adsD['data']['listing_comments'].length} People Commented on this ad." :'',
                style:AppTextStyles.appTextStyle(fontSize: 14.h, fontWeight: FontWeight.bold, color:AppColors.inputTextColor,
                ),
              ),
              SizedBox(height: 3.h,),
              listTileRow2(val.adsD['data']['listing_comments']),
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
           );
          }
           ),
         )
       ),
    );
  }


Widget titleStep(data) {
  print("ppppppppp-------${data['category']}");
  var htmldata = '';
  if(data != null ) {
 htmldata =
        """ <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
          ${data['description'][lang]}
    """;
  }
      return data == null ? 
      Container(
        child: Text("No Detail"),
      ) :
  Column(
      children: [
        data['image'].length != 0 ? 
        Image.network(data['image'][0]['url']):
        Container(
          height: Get.height/4,
          child: Center(child: Text("No Image !")),
        ),
        // Image.asset(AppImages.sampleImage),
        
        Card(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left:30,top:20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data['title'][lang].toString(),style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                    Text(data['price'].toString(),style: TextStyle(fontSize: 15),),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left:30),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30,),
                        Text(AppString.citystep,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                        SizedBox(height: 7.h),
                        Text(data['city']['city'].toString(),style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                        SizedBox(height: 15.h,),
                         Text("Ad Number:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                        SizedBox(height: 7.h),
                        Text(data['phone'] != null ?data['phone'].toString():'',style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                        SizedBox(height: 15.h,),
                         Text("SECTION:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                        SizedBox(height: 7.h),
                        // Text(data['category'] != null ? data['category']['category'][lang] : '',style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                        SizedBox(height: 15.h,),
                      ],
                    ),
                     Container(
                      //  margin: EdgeInsets.only(right: 20),
                       child: Container(
                         margin: EdgeInsets.only(left:60,bottom: 3),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(heig,),
                            Text(AppString.type,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                            SizedBox(height: 7.h),
                            Text(data['type'] != null ?data['type']['type'][lang].toString():'',style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                            SizedBox(height: 15.h,),
                             Text(AppString.status,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                            SizedBox(height: 7.h),
                            Text(data['status'].toString(),style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                            SizedBox(height: 15.h),
                            
                          ],
                          ),
                       ),
                     ),
                  ],
                ),
              )
            ],
          ),
        ),
      Card(
        child:Padding(
        padding: const EdgeInsets.only(left:30,top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${AppString.details}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
            SizedBox(height:5.h),
            Html(data: htmldata)
            // Text("AppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.details",
            // textAlign: TextAlign.justify,
            // style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.black),)
          ],
        ),
       ),
      ),
    ],
   );
}
Widget listTileRow(data){

  return data == null ? 
      Container(
        child: Text("No Detail"),
      ) :ListTile(
    title: Row(
      children: [
        CircleAvatar(
        backgroundColor: Colors.white54,
        radius: 30.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: user_image != null ? 
          Image.network(user_image['url']) : Image.asset(AppImages.person,color: Colors.grey[400])
          // Image.asset(
          //   AppImages.profile,
          // ),
        )
      ),
      Padding(
        padding: const EdgeInsets.only(left:8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(myName.toString(),style:
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
      GestureDetector(
        onTap: () {
          Get.to(UserProfile());
        },
        child: Text("${"see_profile".tr} >",style:
        AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.appBarBackGroundColor,
        ),
    ),
      ),
  );
}

Widget listTileRow2(data) {
  return Container(
    height: Get.height/3.5,
    child: ListView.builder(
      itemCount: data.length,
      itemBuilder: (context,index) {
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
                  child: data[index]['media'] != null ? 
                  Image.network(
                    data[index]['media']['url']
                  ):Image.asset(AppImages.person)
                )
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data[index]['user_name']['name'],style:
                      AppTextStyles.appTextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey,
                      ),
                    ),
                      Text(data[index]['comment'][lang],style:
                      AppTextStyles.appTextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
              ],
            ),
            mytraling(data[index])
          ],
        ),
      );
      }
    ),
  );
}
Widget mytraling(idU){
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          var json = {
            'user_reported' : idU['user_name']['id']
          };
          friCont.userReport(json,null);
        },
        child: Row(
          children: [
            Image.asset(AppImages.flag),
            SizedBox(width: 4.w,),
            Text(AppString.report,
              style:AppTextStyles.appTextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey,
             )
           )       
          ],
        ),
      ),
      Text(idU['created_at'],
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
    onPressed:  () {
      postComment();
      adDetailCont.adsDetail(adId);

     },
      child: Text('add_a_comment'.tr),
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
        onPressed: () {
          if(text == AppString.fav) {
          var json = {
            'ads_id' : adId
          };
          friCont.profileAdsToFav(json,null);
          } else {
            Get.toNamed('/contact');
          }
        }, 
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
    onChanged: (val) {
      setState((){
        comment = val;
      });
    },
    style: TextStyle(color:AppColors.inputTextColor,fontSize: 15.h,fontWeight: FontWeight.bold),
    decoration:InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 80.0),
      hintText: "write_comment_here".tr,
      border: OutlineInputBorder( 
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: AppColors.inputTextColor),
      ),
    ) ,
  );
}

}