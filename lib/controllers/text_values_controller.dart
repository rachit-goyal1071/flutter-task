import 'package:flutter/material.dart';
import 'package:flutter_task_app/widgets/widgets.dart';
import 'package:get/get.dart';

class TextValuesController extends GetxController{
  var itemsValue = 1.obs;
  var inLineValue = 1.obs;

  valueController(int items,BuildContext context){
    if(items<=30){
      itemsValue.value = items;
    }else{
      TopSnackBar.show(context, "Only 30 Items Allowed");
    }
  }

  inlineValueController(int value,BuildContext context){
    if(value<=15 && value>0){
      inLineValue.value = value;
    }else if(value==0){
      TopSnackBar.show(context, "Minimum Value 1");
    }else{
      TopSnackBar.show(context, "Only 15 Items Allowed");
    }
  }
}