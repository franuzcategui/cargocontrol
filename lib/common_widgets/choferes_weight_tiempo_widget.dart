import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';
import 'package:cargocontrol/models/misc_models/industry_vessel_ids_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';
import '../features/admin/choferes/controllers/choferes_controller.dart';
import '../features/coordinator/register_truck_movement/controllers/truck_registration_controller.dart';
import '../models/choferes_models/choferes_model.dart';

class ChoferesWeightTiempoWidget extends StatelessWidget {
  const ChoferesWeightTiempoWidget({Key? key, required this.choferesModel})
      : super(key: key);
  final ChoferesModel choferesModel;

  String formatDuration(Duration duration) {
    DateTime referenceTime = DateTime(2000, 1, 0, 0, 0, 0);
    DateTime formattedTime = referenceTime.add(duration);
    String formatPattern = formattedTime.day > 0 &&  formattedTime.day<31? 'dd:H:mm:ss' : 'H:mm:ss';
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
    // double avgArrivalTime = totalArrivalTime.inMinutes / viajesList.length;
    // return avgArrivalTime;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Estadística de viajes",
          style: getBoldStyle(
            color: context.textColor,
            fontSize: MyFonts.size14,
          ),
        ),
        SizedBox(
          height: 28.h,
        ),
        CustomTile(
          title: "Viajes realizados",
          subText: choferesModel.numberOfTrips.toStringAsFixed(0),
        ),

        CustomTile(
          title: "Perdida de carga promedio (%)",
          subText: (choferesModel.averageCargoDeficitPercentage * 100)
              .toStringAsFixed(2),
        ),

        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ref
                .watch(getChoferesCargoDeficitPercentile(choferesModel))
                .when(data: (value) {
              return CustomTile(
                  title: "Percentil de perdida de carga",
                  subText: value.toStringAsFixed(2));
            }, error: (error, st) {
              //debugPrintStack(stackTrace: st);
              //debugPrint(error.toString());
              return const SizedBox();
            }, loading: () {
              return const SizedBox();
            });
          },
        ),
        CustomTile(
          title: "Mayor pérdida de carga(%)",
          subText: (choferesModel.worstCargoDeficitPercentage * 100)
              .toStringAsFixed(2),
        ),

        //

// Step 1: get all vaijes that are completed
        // step 2 : make group based on real industry id
        // step 3 : get a average of trip time for each industry
        // step 4: get this chofer vaijes for each inustry and  iterrateb throgh it to time deficit
        // step 5: get the sum of time deficit / number of vaijes
        // step 6: return the list max limit 4.(Conatining industry name, industry id, duaration)

        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ref.watch(getChoferesTimeDeficitModel(choferesModel)).when(
                data: (choferesTimeDeficitModels) {
              print(choferesTimeDeficitModels.length);
              if (choferesTimeDeficitModels.isEmpty) {
                return SizedBox();
              }
              return Column(
                children: [
                  const CustomTile(
                      title: "Tiempo promedio de retraso", subText: ""),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0.w),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: choferesTimeDeficitModels.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CustomTile(
                            title:
                                choferesTimeDeficitModels[index].industryName,
                            subText: formatDuration(
                                choferesTimeDeficitModels[index]
                                    .avgTimeDeficit
                                    .abs()),
                            hasWarning: choferesTimeDeficitModels[index]
                                .avgTimeDeficit
                                .isNegative,
                            isGoodSign: !choferesTimeDeficitModels[index]
                                .avgTimeDeficit
                                .isNegative,
                          );
                        }),
                  ),
                  const CustomTile(
                      title: "Mayor tiempo de retraso", subText: ""),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0.w),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: choferesTimeDeficitModels.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CustomTile(
                            title:
                                choferesTimeDeficitModels[index].industryName,
                            subText: formatDuration(
                                choferesTimeDeficitModels[index]
                                    .worstTimeDeficit.abs()),
                            hasWarning: choferesTimeDeficitModels[index]
                                .worstTimeDeficit
                                .isNegative,
                            isGoodSign: !choferesTimeDeficitModels[index]
                                .worstTimeDeficit
                                .isNegative,
                          );
                        }),
                  )
                ],
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

        //formatDuration(choferesModel.unloadingTimeInIndustry.difference(choferesModel.timeToIndustry)
        // Step 1: get all vaijes that are completed
        // step 2 : make group based on real industry id
        // step 3 : get a average of trip time for each industry
        // step 4: get this chofer vaijes for each inustry and  iterrateb throgh it to get time deficit and maintain list
        // step 5: for each industry deficit list get the max out
        // step 6: return the list max limit 4. (Conatining industry name, industry id, duaration)
      ],
    );
  }
}
