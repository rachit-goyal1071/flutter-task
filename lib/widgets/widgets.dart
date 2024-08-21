import 'package:flutter/material.dart';
import 'package:flutter_task_app/controllers/dropdown_controller.dart';
import 'package:flutter_task_app/controllers/slider_controller.dart';
import 'package:get/get.dart';

import '../consts/dimensions.dart';
import '../controllers/progress_controller.dart';


    //Main Image Widget
class StockImage extends StatelessWidget {
  const StockImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.green)
      ),
      child: Image.asset(
          height: getScreenHeight(context)*0.15,
          'assets/images/stockImg.jpg'
      ),);
  }
}

    //Colors DropDown Menu

class ColorsDropDown extends StatelessWidget {
  final DropDownClickController controller = Get.put(DropDownClickController());
  final List<String> dropDownColors;

  ColorsDropDown({super.key, required this.dropDownColors});

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButton<String>(
      isExpanded: true,
      alignment: Alignment.center,
      autofocus: true,
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      menuWidth: getScreenWidth(context) * 0.2,
      value: controller.colorValue.value.isNotEmpty
          ? controller.colorValue.value
          : dropDownColors.first,
      items: dropDownColors.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (value) {
          controller.changeDropDownValue(value!,dropDownColors.indexOf(value));
      },
    ));
  }
}


    //Sliding selector for speed

class SlidingSpeedSelector extends StatelessWidget {
  Color color = Colors.green;
  SlidingSpeedSelector({super.key, required this.color});
  List<String> labelList = ['SLOW','SMOOTH','FAST'];
  final SliderController sliderController = Get.put(SliderController());
  final ProgressController progressController = Get.put(ProgressController());
  @override
  Widget build(BuildContext context) {
    return Obx((){
      int index = sliderController.sliderIndex.value.toInt();
      return Slider(
      activeColor: color,
        value: sliderController.sliderIndex.value,
        divisions: 2,
        max: 2,
        label: labelList[index],
        onChanged: (value){
          sliderController.changeSliderValue(value);
          progressController.setSpeed(value);
        },
    );});
  }
}

    // Value Text Field

class ValueTextField extends StatelessWidget {
  String label ='';
  Color color = Colors.green;
  TextEditingController textEditingController;
  ValueTextField({super.key, required this.label,required this.color,required this.textEditingController});

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          keyboardType: TextInputType.number,
          controller: textEditingController,
          style: TextStyle(color: color),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: color),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: color),
                borderRadius: BorderRadius.circular(14)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: color),
                borderRadius: BorderRadius.circular(14)),
          ),
          cursorColor: Colors.red,
        ),
      );
  }
}

class MainProgressIndicator extends StatelessWidget {
  Color color = Colors.green;
  MainProgressIndicator({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    final ProgressController progressController = Get.put(ProgressController());
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.orange,
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: LinearProgressIndicator(
            color: color,
            value: progressController.progress.value,
          ),
        ),
      );
    });
  }
}


class GradientProgressBar extends StatelessWidget {
  final double value;
  final Gradient gradient;
  final double height;

  GradientProgressBar({
    Key? key,
    required this.value,
    required this.gradient,
    this.height = 6.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey),
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.grey[200],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * value,
              height: height,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GradientProgressBars extends StatelessWidget {
  final double progress;
  final int totalBars;
  final int barsPerLine;
  final Gradient gradient;
  final double height;

  const GradientProgressBars({
    Key? key,
    required this.progress,
    required this.totalBars,
    required this.barsPerLine,
    required this.gradient,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numLines = (totalBars / barsPerLine).ceil();
    double segmentWidth = (MediaQuery.of(context).size.width - (barsPerLine - 1) * 2) / barsPerLine;
    double segmentProgress = progress * totalBars;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(numLines, (lineIndex) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 0.0),
          height: 20,
          width: double.infinity,
          child: Row(
            children: List.generate(barsPerLine, (barIndex) {
              int currentIndex = lineIndex * barsPerLine + barIndex;
              if (currentIndex >= totalBars) return const SizedBox.shrink();

              double progressInSegment = segmentProgress - currentIndex;
              if (progressInSegment < 0) progressInSegment = 0.0;
              if (progressInSegment > 1) progressInSegment = 1.0;

              return Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  width: segmentWidth * progressInSegment,
                  height: height,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black),
                    color: Colors.grey[200],
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}

class TopSnackBar {
  static void show(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0,
        left: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );

    overlay?.insert(overlayEntry);

    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}






