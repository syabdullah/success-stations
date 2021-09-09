

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/language_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/i18n/app_language.dart';

class ChooseLanguage extends StatefulWidget {
  ChooseLanguageStatePage createState() => ChooseLanguageStatePage();
}
class ChooseLanguageStatePage extends State<ChooseLanguage> {
  final getLang = Get.put(LanguageController());
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   var hintTextLang;
   @override
   void initState() {
    super.initState();
    getLang.getLanguas();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar:  PreferredSize( preferredSize: Size.fromHeight(70.0),
      child: stringAppbar(context,Icons.arrow_back_ios_new_sharp, 'choose_language'.tr,AppImages.appBarSearch)),
     body : GetBuilder<LanguageController>(
      init: LanguageController(),
      builder:(data){
        return language(data.languageList['data']);
      }
      )

    );
  }

  Widget language(List data) {
    return Container(
      margin:EdgeInsets.only(left:20, right: 20,top: 20),
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
              hintTextLang != null ? hintTextLang : 'choose_language'.tr, 
              style:  TextStyle(fontSize: 18,  color: AppColors.inputTextColor)
            ),
            dropdownColor: AppColors.inPutFieldColor,
            icon: Icon(Icons.arrow_drop_down),
            items: data.map((coun) {
              return DropdownMenuItem(
                value: coun,
                child:Text(coun['name'])
              );
            }).toList(),
            onChanged: (val) {
              var mapCountry;
              setState(() {
                mapCountry = val as Map;
                hintTextLang = mapCountry['name'];
                print("..........-==-=-=-=-=-=-..//././...-==-=-${mapCountry['short_code']}");
                box.write('lang_id',mapCountry['id']);
                box.write('lang_code', mapCountry['short_code']);
                LocalizationServices().changeLocale(mapCountry['short_code']);
              });
            },
          )
        )
      )
    );
  }
}