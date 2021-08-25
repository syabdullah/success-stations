import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/my_adds/listing_types_action.dart';
import 'package:success_stations/action/my_adds/my_add_action.dart';

class MyListingFilterController extends GetxController {
  bool isLoading = false;
  List myMyAdd = [];
  var addsGet, uploadImageOfAdd;
  var listingData;

  @override
  void onInit() {
    isLoading = true;
    listingTypes();
    myMyAdd = [];
    super.onInit();
  }

  listingTypes() async {
    myMyAdd = [];
    isLoading = true;
    await listingTypesAdds().then((value) {
      //addsGet= jsonDecode(value.body);listingData
      listingData = jsonDecode(value.body);
      print("json decode response of offer.......>$listingData");
      for (int c = 0; c < listingData['data'].length; c++) {
        myMyAdd.add(listingData['data'][c]);
        print(".......yai!!!!!!.!!!!!!!!.......${listingData['data'][c]['type']}");
      }
      isLoading = false;
    });
    update();
  }
}
