import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:success_stations/controller/my_adds/my_adds_controller.dart';
import 'package:success_stations/controller/offers/offer_category_controller.dart';
import 'package:success_stations/controller/offers/store_offer_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_field.dart';
import 'package:success_stations/utils/app_headers.dart';


class AddOffersPage extends StatefulWidget {
  AddOffersState createState() => AddOffersState();
}

class AddOffersState extends State<AddOffersPage> {
  int activeStep = 0;
  List list = [];
  List type = [];
  var subtypeId,  statusSelected, imageName,selectedtype, postDataEdited, 
  addedEditPosting, edittImage,  uiStatus, hintTextCate, hintLinking, 
  idCategory, lang, selectedCategory, hintLinkingId, createdJson , fileName, addedOfferImage;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int upperBound = 3;
  GetStorage box = GetStorage();
  XFile? pickedFile;
  late String image;
  final ImagePicker _picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController urlContr = TextEditingController();
  final editDataController = Get.put(StorePostAddesController());
  
  @override
  void initState() {
    super.initState();
    lang = box.read('lang_code');
    postDataEdited = Get.arguments;
    if (postDataEdited != null) {
      addedEditPosting = postDataEdited['id'];
      hintTextCate = postDataEdited['category']['category_name']['en'];
      idCategory = postDataEdited['category']['id'];
      descriptionController =TextEditingController(text: postDataEdited['description']['en']);
      titleController =  TextEditingController(text: postDataEdited['text_ads']['en']);
      urlContr = TextEditingController(text: postDataEdited['url']);
      hintLinkingId = postDataEdited['link_to_listings'];
      statusSelected =  TextEditingController(text: postDataEdited['status'].toString());
      edittImage = postDataEdited['image'] != null  ? postDataEdited['image']['url'] : null;
      imageName = postDataEdited['image'] != null ? postDataEdited['image']['file_name'] : null;
      hintLinking =postDataEdited['listing']!=null ? postDataEdited['listing']['title']['en']:'Ads Listing';
    }
  }
  
  Future getImage() async {
    await ApiHeaders().getData();
    pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = pickedFile!.path;
        fileName = pickedFile!.path.split('/').last;
      } else {
      }
    });
    try {
      imageName = null;
      dio.FormData formData = dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(pickedFile!.path,
          filename: fileName
        ),
      });
      Get.find<StorePostAddesController>().uploadMyAdd(formData);
      addedOfferImage =Get.find<StorePostAddesController>().uploadImageOfAdd['name'];
    } catch (e) {}
  }

  adOffersCreate() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      if (pickedFile != null) {
        try {
          dio.FormData formData = dio.FormData.fromMap({
            'category_id': idCategory,
            'description': descriptionController.text,
            'text_ads': titleController.text,
            'url': urlContr.text,
            'listing_id': hintLinkingId,
            'status': statusSelected,
            'image': imageName != null ? imageName : Get.find<StorePostAddesController>().uploadImageOfAdd['name'],
          });
          Get.find<StorePostAddesController>().storefOffersAAll(formData);
        } catch (e) {}
      }
    }
  }

  editPost() async {
    var json = {
      'category_id': idCategory,
      'description': descriptionController.text,
      'text_ads': titleController.text,
      'url': urlContr.text,
      'listing_id': hintLinkingId,
      'status': statusSelected.text,
      'image': imageName != null? imageName  : Get.find<StorePostAddesController>().uploadImageOfAdd['name'],
    };
   editDataController.editOffersCategory(json, addedEditPosting);
  }

  @override
  Widget build(BuildContext context) {
    final space10 = SizedBox(height: getSize(10, context));
    return Scaffold(
      appBar: AppBar(
        key: _scaffoldKey,
        backgroundColor: AppColors.appBarBackGroundColor,
        title: Text(postDataEdited == null ? 'addOffer'.tr : 'edit offer'.tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              space10,
              offerTitle(),
              space10,
              GetBuilder<OfferCategoryController>(
                init: OfferCategoryController(),
                builder: (val) {
                  return val.offerDattaTypeCategory != null && val.offerDattaTypeCategory['data'] != null ? addsOffers(val.offerDattaTypeCategory['data'])  : Container();
                },
              ),
              space10,
              offerDesc(),
              space10,
              url(),
              space10,
              GetBuilder<MyAddsAdedController>(
                init: MyAddsAdedController(),
                builder: (val) {
                  return val.addsGet != null && val.addsGet['data'] != null ?linkAdded(val.addsGet['data']) : Container();
                },
              ),
              space10,
              status(),
              space10,
              roundedRectBorderWidget,
              space10,
              submitButton(
                bgcolor: AppColors.appBarBackGroundColor,
                textColor: AppColors.appBarBackGroun,
                buttonText: "publishb".tr,
                callback:postDataEdited == null ? adOffersCreate : editPost,
              ),
              space10,
            ]
          )
        )
      )
    );
  }

  Widget offerTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        maxLength: 20,
        focusNode: FocusNode(),
        controller: titleController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'titleField'.tr;
          }
          return null;
        },
        style: TextStyle(
          color: AppColors.inputTextColor,
          fontSize: 13,
        ),
        decoration: InputDecoration(
          contentPadding: lang == 'en'
          ? EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0)
          : EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
          hintText: "offer title".tr,
          hintStyle: TextStyle(fontSize: 13, color: Colors.grey[700]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget status() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: ButtonTheme(
        alignedDropdown: true,
        child: Container(
          width: Get.width,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: Text(
                statusSelected == null? 'status'.tr:statusSelected == 1 ? 'New':'Old',
                style: TextStyle(
                  fontSize: 13, color: Colors.grey[800]
                )
              ),
              dropdownColor: AppColors.inPutFieldColor,
              icon: Icon(Icons.arrow_drop_down),
              items: <String>['New', 'Old'].map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.grey[800]),
                  )
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  statusSelected = value;
                  value == 'New' ? statusSelected = 1 : statusSelected = 0;
                });
              },
            )
          ),
        )
      )
    );
  }

  Widget url() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CustomTextFiled(
        isObscure: false,
        contentPadding: lang == 'en'
        ? EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0)
        : EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 0.0),
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey[700]),
        hintText: "URL",
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
        textController: urlContr,
        onSaved: (newValue) {},
        validator: (val) {
          String pattern = r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
          RegExp regExp = RegExp(pattern);
          if (val == null || val.isEmpty) {
            return 'urlField'.tr;
          } else if (!regExp.hasMatch(val)) {
            return 'validUrl'.tr;
          }
          return null;
        },
        errorText: '',
      ),
    );
  }

  Widget offerDesc() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          color: AppColors.inPutFieldColor,
          child: TextFormField(
            maxLines: 4,
            textAlignVertical: TextAlignVertical.top,
            focusNode: FocusNode(),
            controller: descriptionController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'fieldReq'.tr;
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: lang == 'en'
              ? EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0)
              : EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 0.0),
              hintText: "Offer description".tr,
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey[700]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget linkAdded(List addedAddMine) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: ButtonTheme(
        alignedDropdown: true,
        child: Container(
          width: Get.width,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: Text(
                hintLinking != null ? hintLinking : 'link to listing add'.tr,
                style: TextStyle(fontSize: 13, color: Colors.grey[700])
              ),
              dropdownColor: AppColors.inPutFieldColor,
              icon: Icon(Icons.arrow_drop_down),
              items: addedAddMine.map((adds) {
                return DropdownMenuItem(
                  value: adds,
                  child: Text(
                    adds['title'][lang] !=null ? adds['title'][lang] :  adds['title'][lang] == null ?  adds['title']['en']:'',
                  )
                );
              }).toList(),
              onChanged: (value) {
                var addsMapByMyAdds;
                setState(() {
                  addsMapByMyAdds = value as Map;
                  hintLinking = addsMapByMyAdds['title'][lang] !=null ? addsMapByMyAdds['title'][lang]  : addsMapByMyAdds['title'][lang] == null ? addsMapByMyAdds['title']['en']:'';
                  hintLinkingId = addsMapByMyAdds['id'];
                });
              },
            )
          ),
        )
      ) 
    );
  }

  Widget addsOffers(List dataListedCateOffer) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: ButtonTheme(
        alignedDropdown: true,
        child: Container(
          width: Get.width,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: Text(
                hintTextCate != null ? hintTextCate : 'offer category'.tr,
                style: TextStyle(
                  fontSize: 13, color: Colors.grey[700]
                )
              ),
              dropdownColor: AppColors.inPutFieldColor,
              icon: Icon(Icons.arrow_drop_down),
              items: dataListedCateOffer.map((countee) {
                return DropdownMenuItem(
                  value: countee,
                  child: Text(  
                    countee['category_name'][lang] != null ?  
                    countee['category_name'][lang].toString() : 
                    countee['category_name'][lang] == null ?
                    countee['category_name']['en'].toString():'',
                  )
                );
              }).toList(),
              onChanged: (value) {
                var mappCatrgory;
                setState(() {
                  mappCatrgory = value as Map;
                  hintTextCate = mappCatrgory['category_name'][lang]!=null ?  mappCatrgory['category_name'][lang].toString() : mappCatrgory['category_name'][lang]==null ? mappCatrgory['category_name']['en'].toString():'' ;
                  idCategory = mappCatrgory['id'];
                });
              },
            )
          ),
        )
      )
    );
  }

  Widget get roundedRectBorderWidget {
    return Container(
      padding: EdgeInsets.all(20),
      child: DottedBorder(
        color: AppColors.appBarBackGroundColor,
        strokeWidth: 1,
        dashPattern: [10, 6],
        child: Column(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              color: Colors.grey[100],
              child: GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Center(
                  child: fileName != null
                  ? Image.file( File(image),
                    fit: BoxFit.fitWidth,
                    width: Get.width / 1.1,
                    height: Get.height / 4.7
                  )
                  : edittImage != null? Image.network(
                    edittImage,
                    fit: BoxFit.fill,
                    width: Get.width / 1.1,
                    height: Get.height / 4.7,
                  ): Image.asset(AppImages.addOfferImage,height: 90)
                )
              )
            ),
          ],
        ),
      )
    );
  }

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
