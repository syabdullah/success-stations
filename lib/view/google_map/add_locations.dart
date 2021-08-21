import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/text_field.dart';

class AddLocations extends StatefulWidget {
  const AddLocations({ Key? key }) : super(key: key);

  @override
  _AddLocationsState createState() => _AddLocationsState();
}

class _AddLocationsState extends State<AddLocations> {


  TextEditingController fullNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    bottomSheet: Container(
      height:Get.height/1.8,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
           child: Text("_________",style: TextStyle(color: Colors.white),)
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('editlocation'.tr,style: TextStyle(color: Colors.white,fontSize: 20),),
          ),
          Padding( padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.gps_fixed,color: Colors.white,),
              SizedBox(width: 10,),
              Text('getCurrent'.tr,style: TextStyle(color: Colors.white,fontSize: 15),),
            ],
          )),
          SizedBox(height: 5,),
           Container(
            margin:EdgeInsets.symmetric(horizontal: 20),
            width: Get.width * 0.9,
            child: CustomTextFiled(
              isObscure: false,
              hintText: "street".tr,
              hintStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
              hintColor: AppColors.inputTextColor,
              onChanged: (value) {  },
              onSaved: (String? newValue) {  }, 
              onFieldSubmitted: (value) {  }, 
              // isObscure: true,
              textController: fullNameController ,
              validator: (value) {  
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              errorText: 'Please Enter Full Name',  
            ),
          ),
          SizedBox(height: 5,),
          Container(
            margin:EdgeInsets.symmetric(horizontal: 20),
            width: Get.width * 0.9,
            child: CustomTextFiled(
              isObscure: false,
              hintText: "city".tr,
              hintStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
              hintColor: AppColors.inputTextColor,
              onChanged: (value) {  },
              onSaved: (String? newValue) {  }, 
              onFieldSubmitted: (value) {  }, 
              // isObscure: true,
              textController: fullNameController ,
              validator: (value) {  
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              errorText: 'Please Enter Full Name',  
            ),
          ),
          SizedBox(height: 5,),
          Container(
            margin:EdgeInsets.symmetric(horizontal: 20),
            width: Get.width * 0.9,
            child: CustomTextFiled(
              isObscure: false,
              hintText: "district".tr,
              hintStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
              hintColor: AppColors.inputTextColor,
              onChanged: (value) {  },
              onSaved: (String? newValue) {  }, 
              onFieldSubmitted: (value) {  }, 
              // isObscure: true,
              textController: fullNameController ,
              validator: (value) {  
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              errorText: 'Please Enter Full Name',  
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              cancelButton(),
              saveButton()
            ],
          ),
           SizedBox(height: 10,),
        ],
      ),
        ),
      body:Stack(
        children: [
            
            Container(
              height: Get.height,
              child: Column(
                children: [
                  
                  Expanded(child: googleMap()),
                 
                ],
              ),
            ),
         Padding(
           padding: const EdgeInsets.only(left:15.0,top:35),
           child: GestureDetector(
             child: Icon(Icons.arrow_back),
             onTap: (){
               Get.back();
             },),
         ),
        ],
        
      ),
    );
  }
  
  
}
Widget googleMap(){
  return Container(
    height: Get.height,
    child: GoogleMap(
      initialCameraPosition: CameraPosition(
        zoom: 15,
        target: LatLng(51.507351,-0.127758),
      ),
    ),
  );
}
Widget saveButton() {
    return Container(
       height: 50,
      width: 130,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        primary: Colors.white,
        textStyle: TextStyle(
        fontSize: 13,
       
        fontWeight: FontWeight.bold)),
        onPressed: () { 
          //  adpostingController.finalAdPosting(json);
        //  
       
          // s
        // addpostingcon
         },
        child: Text('SAVE',style: TextStyle( color: Colors.blue,),),
      ),
    );
  }
  Widget cancelButton() {
    return Container(
       height: 50,
      width: 130,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        textStyle: TextStyle(
        fontSize: 13,
       
        fontWeight: FontWeight.bold)),
        onPressed: () { 
          //  adpostingController.finalAdPosting(json);
        //  
       
          // s
        // addpostingcon
         },
        child: Text('CANCEL',style: TextStyle( color: Colors.white,),),
      ),
    );
  }