import 'package:get/get.dart';

class DropDownClickController extends GetxController{
  var colorValue = ''.obs;
  var colorIndex = 0.obs;

  changeDropDownValue(value,int index){
    colorValue.value = value;
    colorIndex.value = index;
  }
}