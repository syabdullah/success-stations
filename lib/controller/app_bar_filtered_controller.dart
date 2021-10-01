import 'package:get/get.dart';

class GridListCategory extends GetxController {
  var dataType ;
  @override
  void onInit(){
    super.onInit();
    listingGrid('grid');
  }
  
  listingGrid(value){
    print("printed data of the screen......$value");
    dataType = value;
    update();

  }
}