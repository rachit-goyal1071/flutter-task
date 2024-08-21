import 'package:get/get.dart';

class SliderController extends GetxController{
  var sliderIndex = 0.0.obs;

  changeSliderValue(index){
    sliderIndex.value = index;
  }
}