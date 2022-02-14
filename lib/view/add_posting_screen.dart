import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:success_stations/controller/ad_posting_controller.dart';
import 'package:success_stations/controller/all_add_controller.dart';
import 'package:success_stations/controller/categories_controller.dart';
import 'package:success_stations/controller/std_sign_up_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:success_stations/utils/app_headers.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dio/dio.dart' as dio;
import 'package:url_launcher/url_launcher.dart';

class AddPostingScreen extends StatefulWidget {
  const AddPostingScreen({Key? key}) : super(key: key);

  @override
  _AddPostingScreenState createState() => _AddPostingScreenState();
}

class _AddPostingScreenState extends State<AddPostingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final catogoryController = Get.put(CategoryController());
  final adpostingController = Get.put(AdPostingController());
  int activeStep = 0;
  int upperBound = 3;
  final _formKey = GlobalKey<FormState>();
  List list = [];
  List type = [];
  var selectedtype;
  List<String> itemsList = [
    "New".tr,
    "used".tr,
  ];

  List<String> ImagesAdds = [
    "https://images.unsplash.com/photo-1643672206356-917a174844b2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1621609764095-b32bbe35cf3a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1491183846256-33aec7637311?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
  ];
  onSelected(int index) {
    slctedInd = index;
    slctedInd == 0
        ? selectedStatus = '1'
        : selectedStatus = '0';
  }
  PhoneNumber tttt = PhoneNumber(isoCode: '');
  var number;
  int slctedInd = 0;
  var statusFiltered, status;
  var selectedCategory, subtypeId, selectedStatus, uiStatus;
  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController telePhoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var json;
  GetStorage box = GetStorage();
  final ImagePicker _picker = ImagePicker();
  final con = Get.put(AdPostingController());

  // Pick an image
  XFile? pickedFile;
  late String image;
  var editImage;
  var fileName;
  var id,
      cid,
      rid,
      crid,
      adID,
      selectedRegion,
      hintRegionText,
      uploadedImage,
      hintcityText,
      selectedCity;
  var lang;
  var editData, hintTextCountry, selectedCountry;
  final countryPut = Get.put(ContryController());
  var imageName;
  var typeId;

  @override
  void initState() {
    super.initState();
    id = box.read('user_id');
    lang = box.read('lang_code');
    editData = Get.arguments;
    if (editData != null) {
      adID = editData['id'];
      titleController = TextEditingController(text: editData['title'][lang]);
      selectedStatus = editData['status'];
      descController =
          TextEditingController(text: editData['description'][lang]);
      editImage =
          editData['image'].length != 0 ? editData['image'][0]['url'] : null;
      imageName = editData['image'].length != 0
          ? editData['image'][0]['file_name']
          : null;
      priceController = TextEditingController(text: editData['price']);
      fullNameController =
          TextEditingController(text: editData['contact_name']);
      selectedCategory = editData['category'] != null
          ? editData['category']['category'][lang]
          : '';
      subtypeId = editData['category_id'];
      typeId = editData['type_id'];
      selectedtype = editData['type'] == null
          ? 'Select Type'
          : editData['type']['type'][lang];
      emailController = TextEditingController(text: editData['contact_email']);
      telePhoneController = TextEditingController(text: editData['telephone']);
      mobileNoController = TextEditingController(text: editData['phone']);
      selectedCountry = editData['country_id'];
      if (editData['country'] != null) {
        if (editData['country']['name'] != null) {
          hintTextCountry = editData['country']['name'][lang] != null
              ? editData['country']['name'][lang]
              : editData['country']['name'][lang] == null
                  ? editData['country']['name']['en']
                  : '';
        } else {
          hintTextCountry = "country".tr;
        }
      }
      if (editData['region'] != null) {
        hintRegionText =
            editData['region'] != null ? editData['region'][lang] : '';
      } else {
        hintRegionText = 'region'.tr;
      }
      if (editData['city'] != null) {
        hintcityText = editData['city'] != null ? editData['city'][lang] : '';
      } else {
        hintcityText = 'city'.tr;
      }
      // hintcityText = editData['city'] !=null ? editData['city']['city'] :'';
      selectedRegion = editData['region_id'];
      selectedCity = editData['city_id'];
    }
    catogoryController.getCategoryNames();
    catogoryController.getCategoryTypes();
  }

  Future getImage() async {
    await ApiHeaders().getData();
    pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = pickedFile!.path;
        fileName = pickedFile!.path.split('/').last;
      } else {}
    });
    try {
      imageName = null;
      dio.FormData formData = dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(pickedFile!.path,
            filename: fileName),
      });
      Get.find<AdPostingController>().uploadAdImage(formData);
      uploadedImage = Get.find<AdPostingController>().adUpload['name'];
    } catch (e) {}
  }

  adpost() async {
    var json = {
      'category_id': subtypeId,
      'status': selectedStatus,
      'description': descController.text,
      'price': priceController.text,
      'contact_name': fullNameController.text,
      'phone': mobileNoController.text,
      'telephone': telePhoneController.text,
      'title': titleController.text,
      'created_by': id.toString(),
      'contact_email': emailController.text,
      'country_id': selectedCountry,
      'region_id': selectedRegion,
      'city_id': selectedCity,
      'is_active': 1,
      'type_id': typeId,
      'is_published': 1,
      "image": imageName != null
          ? imageName
          : Get.find<AdPostingController>().adUpload['name'],
    };
    Get.find<AdPostingController>().finalAdPosting(json);
  }

  editpost() async {
    var json = {
      'category_id': subtypeId,
      'status': selectedStatus,
      'description': descController.text,
      'price': priceController.text,
      'contact_name': fullNameController.text,
      'phone': mobileNoController.text,
      'telephone': telePhoneController.text,
      'title': titleController.text,
      // 'created_by': id.toString(),
      'email': emailController.text,
      'country_id': selectedCountry,
      'region_id': selectedRegion,
      'city_id': selectedCity,
      'is_active': 1,
      'type_id': typeId,
      'is_published': 1,
      "image": imageName != null
          ? imageName
          : Get.find<AdPostingController>().adUpload['name'],
    };
    Get.find<AdPostingController>().finalAdEditing(json, adID);
  }

  addraft() async {
    if (pickedFile != null) {
      try {
        dio.FormData formData = dio.FormData.fromMap({
          'category_id': subtypeId,
          'type_id': typeId,
          'status': selectedStatus,
          'description': descController.text,
          'price': priceController.text,
          'contact_name': fullNameController.text,
          'phone': mobileNoController.text,
          'telephone': telePhoneController.text,
          'title': titleController.text,
          'created_by': id.toString(),
          'email': emailController.text,
          'country_id': selectedCountry,
          'region_id': selectedRegion,
          'city_id': selectedCity,
          'is_published': 0,
          "image": Get.find<AdPostingController>().adUpload['name'],
        });
        Get.find<AdPostingController>().finalAdDrafting(formData);
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
          leading: GestureDetector(
              child: Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(AppImages.imagearrow1,
                      color: Colors.black, height: 22),
                ),
              ),
            ],
          )),
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Image.asset(AppImages.appBarLogo, height: 35),
          backgroundColor: Colors.white),
      body: ListView(
        children: [
          ImageStepper(
            stepColor: Colors.yellow,
            lineDotRadius: 0.1,
            lineColor: Colors.grey,
            activeStepColor: AppColors.whitedColor,
            activeStepBorderColor: Colors.grey[700],
            lineLength: 75,
            enableNextPreviousButtons: false,
            images: [
              activeStep == 0
                  ? AssetImage(AppImages.sistStepIcon)
                  : AssetImage(AppImages.istStepIcon),
              activeStep == 1
                  ? AssetImage(AppImages.ssecStepIcon)
                  : AssetImage(AppImages.secStepIcon),
              activeStep == 2
                  ? AssetImage(AppImages.strdStepIcon)
                  : AssetImage(AppImages.trdStepIcon),
            ],
            activeStep: activeStep,
            onStepReached: (index) {
              setState(() {
                activeStep = index;
              });
            },
          ),
          header(),
          GetBuilder<CategoryController>(
              init: CategoryController(),
              builder: (val) {
                return activeStep == 0
                    ? istStep(val.subCat['data'], val.datacategTypes)
                    : activeStep == 1
                        ? secondStep()
                        : activeStep == 2
                            ? thirdStep()
                            : Container();
              }),
          activeStep == 0
              ? Padding(
                padding:  EdgeInsets.symmetric(vertical: Get.width*0.03, ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      saveAsDraftButton(),
                      SizedBox(
                        width: Get.width*0.03,
                      ),
                      nextButton(),
                    ],
                  ),
              )
              : activeStep == 1
                  ? Padding(
            padding:  EdgeInsets.symmetric(vertical: Get.width*0.03, ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                saveAsDraftButton(),
                SizedBox(
                  width: Get.width*0.03,
                ),
                nextButton(),
              ],
            ),
          )

                  : Padding(
            padding:  EdgeInsets.symmetric(vertical: Get.width*0.03, ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                saveAsDraftButton(),
                SizedBox(
                  width: Get.width*0.03,
                ),
                publishButton(),
              ],
            ),
          )
        ],
      ),
    );
  }


  Widget previousButton2(image, text, Color color, data) {
    return InkWell(
      onTap: () {
        if (image == AppImages.heart) {
          Get.toNamed('/favourities');
        } else {
          launch("tel:${data['phone']}");
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.whitedColor),
          color: Colors.white,
        ),
        height: Get.height * 0.045,
        // width: 100.w,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(image, width: Get.width * 0.08),
              SizedBox(
                width: Get.width * 0.01,
              ),
              Text(
                text,
              ),
            ],
          ),
        ),
      ),
    );
  }
  /// Returns the next button.
  Widget nextButton() {
    return Container(
      height: 45,
      width: 130,
      // margin: EdgeInsets.symmetric(horizontal: 15),
      child:
      ElevatedButton(
        style: ElevatedButton.styleFrom(primary: AppColors.whitedColor,shape:  RoundedRectangleBorder(
    borderRadius:  BorderRadius.circular(0.0),)),
        onPressed: () {
          // Increment activeStep, when the next button is tapped. However, check for upper bound.
          if (activeStep < upperBound && _formKey.currentState!.validate()) {
            setState(() {
              activeStep++;
            });
          }
        },
        child: Text('next'.tr),
      ),
    );
  }



  /// Returns the previous button.
  Widget previousButton(String whatsapp, String tr, Color color, String s) {
    return Container(
      height: 45,
      width: 130,
      // margin: EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary:Color(0xff404040),
            shape:  RoundedRectangleBorder(
              borderRadius:  BorderRadius.circular(0.0),),
            textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        onPressed: () {
          if (activeStep > 0) {
            setState(() {
              activeStep--;
            });
          }
        },
        child: Text('previousb'.tr),
      ),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          activeStep == 0
              ? Text("announce_new".tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.appTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whitedColor))
              : Text("announce_new".tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.appTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
          activeStep == 1
              ? Text("contact_information".tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.appTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whitedColor))
              : Text("contact_information".tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.appTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
          activeStep == 2
              ? Text("review_publish".tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.appTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whitedColor))
              : Text("review_publish".tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.appTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
        ],
      ),
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

  Widget istStep(List list, List types) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width:Get.width/2.15,
                          // margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: AppColors.border_form, width: 1),
                          ),
                          child: ButtonTheme(
                              alignedDropdown: true,
                              child: Container(
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      isExpanded: true,
                                  hint: Text(
                                      selectedCategory != null
                                          ? selectedCategory
                                          : "categories".tr,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: AppColors.inputTextColor)),
                                  // dropdownColor: AppColors.inPutFieldColor,
                                  // icon: Icon(Icons.arrow_drop_down),
                                  items: types.map((coun) {
                                    return DropdownMenuItem(
                                        alignment: Alignment.center,
                                        value: coun,
                                        child: Text(coun['category'][lang] != null
                                            ? coun['category'][lang]
                                            : coun['category'][lang] == null
                                                ? coun['category']['en']
                                                : ''));
                                  }).toList(),
                                  onChanged: (val) {
                                    var adCategory;
                                    setState(() {
                                      adCategory = val as Map;
                                      selectedCategory =
                                          adCategory['category'][lang] != null
                                              ? adCategory['category'][lang]
                                              : adCategory['category'][lang] == null
                                                  ? adCategory['category']['en']
                                                  : '';
                                      subtypeId = adCategory['id'];
                                      type = adCategory['category_listing_types'];
                                      selectedtype = 'type'.tr;
                                    });
                                  },
                                )),
                              ))),
                      Container(
                          width:Get.width/2.15,
                          // margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                            Border.all(color: AppColors.border_form, width: 1),
                          ),
                          child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButtonHideUnderline(
                                  child: Container(
                                    child: DropdownButton(
                                      hint: Text(
                                          selectedtype != null ? selectedtype : 'type'.tr,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.inputTextColor)),
                                      dropdownColor: AppColors.inPutFieldColor,
                                      icon: Icon(Icons.arrow_drop_down),
                                      items: type.map((coun) {
                                        return DropdownMenuItem(
                                            value: coun,
                                            child: Text(coun['type'][lang] != null
                                                ? coun['type'][lang].toString()
                                                : coun['type'][lang] == null
                                                ? coun['type']['en'].toString()
                                                : ''));
                                      }).toList(),
                                      onChanged: (val) {
                                        var adsubCategory;
                                        setState(() {
                                          adsubCategory = val as Map;
                                          selectedtype =
                                          adsubCategory['type'][lang] != null
                                              ? adsubCategory['type'][lang]
                                              : adsubCategory['type'][lang] == null
                                              ? adsubCategory['type']['en']
                                              : '';
                                          typeId = adsubCategory['id'];
                                        });
                                      },
                                    ),
                                  )))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),


                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    maxLength: 20,
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: AppColors.inputTextColor,
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                      counterText: "",
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 00.0, 10.0, 0),
                      hintText: "title".tr,
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: AppColors.border_form),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: AppColors.border_form),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: AppColors.border_form),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: AppColors.border_form),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  color: AppColors.inPutFieldColor,
                  child: TextFormField(
                    maxLength: 300,
                    maxLines: 2,
                    controller: descController,
                    textAlignVertical: TextAlignVertical.top,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 18,
                       ),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      counterText: "",
                      contentPadding:
                          EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 100.0),
                      hintText: "description".tr,
                      hintStyle:
                          TextStyle(fontSize: 14, color: Colors.grey[400]),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: AppColors.border_form),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: AppColors.border_form),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: AppColors.border_form),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: AppColors.border_form),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
               /* Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: AppColors.border_form, width: 1),
                    ),
                    child: ButtonTheme(
                        alignedDropdown: true,
                        child: Container(
                          width: Get.width,
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                            hint: Text(
                                selectedStatus == null
                                    ? 'status'.tr
                                    : selectedStatus == '1'
                                        ? 'New'
                                        : 'Old',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.inputTextColor)),
                            dropdownColor: AppColors.inPutFieldColor,
                            icon: Icon(Icons.arrow_drop_down),
                            items: <String>['New', 'Old'].map((String value) {
                              return DropdownMenuItem(
                                  value: value, child: Text(value));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedStatus = value;
                                value == 'New'.tr
                                    ? selectedStatus = '1'
                                    : selectedStatus = '0';
                              });
                            },
                          )),
                        ))),*/
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left:Get.width*0.01),
                        child: Container(
                          width: Get.width /2.2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppColors.border_form)),
                          child: Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    // maxLength: 5,
                                    keyboardType: TextInputType.number,
                                    controller: priceController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        color: AppColors.inputTextColor,
                                        fontSize: 18,
                                      ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.white,
                                      contentPadding: EdgeInsets.only(
                                          left: 15, right: 10, top: 15),
                                      hintText: "price".tr,
                                      hintStyle: TextStyle(
                                          fontSize: 14, color: Colors.grey[400]),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0.0),
                                        borderSide:
                                            BorderSide(color: Colors.transparent),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0.0),
                                        borderSide:
                                            BorderSide(color: Colors.transparent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0.0),
                                        borderSide:
                                            BorderSide(color: Colors.transparent),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0.0),
                                        borderSide:
                                            BorderSide(color: Colors.transparent),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                        border: Border(
                                          left: BorderSide(color: AppColors.border_form),
                                          right: BorderSide(color: AppColors.border_form),
                                        ),),
                                      child: ButtonTheme(
                                          alignedDropdown: true,
                                          child: Container(
                                            child: DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                              hint: Text(
                                                  selectedStatus == null
                                                      ? 'SAR'.tr
                                                      : selectedStatus == '1'
                                                          ? 'SAR'
                                                          : 'SAR',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: AppColors
                                                          .inputTextColor)),
                                              dropdownColor:
                                                  AppColors.inPutFieldColor,
                                              icon: Icon(Icons.arrow_drop_down),
                                              items: <String>['SAR', 'SAR']
                                                  .map((String value) {
                                                return DropdownMenuItem(
                                                    value: value,
                                                    child: Text(value));
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedStatus = value;
                                                  value == 'New'.tr
                                                      ? selectedStatus = '1'
                                                      : selectedStatus = '0';
                                                });
                                              },
                                            )),
                                          )),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                           ),
                        height: Get.height * 0.045,
                        width: Get.width/2.2,

                        child: Center(
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: itemsList.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      onSelected(index);
                                      status = itemsList[index];
                                    });
                                  },
                                  child: Container(
                                    margin: lang == 'en'
                                        ? EdgeInsets.only(left: 5)
                                        : EdgeInsets.only(right: 5),
                                    width: Get.width / 5,
                                    height: Get.height / 3,
                                    decoration: BoxDecoration(
                                      // ignore: unnecessary_null_comparison
                                      color: Colors.white,
                                      //Colors.blue[100],
                                      border: Border.all(
                                        color:  slctedInd != null && slctedInd == index
                                            ? AppColors.appBarBackGroundColor
                                            : AppColors.border,
                                        width:slctedInd != null && slctedInd == index
                                            ? 2
                                            : 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text(itemsList[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color:index==0?
                                                   AppColors.new_color
                                                  : AppColors.border,
                                            )),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: DottedBorder(
                    dashPattern: [10, 6],
                    borderType: BorderType.RRect,
                    radius: Radius.circular(12),
                    padding: EdgeInsets.all(6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        height: Get.height / 3.5,
                        width: Get.width / 1.1,
                        child: Center(
                          child: GestureDetector(
                              onTap: () {
                                getImage();
                              },
                              child: fileName != null
                                  ? Image.file(
                                      File(image),
                                      fit: BoxFit.fitWidth,
                                      width: Get.width / 1.1,
                                      height: Get.height / 3.5,
                                    )
                                  : editImage != null
                                      ? Image.network(
                                          editImage,
                                          fit: BoxFit.fill,
                                          width: Get.width / 1.1,
                                          height: Get.height / 3.5,
                                        )
                                      : Image.asset(
                                          AppImages.uploadImage,
                                          height: 90,
                                        )),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget secondStep() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              focusNode: FocusNode(),
              controller: fullNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'enterSomeText'.tr;
                }
                return null;
              },
              style: TextStyle(
                color: AppColors.inputTextColor,
                fontSize: 13,
              ),
              decoration: InputDecoration(
                counterText: "",
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(20.0, 00.0, 10.0, 0),
                hintText: "full_name".tr,
                hintStyle: TextStyle(color: Colors.grey[400]),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  borderSide: BorderSide(color: AppColors.border_form),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  borderSide: BorderSide(color: AppColors.border_form),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  borderSide: BorderSide(color: AppColors.border_form),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  borderSide: BorderSide(color: AppColors.border_form),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              focusNode: FocusNode(),
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'enterSomeTextEmail'.tr;
                }
                return null;
              },
              style: TextStyle(
                color: AppColors.inputTextColor,
                fontSize: 13,
              ),
                decoration: InputDecoration(
                  counterText: "",
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 00.0, 10.0, 0),
                  hintText: "emails".tr,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    borderSide: BorderSide(color: AppColors.border_form),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    borderSide: BorderSide(color: AppColors.border_form),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    borderSide: BorderSide(color: AppColors.border_form),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    borderSide: BorderSide(color: AppColors.border_form),
                  ),
                ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 10),

            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
                border: Border.all(color: AppColors.border_form)),

            child: Padding(
              padding: const EdgeInsets.only(left: 5,),
              child: InternationalPhoneNumberInput(
                focusNode: FocusNode(),
                cursorColor: AppColors.whitedColor,
                autoFocus: false,
                inputDecoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width/19, bottom: 10),
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  // hintText: "mobilee".tr,
                  // hintStyle: TextStyle(
                  //     fontSize: lang == 'ar' ? 14 : 16,
                  //     color: AppColors.inputTextColor),
                ),
                onInputChanged: (PhoneNumber numberr) {
                  number = numberr;
                },
                onInputValidated: (bool value) {},
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                selectorTextStyle: TextStyle(color: Colors.black),
                textFieldController: mobileNoController,
                formatInput: true,
                inputBorder: OutlineInputBorder(),
                onSaved: (PhoneNumber number) {},
                initialValue: tttt,
              ),
            )),

          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   child: TextFormField(
          //     focusNode: FocusNode(),
          //     controller: mobileNoController,
          //     validator: (value) {
          //       if (value == null || value.isEmpty) {
          //         return 'enterSomeText'.tr;
          //       }
          //       return null;
          //     },
          //     style: TextStyle(
          //       color: AppColors.inputTextColor,
          //       fontSize: 13,
          //     ),
          //     decoration: InputDecoration(
          //       counterText: "",
          //       fillColor: Colors.white,
          //       filled: true,
          //       contentPadding: EdgeInsets.fromLTRB(20.0, 00.0, 10.0, 0),
          //       hintText: "mobile_number".tr,
          //       hintStyle: TextStyle(color: Colors.grey[400]),
          //       disabledBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(0.0),
          //         borderSide: BorderSide(color: AppColors.border_form),
          //       ),
          //       enabledBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(0.0),
          //         borderSide: BorderSide(color: AppColors.border_form),
          //       ),
          //       focusedBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(0.0),
          //         borderSide: BorderSide(color: AppColors.border_form),
          //       ),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(0.0),
          //         borderSide: BorderSide(color: AppColors.border_form),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 5,
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 15),
          //   child: TextFormField(
          //     focusNode: FocusNode(),
          //     controller: telePhoneController,
          //     validator: (value) {
          //       if (value == null || value.isEmpty) {
          //         return 'enterSomeText'.tr;
          //       }
          //       return null;
          //     },
          //     style: TextStyle(
          //       color: AppColors.inputTextColor,
          //       fontSize: 13,
          //     ),
          //     decoration: InputDecoration(
          //       contentPadding: EdgeInsets.fromLTRB(20.0, 00.0, 10.0, 0),
          //       hintText: "telephone_numbers".tr,
          //       hintStyle: TextStyle(color: Colors.grey[400]),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(5.0),
          //         borderSide: BorderSide(color: Colors.grey),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 5,
          // ),


          // SizedBox(
          //   height: 8,
          // ),
          // GetBuilder<ContryController>(
          //     init: ContryController(),
          //     builder: (val) {
          //       return Container(
          //           margin: EdgeInsets.only(left: 15, right: 13),
          //           width: Get.width / 0.30,
          //           decoration: BoxDecoration(
          //               color: AppColors.inputColor,
          //               border: Border.all(color: Colors.grey),
          //               borderRadius: BorderRadius.circular(5.0)),
          //           child: ButtonTheme(
          //               alignedDropdown: true,
          //               child: DropdownButtonHideUnderline(
          //                   child: DropdownButton(
          //                 hint: Text(
          //                     hintTextCountry != null
          //                         ? hintTextCountry
          //                         : 'country'.tr,
          //                     style: TextStyle(
          //                         fontSize: 13,
          //                         color: AppColors.inputTextColor)),
          //                 dropdownColor: AppColors.inPutFieldColor,
          //                 icon: Icon(Icons.arrow_drop_down),
          //                 items: val.countryListdata.map((country) {
          //                   return DropdownMenuItem(
          //                       value: country,
          //                       child: Text(
          //                         country['name'][lang] != null
          //                             ? country['name'][lang]
          //                             : country['name'][lang] == null
          //                                 ? country['name']['en']
          //                                 : '',
          //                       ));
          //                 }).toList(),
          //                 onChanged: (val) {
          //                   var mapCountry;
          //                   setState(() {
          //                     mapCountry = val as Map;
          //                     hintTextCountry = mapCountry['name'][lang] != null
          //                         ? mapCountry['name'][lang]
          //                         : mapCountry['name'][lang] == null
          //                             ? mapCountry['name']['en']
          //                             : '';
          //                     selectedCountry = mapCountry['id'];
          //                     countryPut.getRegion(selectedCountry);
          //                   });
          //                 },
          //               ))));
          //     }),
          // SizedBox(
          //   height: 8,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<ContryController>(
                  init: ContryController(),
                  builder: (val) {
                    return Container(
                        margin:lang=="ar"? EdgeInsets.only(right: 10,): EdgeInsets.only(left: 10,),
                        width: Get.width/2.2,
                        decoration: BoxDecoration(
                            color: AppColors.white,

                            border: Border.all(color: AppColors.border_form),
                            borderRadius: BorderRadius.circular(0.0)),
                        child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                              hint: Text(
                                  hintRegionText != null
                                      ? hintRegionText
                                      : "region".tr,
                                  style:
                                      TextStyle(fontSize: 13, color: Colors.grey)),
                              dropdownColor: AppColors.inPutFieldColor,
                              icon: Icon(Icons.arrow_drop_down),
                              items: val.regionListdata.map((reg) {
                                return DropdownMenuItem(
                                    value: reg,
                                    child: Text(reg['region'][lang] != null
                                        ? reg['region'][lang]
                                        : reg['region']['en'] == null
                                            ? reg['region']['ar']
                                            : reg['region']['ar'] == null
                                                ? reg['region']['en']
                                                : ''));
                              }).toList(),
                              onChanged: (data) {
                                var mapRegion;
                                setState(() {
                                  mapRegion = data as Map;
                                  print("map region.....$mapRegion");
                                  hintRegionText = mapRegion['region'][lang] != null
                                      ? mapRegion['region'][lang].toString()
                                      : mapRegion['region'][lang] == null
                                          ? mapRegion['region']['en'].toString()
                                          : '';
                                  selectedRegion = mapRegion['id'];
                                  countryPut.getCity(selectedRegion);
                                });
                              },
                            ))));
                  }),
              GetBuilder<ContryController>(
                  init: ContryController(),
                  builder: (val) {
                    return Container(
                        margin:lang=="ar"? EdgeInsets.only(left: 10,): EdgeInsets.only(right: 10,),
                        width: Get.width /2.2,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(color:AppColors.border_form),
                            borderRadius: BorderRadius.circular(0.0)),
                        child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text(
                                      hintcityText != null ? hintcityText : "city".tr,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.inputTextColor)),
                                  dropdownColor: AppColors.inputColor,
                                  icon: Icon(Icons.arrow_drop_down),
                                  items: val.cityListData.map((citt) {
                                    return DropdownMenuItem(
                                        value: citt,
                                        child: Text(citt['city'][lang] != null
                                            ? citt['city'][lang].toString()
                                            : citt['city']['en'] == null
                                            ? citt['city']['ar'].toString()
                                            : citt['city']['ar'] == null
                                            ? citt['city']['en'].toString()
                                            : ''));
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      var mapCity;
                                      mapCity = value as Map;
                                      hintcityText = mapCity['city'][lang] != null
                                          ? mapCity['city'][lang].toString()
                                          : mapCity['city'][lang] == null
                                          ? mapCity['city']['en'].toString()
                                          : '';
                                      selectedCity = mapCity['id'];
                                    });
                                  },
                                ))));
                  }),


            ],
          ),
          SizedBox(
            height: Get.height/4,
          ),

        ],
      ),
    );
  }

  Widget thirdStep() {
    return Column(
      children: [
        fileName != null
            ?Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                width: Get.width / 1.0,
                height: Get.height * 0.45,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.outline)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 8.0),
                  child: Image.file(File(image),
                      width: Get.width / 1.0,
                      height: Get.height * 0.40,
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 5,
              left: 5,
              child: Center(
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.10,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey),
                      color: Colors.black.withOpacity(0.3)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 3),
                    child: Row(
                      children: [
                        Container(
                            height: Get.height * 0.90,
                            width: Get.width * 0.20,
                            child: Image.network(ImagesAdds[0],
                                height: Get.height * 0.20,
                                fit: BoxFit.fill)),
                        SizedBox(width: Get.width * 0.01),
                        Container(
                            height: Get.height * 0.90,
                            width: Get.width * 0.20,
                            child: Image.network(ImagesAdds[1],
                                height: Get.height * 0.20,
                                fit: BoxFit.fill)),
                        SizedBox(width: Get.width * 0.01),
                        Container(
                            height: Get.height * 0.90,
                            width: Get.width * 0.20,
                            child: Image.network(ImagesAdds[2],
                                height: Get.height * 0.20,
                                fit: BoxFit.fill))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )
            : editImage != null
                ? Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                width: Get.width / 1.0,
                height: Get.height * 0.45,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.outline)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 8.0),
                  child: Image.network(editImage,
                      width: Get.width / 1.0,
                      height: Get.height * 0.40,
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 5,
              left: 5,
              child: Center(
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.10,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey),
                      color: Colors.black.withOpacity(0.3)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 3),
                    child: Row(
                      children: [
                        Container(
                            height: Get.height * 0.90,
                            width: Get.width * 0.20,
                            child: Image.network(ImagesAdds[0],
                                height: Get.height * 0.20,
                                fit: BoxFit.fill)),
                        SizedBox(width: Get.width * 0.01),
                        Container(
                            height: Get.height * 0.90,
                            width: Get.width * 0.20,
                            child: Image.network(ImagesAdds[1],
                                height: Get.height * 0.20,
                                fit: BoxFit.fill)),
                        SizedBox(width: Get.width * 0.01),
                        Container(
                            height: Get.height * 0.90,
                            width: Get.width * 0.20,
                            child: Image.network(ImagesAdds[2],
                                height: Get.height * 0.20,
                                fit: BoxFit.fill))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )
                : Container(),
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Container(
                  height: Get.height * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "title".tr +" :",
                          style: TextStyle(
                            color: AppColors.whitedColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          titleController.text,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
                width: Get.width
              ),
              Container(
    width: Get.width,
    decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.grey)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 8),
                        child: Text(
                          "description".tr+ " :",
                          style: TextStyle(
                            color: AppColors.whitedColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5),
                        child: Expanded(
                          child: Text(
                           descController.text,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.46,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black26)),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "category".tr +" :",
                            style: TextStyle(
                              color: AppColors.whitedColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Expanded(
                            child: Text(
                              selectedCategory != null ? selectedCategory : '',
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.46,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black26)),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "type".tr+" :",
                            style: TextStyle(
                              color: AppColors.whitedColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Expanded(
                            child: Text(
    selectedtype != null ? selectedtype : '',
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.46,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black26)),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "locationTab".tr +" :",
                            style: TextStyle(
                              color: AppColors.whitedColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Expanded(
                            child: Text(
    hintTextCountry != null ? hintTextCountry : '',
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.46,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black26)),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "phone".tr + " :",
                            style: TextStyle(
                              color: AppColors.whitedColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Expanded(
                            child: Text(
                              mobileNoController.text,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.46,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black26)),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "price".tr+ " :",
                            style: TextStyle(
                              color: AppColors.whitedColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Expanded(
                            child: Text(
                              priceController.text,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.46,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black26)),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "status".tr + " :",
                            style: TextStyle(
                              color: AppColors.whitedColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Expanded(
                            child: Text(
    selectedStatus == '0'
    ? uiStatus = 'used'.tr
        : selectedStatus == '1'
    ? 'New'.tr
        : ' ' ,
                              maxLines: 2,
                              style: TextStyle(
                                color: selectedStatus == '0'?  Colors.grey:Colors.lightGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),


            ],
          ),
        ),
        // Card(
        //   child: Column(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
        //         child: Container(
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text(
        //                 titleController.text,
        //                 style: TextStyle(
        //                     fontSize: 20, fontWeight: FontWeight.bold),
        //               ),
        //               Text(
        //                 "SAR ${priceController.text}",
        //                 style: TextStyle(
        //                     fontSize: 15,
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.grey),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       Container(
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
        //           children: [
        //             Container(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   SizedBox(
        //                     height: 15,
        //                   ),
        //                   Text(
        //                     'title'.tr,
        //                     style: TextStyle(
        //                         fontSize: 15,
        //                         fontWeight: FontWeight.bold,
        //                         color: Colors.grey),
        //                   ),
        //                   SizedBox(height: 7),
        //                   Text(titleController.text,
        //                       style: TextStyle(
        //                           fontSize: 15, fontWeight: FontWeight.bold)),
        //                   SizedBox(
        //                     height: 15,
        //                   ),
        //                   Text(
        //                     "category".tr,
        //                     style: TextStyle(
        //                         fontSize: 15,
        //                         fontWeight: FontWeight.bold,
        //                         color: Colors.grey),
        //                   ),
        //                   SizedBox(height: 7),
        //                   Text(
        //                     selectedCategory != null ? selectedCategory : '',
        //                     style: TextStyle(
        //                         fontSize: 15, fontWeight: FontWeight.bold),
        //                   ),
        //                   SizedBox(
        //                     height: 15,
        //                   ),
        //                   Text(
        //                     "country".tr,
        //                     style: TextStyle(
        //                         fontSize: 15,
        //                         fontWeight: FontWeight.bold,
        //                         color: Colors.grey),
        //                   ),
        //                   SizedBox(height: 7),
        //                   Text(
        //                     hintTextCountry != null ? hintTextCountry : '',
        //                     style: TextStyle(
        //                         fontSize: 15, fontWeight: FontWeight.bold),
        //                   ),
        //                   SizedBox(
        //                     height: 15,
        //                   ),
        //                   Text(
        //                     "city".tr,
        //                     style: TextStyle(
        //                         fontSize: 15,
        //                         fontWeight: FontWeight.bold,
        //                         color: Colors.grey),
        //                   ),
        //                   SizedBox(height: 7),
        //                   Text(
        //                     hintcityText != null ? hintcityText : '',
        //                     style: TextStyle(
        //                         fontSize: 15, fontWeight: FontWeight.bold),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Container(
        //               child: Container(
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     SizedBox(
        //                       height: 1,
        //                     ),
        //                     Text(
        //                       "name".tr,
        //                       style: TextStyle(
        //                           fontSize: 15,
        //                           fontWeight: FontWeight.bold,
        //                           color: Colors.grey),
        //                     ),
        //                     SizedBox(height: 5),
        //                     Text(
        //                       fullNameController.text,
        //                       style: TextStyle(
        //                           fontSize: 15, fontWeight: FontWeight.bold),
        //                     ),
        //                     SizedBox(height: 15),
        //                     Text(
        //                       'status'.tr,
        //                       style: TextStyle(
        //                           fontSize: 15,
        //                           fontWeight: FontWeight.bold,
        //                           color: Colors.grey),
        //                     ),
        //                     SizedBox(height: 7),
        //                     Text(
        //                       selectedStatus == '0'
        //                           ? uiStatus = 'Used'
        //                           : selectedStatus == '1'
        //                               ? 'new'
        //                               : ' ',
        //                       style: TextStyle(
        //                           fontSize: 15, fontWeight: FontWeight.bold),
        //                     ),
        //                     SizedBox(height: 15),
        //                     Text(
        //                       "region".tr,
        //                       style: TextStyle(
        //                           fontSize: 15,
        //                           fontWeight: FontWeight.bold,
        //                           color: Colors.grey),
        //                     ),
        //                     SizedBox(height: 5),
        //                     Text(hintRegionText != null ? hintRegionText : '',
        //                         style: TextStyle(
        //                             fontSize: 15, fontWeight: FontWeight.bold)),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        // Container(
        //   width: Get.width,
        //   child: Card(
        //     child: Padding(
        //       padding: const EdgeInsets.only(top: 15, left: 50, right: 50),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             "${"details".tr}:",
        //             style: TextStyle(
        //                 fontSize: 15,
        //                 fontWeight: FontWeight.bold,
        //                 color: Colors.grey),
        //           ),
        //           SizedBox(height: 5),
        //           Text(
        //             descController.text,
        //             textAlign: TextAlign.justify,
        //             style: TextStyle(
        //                 fontSize: 15,
        //                 fontWeight: FontWeight.bold,
        //                 color: Colors.black),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget publishButton() {
    return Container(
      height: 45,
      width: 130,
      // margin: EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary:AppColors.whitedColor,
            shape:  RoundedRectangleBorder(
              borderRadius:  BorderRadius.circular(0.0),),
            textStyle: TextStyle(fontSize: 13,)),
        onPressed: () {
          editData == null ? adpost() : editpost();
        },
        child: Text("publishb".tr),
      ),
    );
  }

  Widget saveAsDraftButton() {
    return Container(
      height: 45,
      width: 130,
      // margin: EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color(0xff404040),
          shape:  RoundedRectangleBorder(
            borderRadius:  BorderRadius.circular(0.0),),
            textStyle: TextStyle(fontSize: 13,)),
        onPressed: () {
          addraft();
        },
        child: Text(
          "save_as_draft".tr,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
