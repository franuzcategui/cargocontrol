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
import '../features/admin/choferes/data/models/choferes_time_deficit_model.dart';
import '../features/coordinator/register_truck_movement/controllers/truck_registration_controller.dart';
import '../models/choferes_models/choferes_model.dart';

class ChoferesWeightTiempoWidget extends StatelessWidget {
  const ChoferesWeightTiempoWidget({
    Key? key,
    required this.choferesModel,
    this.realIndustryIdOfCurrentUser = "",
  }) : super(key: key);
  final ChoferesModel choferesModel;
  final String realIndustryIdOfCurrentUser;

  String formatDuration(Duration duration) {
    DateTime referenceTime = DateTime(2000, 1, 0, 0, 0, 0);
    DateTime formattedTime = referenceTime.add(duration);
    String formatPattern = formattedTime.day > 0 && formattedTime.day < 31
        ? 'dd:H:mm:ss'
        : 'H:mm:ss';
    DateFormat formatter = DateFormat(formatPattern);
    return formatter.format(formattedTime);
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

        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ref.watch(getChoferesTimeDeficitModel(choferesModel)).when(
                data: (choferesTimeDefModels) {
                  List<ChoferesTimeDeficitModel> choferesTimeDeficitModels=[];
                  if(realIndustryIdOfCurrentUser.isEmpty){
                    choferesTimeDeficitModels=choferesTimeDefModels;
                    print("here worng");
                  }else{
                    print("here");
                    choferesTimeDefModels.forEach((model) {
                      if(model.realIndustryId==realIndustryIdOfCurrentUser){
                        choferesTimeDeficitModels.add(model);
                      }
                    });
                  }

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
                                    .worstTimeDeficit
                                    .abs()),
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
      ],
    );
  }
}
