import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

import '../utils/constants/font_manager.dart';

class CargoBarChart extends StatelessWidget {
  const CargoBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.07 * MediaQuery.of(context).size.height,
      width: 0.8 * MediaQuery.of(context).size.width,
      child: Row(
        children: [
       VerticalPercentageBar(percentage: 0.7,index: 1,),
        ],
      ),
    );
  }
}

class VerticalPercentageBar extends StatelessWidget {
  final double percentage;
  final int index;

  const VerticalPercentageBar({super.key, required this.percentage, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(right: 10.w),
      child: Stack(
        children: [
          Container(
            height: 80.h, // Adjust the height of the bar as needed
            width: 60.w, // Adjust the width of the bar as needed
            decoration: BoxDecoration(
              border: Border.all(
                color: constants.kMainColor, // Adjust the border color as needed
                width: 1.0, // Adjust the border width as needed
              ),
              borderRadius: BorderRadius.zero, // Radius is set to zero for the outer container
            ),
            child: FractionallySizedBox(
              heightFactor: percentage,
              alignment: Alignment.bottomLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: constants.kMainColor,
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: 5.h,
            left: 5.h,
            child:
          Center(
            child: Text(
              "${(percentage*100).toStringAsFixed(0)}%",
              style: getBoldStyle(color:percentage<0.3? context.mainColor:context.textFieldColor, fontSize: MyFonts.size14),
            ),
          ),),
          Positioned(
            top: 1.h,
            right: 5.w,
            child:
          Text(
            "#$index",
            style: getBoldStyle(color:percentage<0.8? context.mainColor:context.textFieldColor, fontSize: MyFonts.size10),
          ),),

        ],
      ),
    );
  }
}

