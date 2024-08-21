import 'package:flutter/material.dart';
import 'package:flutter_task_app/consts/colors.dart';
import 'package:flutter_task_app/controllers/dropdown_controller.dart';
import 'package:flutter_task_app/controllers/progress_controller.dart';
import 'package:flutter_task_app/widgets/widgets.dart';
import 'package:get/get.dart';

import '../consts/dimensions.dart';
import '../controllers/text_values_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController itemsController = TextEditingController();
  TextEditingController itemsInLineController = TextEditingController();

  @override
  var textValuesController = Get.put(TextValuesController());
  var dropDownController = Get.put(DropDownClickController());
  final ProgressController progressController = Get.put(ProgressController());
  List<String> colorsNames=['Green','Blue','Red','Purple'];
  List<Color> colorsList = [Colors.green,Colors.blue,Colors.red,Colors.purple];
  Widget build(BuildContext context) {
    itemsController.addListener(() {
      final text = itemsController.text;
      if (text.isNotEmpty) {
        final items = int.tryParse(text) ?? 1;
        textValuesController.valueController(items);
      }
    });
    itemsInLineController.addListener((){
      final text = itemsInLineController.text;
      if (text.isNotEmpty){
        final items = int.tryParse(text) ?? 1;
        textValuesController.inlineValueController(items);
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: getScreenHeight(context)*0.2,),
              const Center(
                child: StockImage()
              ),
              SizedBox(width: getScreenWidth(context)*0.2,child: ColorsDropDown(dropDownColors: colorsNames)),
              Obx(()=>SizedBox(width: getScreenWidth(context)*0.22,child: SlidingSpeedSelector(color: colorsList[dropDownController.colorIndex.value])),),
              Obx(()=>SizedBox(
                  width: getScreenWidth(context)*0.22,
                  child: ValueTextField(
                    label: 'Total Items',
                    color: colorsList[dropDownController.colorIndex.value],
                    textEditingController: itemsController,))),
              Obx(()=>SizedBox(
                  width: getScreenWidth(context)*0.22,
                  child: ValueTextField(
                    label: 'Items in Line',
                    color: colorsList[dropDownController.colorIndex.value],
                    textEditingController: itemsInLineController,))),
              // Obx(()=> SizedBox(
              //   child: ListView.builder(
              //     scrollDirection: Axis.vertical,
              //     shrinkWrap: true,
              //     itemCount: textValuesController.itemsValue.value,
              //       itemBuilder: (context,index){
              //             return MainProgressIndicator(color: colorsList[dropDownController.colorIndex.value],);
              //       }),
              // )),
              // Obx(() {
              //   return SizedBox(
              //     width: double.infinity,
              //     child: GradientProgressBar(
              //       value: progressController.progress.value,
              //       gradient: LinearGradient(
              //         colors: [greenGradient,blueGradient,redGradient,purpleGradient][dropDownController.colorIndex.value],
              //         begin: Alignment.centerLeft,
              //         end: Alignment.centerRight,
              //       ),
              //       height: 10.0, // Adjust height as needed
              //     ),
              //   );
              // }),
              Obx((){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GradientProgressBars(
                    progress: progressController.progress.value,
                    barsPerLine: textValuesController.inLineValue.value,
                    totalBars: textValuesController.itemsValue.value,
                    gradient: LinearGradient(
                      colors: [greenGradient,blueGradient,redGradient,purpleGradient][dropDownController.colorIndex.value],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    height: 10.0,
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

