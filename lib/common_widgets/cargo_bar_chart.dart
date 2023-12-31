import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/admin/create_vessel/controllers/ad_vessel_controller.dart';
import '../models/vessel_models/vessel_cargo_model.dart';
import '../utils/constants/font_manager.dart';

class CargoBarChart extends StatelessWidget {
  const CargoBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.07 * MediaQuery.of(context).size.height,
      width: 0.8 * MediaQuery.of(context).size.width,
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return ref.watch(fetchCurrentVesselsProvider).when(
              data: (vesselModel) {
                return ListView.builder(
                  itemCount: vesselModel.cargoModels.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    VesselCargoModel model =  vesselModel.cargoModels[index];
                  return VerticalPercentageBar(percentage:
                    (model.pesoUnloaded/ model.pesoTotal),index: index+1,);

                  },
                );
              }, error: (error, st) {
            //debugPrintStack(stackTrace: st);
            //debugPrint(error.toString());
            return const SizedBox();
          }, loading: () {
            return const SizedBox();
          });
        },
      ),


      // Row(
      //   children: [
      //  VerticalPercentageBar(percentage: 0.7,index: 1,),
      //   ],
      // ),
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
              style: getBoldStyle(color:percentage<0.3? context.mainColor:Colors.black, fontSize: MyFonts.size14),
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

