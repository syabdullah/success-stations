import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/view/offers/my_offers.dart';

 Widget appbar(GlobalKey<ScaffoldState> globalKey,context ,image,searchImage,) {

    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: IconButton(
        iconSize: 20,
        icon: Icon(Icons.menu,color: Colors.white),
        onPressed: () => globalKey.currentState!.openDrawer()),
      title: Padding(
       padding: const EdgeInsets.only(top:10.0),
        child: Image.asset(image, height: 40),
      ), 
      actions: [
        GestureDetector(
          onTap: () {
            filtrationModel(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(top:12.0,right: 10,),
            child: Image.asset(
             AppImages.appBarSearch,color: Colors.white,width: 25.w,
            ),
          ),
        )
      ],
      backgroundColor: AppColors.appBarBackGroundColor,
    );
  }

Widget sAppbar(context ,icon,image,) {
    return AppBar(
      // automaticallyImplyLeading: false,
      centerTitle: true,
      leading: 
      // Padding(
        // padding: const EdgeInsets.only(top:10.0),
        IconButton(
          icon: Icon(icon,
          color: AppColors.backArrow),
          onPressed: () => Navigator.of(context).pop(),
        ),
      //
      //  ),
    title: Padding(
       padding: const EdgeInsets.only(top:10.0),
        child: Image.asset(image, height: 40),
      ),
      backgroundColor: AppColors.appBarBackGroundColor,
    );
  }

  Widget stringAppbar(context ,icon,string ,searchImage,) {
    return AppBar(
      // automaticallyImplyLeading: false,
      centerTitle: true,
      leading: 
        Container(
          margin: EdgeInsets.only(top:5),
          child: IconButton(
            icon: Icon(icon,
            color: AppColors.backArrow),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      //
      //  ),
      title: Container(
        margin: EdgeInsets.only(top:10),
        child: Center(
          child: Text(
            string
          )
        ),
      ), 
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10,),
          child:  Image.asset(
           AppImages.appBarSearch,color: Colors.white,width: 25.w,
          ),
        )
      ],
      backgroundColor: AppColors.appBarBackGroundColor,
    );
  }
  Widget stringbar(context, string) {
    return AppBar(
      // automaticallyImplyLeading: false,
      centerTitle: true,
      leading:
        IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp,
          color: AppColors.backArrow),
         onPressed: () => Get.back()
        ),
      title: Text(string), 
      
      backgroundColor: AppColors.appBarBackGroundColor,
    );
  }
    RangeValues _currentRangeValues = const RangeValues(1, 1000);
    var start;
  var end;
  filtrationModel(context) async {
     
    var size = MediaQuery.of(context).size;
    print(size);
   showModalBottomSheet(  
     isScrollControlled: false,
     context: context,   
     shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45.0), topRight: Radius.circular(45.0)
        ),
      ),
      backgroundColor: Colors.white,
       builder:(BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
          return Wrap(
            children: [
              Container(
                height: Get.height/2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top:20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin:EdgeInsets.only(left:30),
                            child: Text(AppString.filters,
                              style: TextStyle(
                                fontSize: 20, color: Colors.black
                              )
                            ),
                          ),
                          Container(
                            margin:EdgeInsets.only(right:20),
                            child: InkWell(
                              onTap: () => Get.back(),
                              child: Icon(Icons.close)
                            )
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                         color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(20)
                      ),
                      width: Get.width/4,
                     padding: EdgeInsets.symmetric(vertical: 10),
                      margin: EdgeInsets.only(top: 20,left: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Icon(Icons.location_on,color: Colors.blue,),
                          ),
                          Container(
                            child: Text("Nearby",style: TextStyle(color: Colors.blue)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: ('City'),
                          // labelStyle: TextStyle(color: AppColors.basicColor),
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).primaryColor)
                          )
                        ),
                      )
                    ),
                    Container(
                      decoration: BoxDecoration(
                         color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(20)
                      ),
                      width: Get.width/4,
                     padding: EdgeInsets.symmetric(vertical: 10),
                      margin: EdgeInsets.only(top: 20,left: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Icon(Icons.location_on,color: Colors.blue,),
                          ),
                          Container(
                            child: Text("Nearby",style: TextStyle(color: Colors.blue)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: RangeSlider(
                        values: _currentRangeValues,
                        min: 1.00,
                        max: 10000.00,
                        // divisions: 5,
                        labels: RangeLabels(
                          _currentRangeValues.start.round().toString(),
                          _currentRangeValues.end.round().toString(),
                        ),
                        onChanged: (values) {
                          setState(() {
                            _currentRangeValues = values;
                              start = _currentRangeValues.start.round().toString();
                              end = _currentRangeValues.end.round().toString();
                            print(".....!!!!!!!...!!!!!....$start");
                            print(".....!!!!!!!...!!!!!....$end");
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          // margin: EdgeInsets.only(top: 20),
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            color: Colors.grey[100],
                            child: Container(
                              width: Get.width / 4,
                              child: Center(
                                child: Text(AppString.resetButton,
                                  style: TextStyle(
                                    color: AppColors.inputTextColor
                                      )
                                    )
                                  )
                                ),
                            onPressed: () {
                              // Get.to(SignIn());
                            }
                          ),
                        ),
                        Container(
                          // margin: EdgeInsets.only(top: 20),
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            color: Colors.blue,
                            child: Container(
                              width: Get.width / 4,
                              child: Center(
                                child: Text("Apply",
                                  style: TextStyle( color: Colors.white)
                                )
                              )
                            ),
                            onPressed: (){

                            },
                          )
                              // onPressed: catFilteredID  == null && status == null ?  null :() {
                              //   applyFiltering();
                              //   Get.off(FilteredAdds());
                              // }),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ]
          );
          });
   
       }
   );
  }