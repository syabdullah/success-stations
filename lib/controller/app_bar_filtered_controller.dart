import 'package:get/get.dart';

class GridListCategory extends GetxController {
  var dataType ;

  listingGrid(value){
    print("printed data of the screen......$value");
    dataType = value;
    update();

  }
}