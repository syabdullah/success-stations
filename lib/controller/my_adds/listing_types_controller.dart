import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/my_adds/listing_types_action.dart';

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
      listingData = jsonDecode(value.body);
      for (int c = 0; c < listingData['data'].length; c++) {
        myMyAdd.add(listingData['data'][c]);
      }
      isLoading = false;
    });
    update();
  }
}
