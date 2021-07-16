import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPostingScreen extends StatefulWidget {
  const AddPostingScreen({ Key? key }) : super(key: key);

  @override
  _AddPostingScreenState createState() => _AddPostingScreenState();
}

class _AddPostingScreenState extends State<AddPostingScreen> {
 
   int activeStep = 0; // Initial step set to 5.

  int upperBound = 3; // 
  @override
  Widget build(BuildContext context) {
    print(activeStep);
    return SafeArea(
      child: Scaffold(
        appBar:AppBar(),
        body: ListView(
          children: [
            ImageStepper(
              lineDotRadius: 0.1,
              lineColor: Colors.grey,
              activeStepColor: Colors.blue,
              activeStepBorderColor: Colors.blue,
              lineLength: 75,
              enableNextPreviousButtons: false,
              images: [
                activeStep == 0 ?
                AssetImage(AppImages.sistStepIcon):
                AssetImage(AppImages.istStepIcon),
                activeStep == 1 ?
                AssetImage(AppImages.ssecStepIcon):
                AssetImage(AppImages.istStepIcon),
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
                });
              },
            ),
            header(),
            Column(
              children: [
                activeStep == 0 ?
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
                        child: ListTile(
                          tileColor: Colors.grey[200],
                          title: Text("Category",style: 
                            TextStyle(
                              fontSize: 18,fontWeight: FontWeight.bold,color:AppColors.inputTextColor,
                            ),
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
                      title: Text("Type",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:AppColors.inputTextColor,)),
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
                    height: 100.h,
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey,width: 1),
                      borderRadius: BorderRadius.all(
                      Radius.circular(5.0) //                 <--- border radius here
                      ),
                      
                    ),
                    child: Container(
                      color: AppColors.inPutFieldColor,
                      child: TextField(
                        style: TextStyle(color:AppColors.inputTextColor,fontSize: 18,fontWeight: FontWeight.bold),
                        decoration:InputDecoration(
                          
                          hintText: "Description",
                          border: OutlineInputBorder(
                            
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        ) ,
                      ),
                    )
                  ),
                  SizedBox(height: 5.h,),
                   Container(
                    // height: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey,width: 1),
                      borderRadius: BorderRadius.all(
                      Radius.circular(5.0) //                 <--- border radius here
                      ),
                      
                    ),
                    
                    child: Container(
                      color: Colors.grey[50],
                      child: TextField(
                        style: TextStyle(
                          color:AppColors.inputTextColor,fontSize: 18,fontWeight: FontWeight.bold
                        ),
                        decoration:InputDecoration( 
                          hintText: "Price",
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        ) ,
                      ),
                     )
                    ),
                  SizedBox(height: 5.h,),
                 ],
                ),
              )
                
                : activeStep == 1 ? Text("Tahir") : activeStep==2 ? Text("Maryam") : Container()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // previousButton(),
                nextButton(),
              ],
            ),
          ],
        ),
      ),
    );
    
  }

  /// Returns the next button.
  Widget nextButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        onPressed: () {
          // Increment activeStep, when the next button is tapped. However, check for upper bound.
          if (activeStep < upperBound) {
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
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: Text('Prev'),
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
        Text(AppString.secStep,textAlign: TextAlign.center,style: AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.appBarBackGroundColor)):
        Text(AppString.istStep,textAlign: TextAlign.center, style: AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
        activeStep == 2 ?
        Text(AppString.thrStep,textAlign: TextAlign.center,style: AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.appBarBackGroundColor)):
        Text(AppString.istStep,textAlign: TextAlign.center, style: AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),

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
  }
