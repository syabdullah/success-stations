import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:success_stations/controller/categories_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_field.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:success_stations/utils/third_step.dart';
import 'package:success_stations/view/drawer_screen.dart';

class AddPostingScreen extends StatefulWidget {
  const AddPostingScreen({ Key? key }) : super(key: key);

  @override
  _AddPostingScreenState createState() => _AddPostingScreenState();
}

class _AddPostingScreenState extends State<AddPostingScreen> {
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   final catogoryController = Get.put(CategoryController());
  int activeStep = 0;
  int upperBound = 3;  
  final _formKey = GlobalKey<FormState>();
  List list= [];
  var selectedCategory;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(activeStep);
    return Scaffold(
      key: _scaffoldKey,
      appBar:  PreferredSize( preferredSize: Size.fromHeight(70.0),
      child: appbar(_scaffoldKey,context,AppImages.appBarLogo, AppImages.appBarSearch)),
      drawer: Theme(
        data: Theme.of(context).copyWith(
        ),
      child: AppDrawer(),
    ),
      body: ListView(
        children: [
          ImageStepper(
            stepColor: Colors.yellow,
            lineDotRadius: 0.1,
            lineColor: Colors.grey,
            activeStepColor: AppColors.appBarBackGroundColor,
            activeStepBorderColor: Colors.grey[700],
            lineLength: 75,
            enableNextPreviousButtons: false,
            images: [
              activeStep == 0 ?
              AssetImage(AppImages.sistStepIcon):
              AssetImage(AppImages.istStepIcon),
              activeStep == 1 ?
              AssetImage(AppImages.ssecStepIcon):
              AssetImage(AppImages.secStepIcon),
              activeStep == 2 ?
              AssetImage(AppImages.strdStepIcon):
              AssetImage(AppImages.trdStepIcon),
            ],
            // activeStep property set to activeStep variable defined above.
            activeStep: activeStep,
            // This ensures step-tapping updates the activeStep. 
            onStepReached: (index) {
              setState(() {
                activeStep = index;
              }
            );
            },
          ),
          header(),
          GetBuilder<CategoryController>( 
          init: CategoryController(),
          builder:(val) {
            val.getCityByRegion();
             list = val.cateList['data'];
            // for(int i; i<= list = val.cateList['data'][2]['çategory']; );
            // print('sadasasdasdasdasd $list');
            return activeStep == 0 ? istStep() : activeStep == 1 ? secondStep() : activeStep==2 ?  ThirdStep() : Container();
            
            }
            ),
            activeStep == 0 ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: nextButton(),
              ),
            ],
            ): activeStep == 1 ?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              previousButton(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: nextButton(),
              ),
             ],
            ):
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                saveAsDraftButton(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: publishButton(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return Container(
      height: 40.h,
      width: 130.w,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        onPressed:  () {   // Increment activeStep, when the next button is tapped. However, check for upper bound.
          if (activeStep < upperBound && _formKey.currentState!.validate()) {
            setState(() {
              activeStep++;
            });
          }
         },
        child: Text('Next'),
      ),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return Container(
      height: 40.h,
      width: 130.w,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
         style: ElevatedButton.styleFrom(
         primary: Colors.grey,
         textStyle: TextStyle(
         fontSize: 15,
         fontWeight: FontWeight.bold)),
         onPressed: () {
          if (activeStep > 0) {
            setState(() {
              activeStep--;
            });
          } 
        },
        child: Text('PREVIOUS'),
      ),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        activeStep == 0 ?
        Text(AppString.istStep,textAlign: TextAlign.center,
          style: AppTextStyles.appTextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.appBarBackGroundColor
          ) 
         ):
        Text(AppString.istStep,textAlign: TextAlign.center, 
          style: AppTextStyles.appTextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey
            )
          ),
        activeStep == 1 ?
        Text(AppString.secStep,textAlign: TextAlign.center,
          style: AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.appBarBackGroundColor)
        ):
        Text(AppString.secStep,textAlign: TextAlign.center, 
          style: AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)
        ),
        activeStep == 2 ?
        Text(AppString.thrStep,textAlign: TextAlign.center,
          style: AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.appBarBackGroundColor)
        ):
        Text(AppString.thrStep,textAlign: TextAlign.center, 
          style: AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)
        ),
      ],
    );
  }

  // // Returns the header text based on the activeStep.
  // String headerText() {
  //   switch (activeStep) {
  //     case 1:
  //       return 'Preface';

  //     case 2:
  //       return 'Table of Contents';

  //     case 3:
  //       return 'About the Author';

  //     case 4:
  //       return 'Publisher Information';

  //     case 5:
  //       return 'Reviews';

  //     case 6:
  //       return 'Chapters #1';

  //     default:
  //       return 'Introduction';
  //   }

Widget istStep(){
  return  Form(
    key: _formKey,
    child: Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.h,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal:15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0) //                 <--- border radius here
                    ),
                ),
                child:  ButtonTheme(
        alignedDropdown: true,
        child: Container(
          width: Get.width,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: Text(
                 selectedCategory != null ? selectedCategory : 'country', 
                style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)
              ),
              dropdownColor: AppColors.inPutFieldColor,
              icon: Icon(Icons.arrow_drop_down),
              items: list.map((coun) {
                return DropdownMenuItem(
                  value: coun,
                  child:Text(coun['category'])
                );
              }).toList(),
              onChanged: (val) {
                var adCategory;
                setState(() {
                  adCategory = val as Map;
                  selectedCategory = adCategory['category'];
                  // hintTextCountry = mapCountry['name'];
                  // selectedCountry = mapCountry['id'];
                });
              },
            )
          ),
        )
      )
                ),
              
            SizedBox(height: 5.h,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal:15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
              border: Border.all(color: Colors.grey,width: 1),
              borderRadius: BorderRadius.all(
              Radius.circular(5.0) //                 <--- border radius here
              ),  
            ),
            child: ListTile(
              tileColor: Colors.grey[200],
              title: Text("Type",
                style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:AppColors.inputTextColor,)
              ),
              trailing: DropdownButton<String>(
              items: <String>['A', 'B', 'C', 'D'].map((String value) {
              return DropdownMenuItem<String>(value: value,
                child: new Text(value),
                );
              }).toList(),
              onChanged: (_) {},
              ),
            ),
           ),
           SizedBox(height: 5.h,),
           Container(
             margin: const EdgeInsets.symmetric(horizontal:15.0),
             padding: const EdgeInsets.all(3.0),
             decoration: BoxDecoration(
               border: Border.all(color: Colors.grey,width: 1),
               borderRadius: BorderRadius.all(
               Radius.circular(5.0) //                 <--- border radius here
              ),
            ),
            child: ListTile(
              tileColor: Colors.grey[200],
              title: Text("Status",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:AppColors.inputTextColor,),),
              trailing: DropdownButton<String>(
              items: <String>['A', 'B', 'C', 'D'].map((String value) {
              return DropdownMenuItem<String>(value: value,
                child: new Text(value),
                );
              }).toList(),
              onChanged: (_) {},
              ),
            ),
           ),
           SizedBox(height: 5.h,),
           Container(
             margin: const EdgeInsets.symmetric(horizontal:15.0),
             padding: const EdgeInsets.all(3.0),
             decoration: BoxDecoration(
               border: Border.all(color: Colors.grey,width: 1),
               borderRadius: BorderRadius.all(
               Radius.circular(5.0) //                 <--- border radius here
              ),
            ),
            child: ListTile(
              tileColor: Colors.grey[200],
              title: Text("Title",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:AppColors.inputTextColor,),),
              trailing: DropdownButton<String>(
              items: <String>['A', 'B', 'C', 'D'].map((String value) {
              return DropdownMenuItem<String>(value: value,
                child: new Text(value),
                );
                }).toList(),
                onChanged: (_) {},
              ),
            ),
          ),
          SizedBox(height: 5.h,),
          Container(
            padding: EdgeInsets.symmetric(horizontal:15,),
            color: AppColors.inPutFieldColor,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.top,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              style: TextStyle(color:AppColors.inputTextColor,fontSize: 18,fontWeight: FontWeight.bold),
              decoration:InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 100.0),
                hintText: "Description",
                border: OutlineInputBorder( 
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              ) ,
            ),
           ),
            SizedBox(height: 5.h,),
            Container(
              padding: EdgeInsets.symmetric(horizontal:15),
              child: TextFormField(
                validator: (value) {
                if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                style: TextStyle(
                  color:AppColors.inputTextColor,fontSize: 18,fontWeight: FontWeight.bold
                ),
                decoration:InputDecoration( 
                  hintText: "Price",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey),
                ),
              ) ,
            ),
           ),
           SizedBox(height: 5.h,),
          ],
        ),
      )
    ],
  ),
);
}

Widget secondStep(){
  return Form(
    key: _formKey,
    child:Column(
      children: [
      SizedBox(height:10.h),
      Container(
        margin:EdgeInsets.symmetric(horizontal: 20),
        width: Get.width * 0.9,
        child: CustomTextFiled(
          isObscure: false,
          hintText: AppString.fullName,
          hintStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
          hintColor: AppColors.inputTextColor,
          onChanged: (value) {  },
          onSaved: (String? newValue) {  }, 
          onFieldSubmitted: (value) {  }, 
          // isObscure: true,
          textController: textEditingController ,
          validator: (value) {  
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
          },
          errorText: 'Please Enter Full Name',  
        ),
        ),
        SizedBox(height:10.h),
        Container(
        margin:EdgeInsets.symmetric(horizontal: 20),
        width: Get.width * 0.9,
        child: CustomTextFiled(
          isObscure: false,
          hintText: AppString.mobileNo,
          hintStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
          hintColor: AppColors.inputTextColor,
          onChanged: (value) {  },
          onSaved: (String? newValue) {  }, 
          onFieldSubmitted: (value) {  }, 
          // isObscure: true,
          textController: textEditingController ,
          validator: (value) {  
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
          },
          errorText: 'Please Enter Full Name',  
        ),
        ),
        SizedBox(height:10.h),
        Container(
        margin:EdgeInsets.symmetric(horizontal: 20),
        width: Get.width * 0.9,
        child: CustomTextFiled(
          isObscure: false,
          hintText: AppString.telephoneNo,
          hintStyle: TextStyle(fontSize: 13,fontWeight:FontWeight.bold),
          hintColor: AppColors.inputTextColor,
          onChanged: (value) {  },
          onSaved: (String? newValue) {  }, 
          onFieldSubmitted: (value) {  }, 
          // isObscure: true,
          textController: textEditingController ,
          validator: (value) {  
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
          },
          errorText: 'Please Enter Full Name',  
        ),
        ),
        SizedBox(height:10.h),
        Container(
        margin:EdgeInsets.symmetric(horizontal: 20),
        width: Get.width * 0.9,
        child: CustomTextFiled(
          isObscure: false,
          hintText: AppString.email,
          hintStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
          hintColor: AppColors.inputTextColor,
          onChanged: (value) {  },
          onSaved: (String? newValue) {  }, 
          onFieldSubmitted: (value) {  }, 
          // isObscure: true,
          textController: textEditingController ,
          validator: (value) {  
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
          },
          errorText: 'Please Enter Full Name',  
        ),
        ),
        SizedBox(height:15.h),
      ],
    ) ,
    );
  } 
  
  // Widget thirdStep(){
  //   return Column(
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 15.h,vertical: 15.h),
  //         child: Image.asset(AppImages.sampleImage),
  //       ),
        
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal:15.0),
  //         child: Card(
  //           child: Column(
  //             children: [
  //               Padding(
  //                  padding: const EdgeInsets.all(15),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text("TITLE GOES HERE",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
  //                     Text("SAR 112",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
  //                   ],
  //                 ),
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   Expanded(
  //                     flex: 1,
  //                     child: Column(
  //                       children: [
  //                         SizedBox(height: 20.h,),
  //                         Text(AppString.citystep,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
  //                         SizedBox(height: 7.h),
  //                         Text("DUBAI",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
  //                         SizedBox(height: 20.h,),
  //                          Text(AppString.citystep,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
  //                         SizedBox(height: 7.h),
  //                         Text("DUBAI",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
  //                         SizedBox(height: 10.h,),
  //                       ],
  //                     ),
  //                   ),
  //                    Expanded(
  //                      flex: 2,
  //                      child: Padding(
  //                        padding: const EdgeInsets.only(right:25),
  //                        child: Column(
  //                         children: [
  //                           SizedBox(height: 20.h,),
  //                           Text(AppString.citystep,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
  //                           SizedBox(height: 7.h),
  //                           Text("DUBAI",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
  //                           SizedBox(height: 20.h,),
  //                            Text(AppString.citystep,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
  //                           SizedBox(height: 7.h),
  //                           Text("DUBAI",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
  //                           SizedBox(height: 10.h),
                            
  //                         ],
  //                       ),
  //                      ),
  //                    ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 15),
  //       child: Card(child:Padding(
  //         padding: const EdgeInsets.all(15),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text("${AppString.details}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
  //             SizedBox(height:5.h),
  //             Text("AppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.details",
  //             textAlign: TextAlign.justify,
  //             style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.black),)
  //           ],
  //         ),
  //       ),
  //       ),
  //     ),
  //     Row(children: [
        
  //     ],)
  //     ],
  //   );
  // }
   Widget publishButton() {
    return Container(
       height: 40.h,
      width: 130.w,
      margin: EdgeInsets.symmetric(horizontal: 15.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        textStyle: TextStyle(
        fontSize: 13.w,
        fontWeight: FontWeight.bold)),
        onPressed: () { 
          Get.toNamed('/tabs');
         },
        child: Text('PUBLISH'),
      ),
    );
  }
   Widget saveAsDraftButton() {
    return Container(
       height: 40.h,
      width: 130.w,
      margin: EdgeInsets.symmetric(horizontal: 15.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        primary: Colors.grey,
        textStyle: TextStyle(
        fontSize: 13.w,
        fontWeight: FontWeight.bold)),
        onPressed: () {
        },
        child: Text('SAVE AS DRAFT',textAlign: TextAlign.left,),
      ),
    );
  }
}
