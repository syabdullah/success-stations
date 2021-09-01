import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/offers/offer_category_action.dart';

class OfferCategoryController extends GetxController {
  bool isLoading = false;
  List offeredList = [];
  var offerDattaTypeCategory;
  var iDBasedOffers, editOffers;
  var resultInvalid = false.obs; 

  @override
  void onInit() {
    isLoading = true;
    categoryOfferList();
    super.onInit();
  }

  categoryOfferList() async {
    print("controller call of the Favorite list");
    isLoading = true;
    await offersCategory().then((value) {
      offerDattaTypeCategory = jsonDecode(value.body);
      isLoading = false;
    });
    update();
  }

  categorrOfferByID(id) async {
    print(".....Ctaegory OFFER loadede.....>$id");
    isLoading = true;
    await offersCategoryById(id).then((res) {
    iDBasedOffers = jsonDecode(res.body);
      print(".....Ctaegory OFFER loadede.....>$iDBasedOffers");
    if(res.statusCode == 200 || res.statusCode <400){
      resultInvalid(false);
      isLoading = false;
    }
    else if(iDBasedOffers['success'] == false){
      resultInvalid(true);
      isLoading = false;

    }
    });
    update();
  }

  editCategory(data,id) async {
    isLoading = true;
    await editOffers(data,id).then((res) {
    editOffers = jsonDecode(res.body);
    if(res.statusCode == 200 || res.statusCode <400){
      resultInvalid(false);
      isLoading = false;
    }
    else if(editOffers['success'] == false){
      resultInvalid(true);
      isLoading = false;

    }
    });
    update();
  }
}
