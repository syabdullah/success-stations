import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  get space20 => null;

  get statustogle => null;
  var valueRadio ,hintTextCountry,selectedRegion,  hintRegionText, selectedCountry, hintcityText, selectedCity;
  @override

    
  Widget build(BuildContext context) {
    final space20 = SizedBox(height: getSize(5, context));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: sAppbar(context, Icons.arrow_back_ios, AppImages.appBarLogo)
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              headingMember(),
              space20,
              emailAddress(),
              space20,
              namesAddress(),
              space20,
              phoneNember(),
              space20,
               countryRegion(),
              space20,
              apartmentAddress(),
              space20,
               region(),
              space20,city(),
              space20,
              submitButton(
              buttonText: 'comp_order'.tr,
              bgcolor: AppColors.appBarBackGroundColor,
              textColor: AppColors.appBarBackGroun,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headingMember() {
    return Text("contact_information".tr,
  //   maxLines: 1,
  //  overflow: TextOverflow.ellipsis,
  //   softWrap: false,
    style: TextStyle(fontSize: 20, color: Colors.grey));
  }

  Widget emailAddress() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'email_address'.tr,
        hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        ),
      ),
      controller: new TextEditingController(),
    );
  }

  Widget namesAddress() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'first_name'.tr,
              hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: null,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              ),
            ),
            controller: new TextEditingController(),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'last_name'.tr,
              hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: null,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              ),
            ),
            controller: new TextEditingController(),
          ),
        )
      ],
    );
  }

  Widget phoneNember() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'telephone_numbers'.tr,
        hintStyle: TextStyle(
        color: Colors.grey, // <-- Change this
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        ),
        //labelText: 'Text field alternate'
      ),
      controller: new TextEditingController(),
    );
  }
  Widget countryRegion() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'country'.tr,
        hintStyle: TextStyle(
        color: Colors.grey, // <-- Change this
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        ),
        //labelText: 'Text field alternate'
      ),
      controller: new TextEditingController(),
    );
  }
  

  // Widget countryRegion(List data) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 1.0),
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.grey, width: 1),
  //         borderRadius: BorderRadius.all(
  //           Radius.circular(5.0) //                 <--- border radius here
  //         ),
  //       ),
  //       child: ButtonTheme(
  //         alignedDropdown: true,
  //         child: Container(
  //           width: Get.width,
  //           child: DropdownButtonHideUnderline(
  //             child: DropdownButton(
  //               hint: Text(
  //                 hintTextCountry != null ? hintTextCountry : 'country'.tr,
  //                 style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)
  //               ),
  //               dropdownColor: AppColors.inPutFieldColor,
  //               icon: Icon(Icons.arrow_drop_down),
  //               items: data.map((coun) {
  //                 return DropdownMenuItem(
  //                   value: coun,
  //                   child:Text(coun['name']
  //                 )
  //               );
  //             }).toList(),
  //             onChanged: (val) {
  //               var mapCountry;
  //               setState(() {
  //                 mapCountry = val as Map;
  //                 hintTextCountry = mapCountry['name'];
  //                 selectedCountry = mapCountry['id'];
  //               });
  //             },
  //           )
  //         ),
  //       )
  //     )
  //   );

  // }

  Widget streetAddress() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Country Region',
        //labelText: 'Text field alternate'
      ),
      controller: new TextEditingController(),
    );
  }

  Widget apartmentAddress() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'apartment'.tr,
         hintStyle: TextStyle(
        color: Colors.grey, // <-- Change this
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        ),
        //labelText: 'Text field alternate'
      ),
      controller: new TextEditingController(),
    );
  }
   Widget region() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'region'.tr,
         hintStyle: TextStyle(
        color: Colors.grey, // <-- Change this
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        ),
        //labelText: 'Text field alternate'
      ),
      controller: new TextEditingController(),
    );
  }
  // Widget region(List dataRegion) {
  //   return  Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 1.0),
  //     padding: const EdgeInsets.all(6.0),
  //     width: Get.width ,//* 0.9,
  //     decoration: BoxDecoration(
  //       color: AppColors.inputColor,
  //       border: Border.all(color: Colors.grey, width: 1),
  //       borderRadius: BorderRadius.circular(5.0)
  //     ),
  //     child: ButtonTheme(
  //       alignedDropdown: true,
  //       child: DropdownButtonHideUnderline(
  //         child: DropdownButton(
  //           hint:Text(hintRegionText !=null ?hintRegionText : "region".tr, 
  //             style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)
  //           ),
  //           dropdownColor: AppColors.inPutFieldColor,
  //           icon: Icon(Icons.arrow_drop_down),
  //           items: dataRegion.map((reg) {
  //             return DropdownMenuItem(
  //               value: reg,
  //               child:Text(
  //                 reg['region']
  //               )
  //             );
  //           }).toList(),
  //           onChanged: (data) {
  //             var mapRegion;
  //             setState(() {
  //               mapRegion = data as Map ;
  //               hintRegionText = mapRegion['region'];
  //               selectedRegion = data['id'];
  //             });
  //           },
  //         )
  //       )
  //     )
  //   );
  // }
  Widget city() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'city'.tr,
         hintStyle: TextStyle(
        color: Colors.grey, // <-- Change this
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        ),
        //labelText: 'Text field alternate'
      ),
      controller: new TextEditingController(),
    );
  }
  
  // Widget city(List citydata) {
  //   return  Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 1.0),
  //     padding: const EdgeInsets.all(6.0),
  //     width: Get.width ,
  //     decoration: BoxDecoration(
  //       color: AppColors.inputColor,
  //       border: Border.all(color: Colors.grey, width: 1),
  //       borderRadius: BorderRadius.circular(2.0)
  //     ),
  //     child: ButtonTheme(
  //       alignedDropdown: true,
  //       child: DropdownButtonHideUnderline(
  //         child: DropdownButton(
  //           hint:Text(
  //             hintcityText !=null ? hintcityText : "city".tr, style: TextStyle(
  //               fontSize: 13, color: AppColors.inputTextColor
  //             )
  //           ),
  //           dropdownColor: AppColors.inputColor,
  //           icon: Icon(Icons.arrow_drop_down),
  //           items: citydata.map((citt) {
  //             return DropdownMenuItem(
  //               value: citt,
  //               child:Text(citt['city'])
  //             );
  //           }).toList(),
  //           onChanged: (value) {
  //             setState(() {
  //               var mapCity ;
  //               mapCity = value as Map;
  //               hintcityText = mapCity['city'];
  //               selectedCity = mapCity['id'];
  //             });
  //           },
  //         )
  //       )
  //     )
  //   );
  // }

 
  Widget submitButton(
      {buttonText,
      fontSize,
      callback,
      bgcolor,
      textColor,
      fontFamily,
      fontWeight}) {
    return AppButton(
      buttonText: buttonText,
      callback: callback,
      bgcolor: bgcolor,
      textColor: textColor,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }
}
