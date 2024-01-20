import 'package:cargocontrol/common_widgets/cargo_bar_chart.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_controller.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

import '../../../../common_widgets/dashboard_top_widget.dart';
import '../../../../models/industry_models/industry_sub_model.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../admin/create_industry/controllers/ad_industry_controller.dart';
import '../../../admin/create_vessel/controllers/ad_vessel_controller.dart';
import '../../../auth/controllers/auth_notifier_controller.dart';
import '../../register_truck_movement/controllers/truck_registration_noti_controller.dart';
import '../widgets/co_dashboard_mini_card.dart';
import '../widgets/co_floating_action_sheet.dart';
import '../widgets/co_progress_dashboard_card.dart';
import '../widgets/co_recent_record_card.dart';

class CoDashboardScreen extends ConsumerWidget {
  const CoDashboardScreen({super.key});
  initiallize(WidgetRef ref)async{
    await ref.read(truckRegistrationNotiControllerProvider).getAllIndustriesModel();
    ref.read(truckRegistrationNotiControllerProvider).setIndustryMatchedStatus(false);
    ref.read(truckRegistrationNotiControllerProvider).setSelectedChofere(null);
    ref.read(truckRegistrationNotiControllerProvider).setMatchedViajes(null);
    ref.read(truckRegistrationNotiControllerProvider).setSelectedIndustry(null);
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'Bienvenido',
                style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final userModel = ref.read(authNotifierCtr).userModel;
                  print(userModel?.uid);
                  return Text(userModel!.accountType.type,
                    style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size36),
                  );

                },

              ),
            ),
            DashBoardTopWidget(),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return ref.watch(fetchCurrentVesselsProvider).when(
                    data: (vesselModel) {
                      return  Column(
                        children: [
                          Consumer(
                            builder: (BuildContext context, WidgetRef ref, Widget? child) {
                              return ref.watch(fetchCurrentVesselIndustries(vesselModel.vesselId)).when(
                                  data: (allIndustries){
                                    if(allIndustries.isEmpty){
                                      return SizedBox();
                                    }
                                    return Container(
                                      constraints: BoxConstraints(
                                          minHeight:  136.h,
                                          maxHeight: 160.h
                                      ),
                                      child: ListView.builder(
                                        itemCount: allIndustries.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (BuildContext context, int index) {
                                          IndustrySubModel model = allIndustries[index];
                                          return CoProgressIndicatorCard(
                                            numberOfTrips: model.viajesIds.length.toString(),
                                            divideNumber2: '${model.cargoUnloaded}',
                                            divideNumber1: '${model.cargoAssigned}',
                                            barPercentage: model.cargoUnloaded!= 0? (model.cargoUnloaded/model.cargoAssigned): 0,
                                            title: '${model.industryName}',
                                            deficit: model.deficit.toString(),


                                          );
                                        },

                                      ),
                                    );
                                  },
                                  error: (error, st){
                                    debugPrintStack(stackTrace: st);
                                    debugPrint(error.toString());
                                    return const SizedBox();
                                  },
                                  loading: (){
                                    return const SizedBox();
                                  }
                              );
                            },

                          ),
                          Consumer(
                            builder: (BuildContext context, WidgetRef ref, Widget? child) {
                              return SizedBox(
                                height: 116.h,
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children:  [
                                      ref.watch(getPortEnteringViajesList(vesselModel.vesselId)).when(
                                        data: (viajesList){
                                          return CoDashboardMiniCard(
                                              title: 'Registros',
                                              subTitle: ' entrando',
                                              isGood: true,
                                              value: "${viajesList.length}");
                                        },
                                        error: (error, st){
                                          debugPrintStack(stackTrace: st);
                                          debugPrint(error.toString());
                                          return const SizedBox.shrink();
                                        },
                                        loading: (){
                                          return const LoadingWidget();
                                        },
                                      ),
                                      ref.watch(getPortLeavingViajesList(vesselModel.vesselId)).when(
                                        data: (viajesList){
                                          return CoDashboardMiniCard(
                                              title: 'Registros',
                                              subTitle: ' saliendo',
                                              isBad: true,
                                              value: "${viajesList.length}");
                                        },
                                        error: (error, st){
                                          debugPrintStack(stackTrace: st);
                                          debugPrint(error.toString());
                                          return const SizedBox.shrink();
                                        },
                                        loading: (){
                                          return const LoadingWidget();
                                        },
                                      ),
                                      ref.watch(getPortEnteringViajesList(vesselModel.vesselId)).when(
                                        data: (viajesList){
                                          return CoDashboardMiniCard(
                                              title: 'Camiones ',
                                              subTitle: 'en patio',
                                              value: "${viajesList.length}");
                                        },
                                        error: (error, st){
                                          debugPrintStack(stackTrace: st);
                                          debugPrint(error.toString());
                                          return const SizedBox.shrink();
                                        },
                                        loading: (){
                                          return const LoadingWidget();
                                        },
                                      ),
                                    ]),
                              );
                            },
                          ),
                          SizedBox(height: 36.h,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Registros recientes', style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size18),),
                                    GestureDetector(
                                        onTap: (){
                                          Navigator.pushNamed(context, AppRoutes.coAllRecentiesScreen);
                                        },
                                        child: Text('Ver todos', style: getExtraBoldStyle(color: context.mainColor, fontSize: MyFonts.size12),))
                                  ],
                                ),
                                SizedBox(height: 28.h,),
                                Consumer(
                                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                    return ref.watch(getAllViajesList(vesselModel.vesselId)).
                                    when(
                                      data: (viajesList){
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: viajesList.length> 5 ? 5:viajesList.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            ViajesModel model =  viajesList[index];
                                            return GestureDetector(
                                              onTap: (){

                                              },
                                              child: CoRecentRecordCard(
                                                isEntered: model.viajesStatusEnum.type == ViajesStatusEnum.portEntered.type ? true : false,
                                                isLeaving:  model.viajesStatusEnum.type == ViajesStatusEnum.portLeft.type ? true : false,
                                                guideNumber: model.guideNumber.toStringAsFixed(0),
                                                driverName: model.chofereName,
                                                portEntryTime: model.entryTimeToPort,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      error: (error, st){
                                        debugPrintStack(stackTrace: st);
                                        debugPrint(error.toString());
                                        return const SizedBox.shrink();
                                      },
                                      loading: (){
                                        return const LoadingWidget();
                                      },
                                    );

                                  },
                                )
                              ],
                            ),
                          ),
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

            SizedBox(height: 100.h,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await  initiallize(ref);
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              elevation: 0,
              context: context,
              builder: (context) => const CoFloadtingActionSheet());
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
