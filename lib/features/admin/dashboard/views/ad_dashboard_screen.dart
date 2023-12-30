import 'package:cargocontrol/common_widgets/cargo_bar_chart.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/dashboard/widgets/ad_dashboard_mini_card.dart';
import 'package:cargocontrol/features/auth/controllers/auth_notifier_controller.dart';
import 'package:cargocontrol/models/vessel_models/vessel_cargo_model.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

import '../../../../core/enums/viajes_status_enum.dart';
import '../../../../models/industry_models/industry_sub_model.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../routes/route_manager.dart';
import '../../../../utils/loading.dart';
import '../../../coordinator/register_truck_movement/controllers/truck_registration_controller.dart';
import '../../create_industry/controllers/ad_industry_controller.dart';
import '../../create_vessel/controllers/ad_vessel_controller.dart';
import '../widgets/ad_floating_action_sheet.dart';
import '../widgets/ad_progress_dashboard_card.dart';
import '../widgets/ad_recent_record_widget.dart';

class AdDashboardScreen extends ConsumerWidget {
  const AdDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'Bienvenido',
                style: getBoldStyle(
                    color: context.textColor, fontSize: MyFonts.size18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final userModel = ref.read(authNotifierCtr).userModel;
                  print(userModel?.uid);
                  return Text(
                    userModel!.accountType.type,
                    style: getBoldStyle(
                        color: context.textColor, fontSize: MyFonts.size36),
                  );
                },
              ),
            ),
            SizedBox(
              height: (0.2 * MediaQuery.of(context).size.height).h,
              width: (0.9 * MediaQuery.of(context).size.width).w,
              child: Stack(
                children: [
                  Image.asset(constants.Images.ship),
                  Positioned(
                    left: (0.04 * MediaQuery.of(context).size.width).w,
                    bottom: (0.02 * MediaQuery.of(context).size.height).h,
                    child: const CargoBarChart(),
                  ),
                ],
              ),
            ),
            ///Vessel Data
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return ref.watch(fetchCurrentVesselsProvider).when(
                    data: (vesselModel) {
                      return Container(
                        constraints:
                        BoxConstraints(minHeight: 136.h, maxHeight: 160.h),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ///Total Vessel data
                              ref.watch(fetchCurrentVesselViajesDeficit(vesselModel.vesselId)).
                              when(
                              data: (viajesDeficitModel){
                                return  AdProgressIndicatorCard(
                                  numberOfTrips:viajesDeficitModel.viajesCount,
                                  divideNumber2: (vesselModel.totalCargoWeight-vesselModel.cargoUnloadedWeight).toString(),
                                  divideNumber1: vesselModel.totalCargoWeight.toString(),
                                  barPercentage: double.parse(
                                      ((vesselModel.totalCargoWeight-vesselModel.cargoUnloadedWeight) / vesselModel.totalCargoWeight)
                                          .toStringAsFixed(2)),
                                  title: 'Descarga total',
                                  deficit: viajesDeficitModel.totalDeficit,
                                );
                              },
                              error: (error, st){
                                return  AdProgressIndicatorCard(
                                  numberOfTrips: '0',
                                  divideNumber2: (vesselModel.totalCargoWeight-vesselModel.cargoUnloadedWeight).toString(),
                                  divideNumber1: vesselModel.totalCargoWeight.toString(),
                                  barPercentage: double.parse(
                                      ((vesselModel.totalCargoWeight-vesselModel.cargoUnloadedWeight) / vesselModel.totalCargoWeight)
                                          .toStringAsFixed(2)),
                                  title: 'Descarga total',
                                );
                              },
                              loading: (){
                                return  AdProgressIndicatorCard(
                                  numberOfTrips: '0',
                                  divideNumber2: (vesselModel.totalCargoWeight-vesselModel.cargoUnloadedWeight).toString(),
                                  divideNumber1: vesselModel.totalCargoWeight.toString(),
                                  barPercentage: double.parse(
                                      ((vesselModel.totalCargoWeight-vesselModel.cargoUnloadedWeight) / vesselModel.totalCargoWeight)
                                          .toStringAsFixed(2)),
                                  title: 'Descarga total',
                                );
                              }
                               ),

                              ListView.builder(
                                itemCount: vesselModel.cargoModels.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  VesselCargoModel model =  vesselModel.cargoModels[index];
                                  return    ref.watch(fetchCargoHoldViajesDeficit(model.cargoId)).
                                  when(
                                      data: (viajesDeficitModel){
                                        return  AdProgressIndicatorCard(
                                          numberOfTrips:viajesDeficitModel.viajesCount,
                                          divideNumber2: model.pesoUnloaded.toString(),
                                          divideNumber1: model.pesoTotal.toString(),
                                          barPercentage: double.parse(
                                              (model.pesoUnloaded/ model.pesoTotal)
                                                  .toStringAsFixed(2)),
                                          title: 'Bodega # ${index+1}',
                                          deficit: viajesDeficitModel.totalDeficit,
                                        );
                                      },
                                      error: (error, st){
                                        return  AdProgressIndicatorCard(
                                          numberOfTrips: '0',
                                          divideNumber2: model.pesoUnloaded.toString(),
                                          divideNumber1: model.pesoTotal.toString(),
                                          barPercentage: double.parse(
                                              (model.pesoUnloaded/ model.pesoTotal)
                                                  .toStringAsFixed(2)),
                                          title: 'Bodega # ${index+1}',
                                        );
                                      },
                                      loading: (){
                                        return  AdProgressIndicatorCard(
                                          numberOfTrips: '0',
                                          divideNumber2: model.pesoUnloaded.toString(),
                                          divideNumber1: model.pesoTotal.toString(),
                                          barPercentage: double.parse(
                                              (model.pesoUnloaded/ model.pesoTotal)
                                                  .toStringAsFixed(2)),
                                          title: 'Bodega # ${index+1}',
                                        );
                                      }
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }, error: (error, st) {
                  debugPrintStack(stackTrace: st);
                  debugPrint(error.toString());
                  return const SizedBox();
                }, loading: () {
                  return const SizedBox();
                });
              },
            ),


            ///Industries
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return ref.watch(fetchCurrentIndustry).when(
                    data: (allIndustries) {
                  return Container(
                    constraints:
                        BoxConstraints(minHeight: 136.h, maxHeight: 160.h),
                    child: ListView.builder(
                      itemCount: allIndustries.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        IndustrySubModel model = allIndustries[index];
                        return AdProgressIndicatorCard(
                          numberOfTrips: '${model.viajesIds.length}',
                          divideNumber2: '${model.cargoUnloaded}',
                          divideNumber1: '${model.cargoAssigned}',
                          barPercentage: double.parse(
                              (model.cargoUnloaded / model.cargoAssigned)
                                  .toStringAsFixed(2)),
                          title: '${model.industryName}',
                          deficit: model.deficit.toString(),
                        );
                      },
                    ),
                  );
                }, error: (error, st) {
                  debugPrintStack(stackTrace: st);
                  debugPrint(error.toString());
                  return const SizedBox();
                }, loading: () {
                  return const SizedBox();
                });
              },
            ),

            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return ref.watch(getPortEnteringViajesList).
                when(
                  data: (viajes){
                    return Row(
                      children: [
                        AdDashboardMiniCard(
                          title: 'Descarga total',
                          value: "${viajes.fold(0, (sum, viaje) => (sum + viaje.cargoDeficitWeight).toInt())}"
                        ),
                        AdDashboardMiniCard(
                          title: 'Viajes en camino',
                          value: "${viajes.length}"
                        ),
                      ],
                    );
                  },
                  error: (error, st){
                    return Row(
                      children: [
                        AdDashboardMiniCard(title: 'Descarga total', value: "0"),
                        AdDashboardMiniCard(title: 'Viajes en camino', value: "0"),
                      ],
                    );
                  },
                  loading: (){
                    return const SizedBox();
                  }
                );
              },
            ),
            SizedBox(
              height: 36.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Registros recientes',
                        style: getBoldStyle(
                            color: context.textColor, fontSize: MyFonts.size18),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.adAllRecentiesScreen);
                          },
                          child: Text(
                            'Ver todos',
                            style: getExtraBoldStyle(
                                color: context.mainColor,
                                fontSize: MyFonts.size12),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return ref.watch(getAllViajesList).when(
                        data: (viajesList) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                viajesList.length > 5 ? 5 : viajesList.length,
                            itemBuilder: (BuildContext context, int index) {
                              ViajesModel model = viajesList[index];
                              return GestureDetector(
                                onTap: () {},
                                child: AdRecentRecordCard(
                                  isEntered: model.viajesStatusEnum.type ==
                                          ViajesStatusEnum.portEntered.type
                                      ? true
                                      : false,
                                  isLeaving: model.viajesStatusEnum.type ==
                                          ViajesStatusEnum.portLeft.type
                                      ? true
                                      : false,
                                  guideNumber: model.guideNumber.toString(),
                                  driverName: model.chofereName,
                                  portEntryTime: model.entryTimeToPort,
                                ),
                              );
                            },
                          );
                        },
                        error: (error, st) {
                          debugPrintStack(stackTrace: st);
                          debugPrint(error.toString());
                          return const SizedBox.shrink();
                        },
                        loading: () {
                          return const LoadingWidget();
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 100.h,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              elevation: 0,
              context: context,
              builder: (context) => const AdFloadtingActionSheet());
        },
        backgroundColor: constants.kMainColor,
        child: const FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
      ),
    );
  }
}
