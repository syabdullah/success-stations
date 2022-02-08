import 'package:flutter/material.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ThirdStep extends StatefulWidget {
  const ThirdStep({ Key? key }) : super(key: key);

  @override
  _ThirdStepState createState() => _ThirdStepState();
}

class _ThirdStepState extends State<ThirdStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppImages.sampleImage),
        
        Card(
          child: Column(
            children: [
              Padding(
                 padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("TITLE GOES HERE",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                    Text("SAR 112",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h,),
                      Text(AppString.citystep,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                      SizedBox(height: 7.h),
                      Text("DUBAI",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                      SizedBox(height: 15.h,),
                       Text("Ad Number:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                      SizedBox(height: 7.h),
                      Text("123453242342",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                      SizedBox(height: 15.h,),
                       Text("SECTION:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                      SizedBox(height: 7.h),
                      Text("MEDICAL SUPPLY",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                      SizedBox(height: 15.h,),
                      
                    ],
                  ),
                   Container(
                     margin: EdgeInsets.only(right: 20),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15.h,),
                        Text(AppString.type,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                        SizedBox(height: 7.h),
                        Text("BOOKS",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                        SizedBox(height: 15.h,),
                         Text(AppString.status,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                        SizedBox(height: 7.h),
                        Text("NEW",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                        SizedBox(height: 10.h),
                        
                      ],
                      ),
                   ),
                ],
              )
            ],
          ),
        ),
      Card(
        child:Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${AppString.details}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
            SizedBox(height:5.h),
            Text("AppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.details",
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.black),)
          ],
        ),
       ),
      ),
    ],
   ); 
  }
}