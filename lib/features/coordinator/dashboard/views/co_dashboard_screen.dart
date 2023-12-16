import 'package:cargocontrol/authentication/controller/authentication_controller.dart';
import 'package:cargocontrol/common_widgets/cargo_bar_chart.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/dashboard/widgets/ad_dashboard_mini_card.dart';
import 'package:cargocontrol/features/dashboard/components/dashboard_mini_card.dart';
import 'package:cargocontrol/common_widgets/progress_indicator_card.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:cargocontrol/features/dashboard/components/dashboard_button_modal.dart';

import '../../../../models/industry_models/industry_sub_model.dart';
import '../../../admin/create_industry/controllers/ad_industry_controller.dart';
import '../../../auth/controllers/auth_notifier_controller.dart';
import '../widgets/co_dashboard_mini_card.dart';
import '../widgets/co_floating_action_sheet.dart';
import '../widgets/co_progress_dashboard_card.dart';
import '../widgets/co_recent_record_card.dart';

class CoDashboardScreen extends ConsumerWidget {
  const CoDashboardScreen({super.key});

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
            SizedBox(
              height: 136.h,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CoProgressIndicatorCard(
                      numberOfTrips: '0',
                      divideNumber2: '0',
                      divideNumber1: '0',
                      barPercentage: 0,
                      title: 'Descarga total',
                    ),
                    CoProgressIndicatorCard(
                      numberOfTrips: '0',
                      divideNumber2: '0',
                      divideNumber1: '0',
                      barPercentage: 0,
                      title: 'Bodega # 1 ',
                    ),
                  ]),
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return ref.watch(fetchCurrentIndustry).when(
                    data: (allIndustries){

                      return SizedBox(
                        height: 136.h,
                        child: ListView.builder(
                          itemCount: allIndustries.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            IndustrySubModel model = allIndustries[index];
                            return CoProgressIndicatorCard(
                              numberOfTrips: '0',
                              divideNumber2: '${model.cargoUnloaded}',
                              divideNumber1: '${model.cargoAssigned}',
                              barPercentage: model.cargoUnloaded!= 0? model.cargoAssigned/model.cargoUnloaded: 0,
                              title: 'Industria #${index+1}',
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
            SizedBox(
              height: 116.h,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:  const [
                    CoDashboardMiniCard(
                        title: 'Registros',
                        subTitle: ' entrando',
                        isGood: true,
                        value: "0"),
                    CoDashboardMiniCard(
                        title: 'Registros',
                        subTitle: ' saliendo',
                        isBad: true,
                        value: "0"),
                    CoDashboardMiniCard(
                        title: 'Camiones ',
                        subTitle: 'en patio',
                        value: "0"),
                  ]),
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){

                        },
                        child: CoRecentRecordCard(
                          isEntered: index %2 ==0 ? true : false,
                          isLeaving:  index %2 !=0 ? true : false,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: 100.h,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
