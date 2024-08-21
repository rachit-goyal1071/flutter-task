import 'package:flutter_task_app/widgets/widgets.dart';
import 'package:get/get.dart';

class TextValuesController extends GetxController{
  var itemsValue = 1.obs;
  var inLineValue = 1.obs;

  valueController(int items){
    if(items<=30){
      itemsValue.value = items;
    }else{
      TopSnackBar(message: "Only 30 Items Allowed",);
    }
  }

  inlineValueController(int value){
    if(value<=15){
      inLineValue.value = value;
    }else{
      TopSnackBar(message: "Only 15 Items Allowed",);

    }
  }
}