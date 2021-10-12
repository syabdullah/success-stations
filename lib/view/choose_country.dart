
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/language_controller.dart';
import 'package:success_stations/controller/std_sign_up_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/view/ads.dart';

var countryId ;
class ChooseCountry extends StatefulWidget {
  ChooseCountryStatePage createState() => ChooseCountryStatePage();
}
class ChooseCountryStatePage extends State<ChooseCountry> {
  final getLang = Get.put(LanguageController());
  var countryHint, countryId, countryVal;
   // ignore: unused_field
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   var hintTextLang;
   @override
   void initState() {
    super.initState();
    getLang.getLanguas();
  }
  save() {
    box.write('country_id',countryVal['id']);
    Get.offAllNamed('/tabs');
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){Get.back();},
          child: Icon(Icons.arrow_back)),
          centerTitle: true,
          backgroundColor: AppColors.appBarBackGroundColor,
          title: Text('choose_country'.tr),
        ),
        body : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20,top: 20,right: 20),
            child: Text("select_country".tr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          ),
          GetBuilder<ContryController>(
            init: ContryController(),
            builder:(data){
              return country(data.countryListdata);
            }
          ),
          SizedBox(height: 20,),
          submitButton(
            bgcolor: AppColors.appBarBackGroundColor,
            textColor: AppColors.appBarBackGroun,
            buttonText: "save".tr,
            callback: save
          ),
        ],
      )
    );
  }
  Widget country(List data) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          width: Get.width * 0.9,
          decoration: BoxDecoration(
            color: AppColors.inputColor,
            border: Border.all(color: AppColors.outline),
            borderRadius: BorderRadius.circular(2.0)
          ),
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text(
                  countryHint != null ? countryHint : 'country'.tr,
                  style: TextStyle(fontSize: 18, color: AppColors.inputTextColor)
                ),
                dropdownColor: AppColors.inPutFieldColor,
                icon: Icon(Icons.arrow_drop_down),
                items: data.map((coun) {
                  return DropdownMenuItem(value: coun, 
                  child: coun['name'] !=null ?  Text(
                    coun['name'][lang] !=null ? coun['name'][lang]: coun['name'][lang] == null ? coun['name']['en']:'',
                  ): Container()
                );
                }).toList(),
                onChanged: (val) {
                   // ignore: unnecessary_statements
                   countryVal;
                  setState(() {
                    countryVal = val as Map;
                    countryHint = countryVal['name'][lang] !=null ?countryVal['name'][lang].toString()
                    :countryVal['name'][lang]==null ? countryVal['name']['en'].toString():"" ;
                    countryId = countryVal['id'];
                  });
                },
              )
            )
          )
        ),
      ],
    );
  }

  Widget submitButton(
    {buttonText,
    fontSize,
    callback,
    bgcolor,
    textColor,
    fontFamily,
    fontWeight,
    height,
    width,
    borderColor,
    image}) {
    return AppButton(
      buttonText: buttonText,
      callback: callback,
      bgcolor: bgcolor,
      textColor: textColor,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      image: image,
      width: width,
    );
  }
}