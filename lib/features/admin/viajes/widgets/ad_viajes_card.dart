import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:intl/intl.dart';

import '../../../../core/enums/viajes_type.dart';
import '../../../../models/viajes_models/viajes_model.dart';

class AdViajesCard extends StatelessWidget {
  final ViajesTypeEnum viajesEnum;
  final ViajesModel model;
  const AdViajesCard({super.key, required this.viajesEnum, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, AppRoutes.adminViajesDetailsScreen,arguments: {
          'viajesModel':model
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          height: 100.h,
          decoration: constants.DecorationStyles.shadow2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Camión',
                        style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                      ),
                      Text(
                        " C - ${model.licensePlate}",
                        style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size12),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: constants.DecorationStyles.viajesChipDecoration.copyWith(
                      border:  Border.all(
                        color: viajesEnum.type == ViajesTypeEnum.completed.type ?
                        context.brandColor : context.mainColor,
                      )
                    ),
                    child: Text(
                        viajesEnum.type == ViajesTypeEnum.all.type ? 'Todos':
                        viajesEnum.type == ViajesTypeEnum.inProgress.type ? 'En camino':
                        'Completados',
                      style: getRegularStyle(color: viajesEnum.type == ViajesTypeEnum.completed.type ?
                          context.brandColor:
                      context.mainColor, fontSize: MyFonts.size8)
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Carga',
                    style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                  ),
                  Text(
                    ' ${model.pureCargoWeight} - ${model.productName}',
                    style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size12),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'No Guia ',
                        style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                      ),
                      Text(
                        model.guideNumber.toStringAsFixed(0),
                        style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        viajesEnum.type == ViajesTypeEnum.inProgress.type ? 'Hora de salida ': "Hora de llegada ",
                        style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                      ),
                      Text(
                        viajesEnum.type == ViajesTypeEnum.inProgress.type ?DateFormat('HH:mm:ss').format(model.entryTimeToPort):DateFormat('HH:mm:ss').format(model.unloadingTimeInIndustry),
                        style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size12),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
