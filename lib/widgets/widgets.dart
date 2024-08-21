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
          style: TextStyle(color: color),  // color will be provided
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: color),  // color will be provided
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: color), // color will be provided
                borderRadius: BorderRadius.circular(14)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: color), // color will be provided
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

class TopSnackBar extends StatelessWidget {
  String message;
  TopSnackBar({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        content: Text(message),

    );
  }
}


class GradientProgressBar extends StatelessWidget {
  final double value; // Progress value from 0.0 to 1.0
  final Gradient gradient;
  final double height;

  GradientProgressBar({
    Key? key,
    required this.value,
    required this.gradient,
    this.height = 6.0, // Default height for the progress indicator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey), // Border color
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.grey[200], // Background color for the unfilled part
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
  final double progress; // Total progress (0.0 to 1.0)
  final int segments; // Number of segments
  final Gradient gradient; // Gradient to fill each segment
  final double height;

  const GradientProgressBars({
    Key? key,
    required this.progress,
    required this.segments,
    required this.gradient,
    this.height = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double segmentWidth = MediaQuery.of(context).size.width / segments;
    double segmentProgress = progress * segments; // Total progress split into segments

    return Container(
      height: 20,
      width: double.infinity,
      child: Stack(
        children: List.generate(segments, (index) {
          double progressInSegment = segmentProgress - index;
          if (progressInSegment < 0) progressInSegment = 0.0;
          if (progressInSegment > 1) progressInSegment = 1.0;

          return Positioned(
            left: segmentWidth * index,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: segmentWidth * progressInSegment,
                    height: 16,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey), // Border color
                      color: Colors.grey[200],
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  SizedBox(width: 5,)
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}






// class TopSnackBar extends StatelessWidget {
//   final String message;
//
//   TopSnackBar({super.key, required this.message});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           padding: const EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color: Colors.blue, // Customize the background color
//             borderRadius: BorderRadius.circular(8.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 10.0,
//                 offset: Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   message,
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.close, color: Colors.white),
//                 onPressed: () {
//                   _dismissSnackBar(context);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _dismissSnackBar(BuildContext context) {
//     Overlay.of(context)?.setState(() {
//       Navigator.of(context).pop();
//     });
//   }
// }





