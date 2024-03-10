import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/custom_editable_tile.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';
import 'package:cargocontrol/models/misc_models/industry_vessel_ids_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';
import '../features/coordinator/register_truck_movement/controllers/truck_registration_controller.dart';

class TiempoWidget extends StatelessWidget {
  const TiempoWidget(
      {Key? key,
      required this.viajesModel,
      this.isEditable = false,
      required this.onEdit})
      : super(key: key);
  final ViajesModel viajesModel;
  final bool isEditable;
  final Function() onEdit;

  String formatDuration(Duration duration) {
    DateTime referenceTime = DateTime(2000, 1, 0, 0, 0, 0);
    DateTime formattedTime = referenceTime.add(duration);
    String formatPattern = formattedTime.day > 0 && formattedTime.day < 31
        ? 'dd:H:mm:ss'
        : 'H:mm:ss';
    DateFormat formatter = DateFormat(formatPattern);
    return formatter.format(formattedTime);
  }

  Duration calculateAvgArrivalTime(List<ViajesModel> viajesList) {
    if (viajesList.isEmpty) {
      return const Duration(); // Handle the case when the list is empty
    }
    Duration totalArrivalTime = Duration();
    for (ViajesModel viajes in viajesList) {
      totalArrivalTime +=
          viajes.timeToIndustry.difference(viajes.exitTimeToPort);
    }
    // Calculate average arrival time
    Duration avgArrivalTime =
        Duration(seconds: totalArrivalTime.inSeconds ~/ viajesList.length);
    return avgArrivalTime;
  }

  Duration calculateAvgUnloadingTime(List<ViajesModel> viajesList) {
    if (viajesList.isEmpty) {
      return const Duration(); // Handle the case when the list is empty
    }
    Duration totalArrivalTime = Duration();
    for (ViajesModel viajes in viajesList) {
      totalArrivalTime +=
          viajes.unloadingTimeInIndustry.difference(viajes.timeToIndustry);
    }
    Duration avgArrivalTime =
        Duration(seconds: totalArrivalTime.inSeconds ~/ viajesList.length);
    return avgArrivalTime;
  }

  @override
  Widget build(BuildContext context) {
    if (viajesModel.viajesStatusEnum.type ==
        ViajesStatusEnum.portEntered.type) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tiempo de viaje",
            style: getBoldStyle(
              color: context.textColor,
              fontSize: MyFonts.size14,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: Text(
              "Viajes Has Not left Port Yet",
              style: getMediumStyle(
                color: context.textColor,
                fontSize: MyFonts.size12,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      );
    } else if (viajesModel.viajesStatusEnum.type ==
        ViajesStatusEnum.portLeft.type) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tiempo de viaje",
            style: getBoldStyle(
              color: context.textColor,
              fontSize: MyFonts.size14,
            ),
          ),
          SizedBox(
            height: 28.h,
          ),
          CustomTile(
              title: "Hora de salida",
              subText:
                  DateFormat('dd:HH:mm:ss').format(viajesModel.exitTimeToPort)),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tiempo de viaje",
            style: getBoldStyle(
              color: context.textColor,
              fontSize: MyFonts.size14,
            ),
          ),
          SizedBox(
            height: 28.h,
          ),
          if (isEditable) ...[
            CustomEditableTile(
                title: "Hora de salida",
                subText: DateFormat('dd:HH:mm:ss')
                    .format(viajesModel.exitTimeToPort),
                onTap: onEdit),
            CustomEditableTile(
                title: "Hora de llegada a industria",
                subText: DateFormat('dd:HH:mm:ss')
                    .format(viajesModel.timeToIndustry),
                onTap: onEdit),
            CustomEditableTile(
                title: "Hora de descarga",
                subText: DateFormat('dd:HH:mm:ss')
                    .format(viajesModel.unloadingTimeInIndustry),
                onTap: onEdit),
          ],
          if (!isEditable) ...[
            CustomTile(
                title: "Hora de salida",
                subText: DateFormat('dd:HH:mm:ss')
                    .format(viajesModel.exitTimeToPort)),
            CustomTile(
                title: "Hora de llegada a industria",
                subText: DateFormat('dd:HH:mm:ss')
                    .format(viajesModel.timeToIndustry)),
            CustomTile(
                title: "Hora de descarga",
                subText: DateFormat('dd:HH:mm:ss')
                    .format(viajesModel.unloadingTimeInIndustry)),
          ],


          CustomTile(
            title: "Tiempo a destino",
            subText: formatDuration(viajesModel.timeToIndustry
                .difference(viajesModel.exitTimeToPort)),
          ),

          CustomTile(
            title: "Tiempo de descarga",
            subText: formatDuration(viajesModel.unloadingTimeInIndustry
                .difference(viajesModel.timeToIndustry)),
          ),

          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return ref
                  .watch(getAllViajesForIndustryList(IndustryAndVesselIdsModel(
                      industryId: viajesModel.industryId,
                      vesselId: viajesModel.vesselId)))
                  .when(
                data: (viajesList) {
                  if (viajesList.isEmpty) {
                    return SizedBox();
                  }
                  Duration avgTimeToIndustryFromPort =
                      calculateAvgArrivalTime(viajesList);
                  Duration avgTimeUnloading =
                      calculateAvgUnloadingTime(viajesList);
                  Duration delayTimeToIndustryFromPort =
                      (avgTimeToIndustryFromPort -
                          (viajesModel.timeToIndustry
                              .difference(viajesModel.exitTimeToPort)));
                  Duration delayTimeUnloading = (avgTimeUnloading -
                      (viajesModel.unloadingTimeInIndustry
                          .difference(viajesModel.timeToIndustry)));

                  return Column(
                    children: [
                      //Average arrival time for the industry (Sum of "Tiempo a destino" of all trips ('viajes') of that industry/ Qty of trips ('viajes'))
                      CustomTile(
                          title: "Tiempo promedio a destino",
                          subText: formatDuration(avgTimeToIndustryFromPort)),

                      //Average time of unloading (sum of "tiempo de descarga" for all the "viajes" for that industry/ qty of "viajes"
                      CustomTile(
                          title: "Tiempo promedio de descarga",
                          subText: formatDuration(avgTimeUnloading)),

                      //Delayed time (Tiempo promedio a destino - Tiempo a destino)
                      CustomTile(
                        title: "Tiempo de retraso a destino",
                        subText:
                            formatDuration(delayTimeToIndustryFromPort.abs()),
                        hasWarning: delayTimeToIndustryFromPort.isNegative,
                        isGoodSign: !delayTimeToIndustryFromPort.isNegative,
                      ),

                      //Time delayed unloading (Tiempo promedio de descarga - Tiempo de descarga)
                      CustomTile(
                        title: "Tiempo de retraso descargando",
                        subText: formatDuration(delayTimeUnloading.abs()),
                        hasWarning: delayTimeUnloading.isNegative,
                        isGoodSign: !delayTimeUnloading.isNegative,
                      ),
                    ],
                  );
                },
                error: (error, st) {
                  debugPrintStack(stackTrace: st);
                  debugPrint(error.toString());
                  return const SizedBox.shrink();
                },
                loading: () {
                  return const SizedBox.shrink();
                },
              );
            },
          ),

          //Todo usman:Leave it for now
          const CustomTile(
            title: "Tiempo promedio de retraso chofer",
            subText: "0:10:00",
            hasWarning: true,
          ),
        ],
      );
    }
  }
}
