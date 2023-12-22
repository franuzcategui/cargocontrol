import 'package:cargocontrol/common_widgets/cargo_bar_chart.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/industry/register_truck_movements/controllers/in_truck_registration_noti_controller.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

import '../../../auth/controllers/auth_notifier_controller.dart';
import '../../../coordinator/register_truck_movement/controllers/truck_registration_controller.dart';
import '../widgets/in_dashboard_mini_card.dart';
import '../widgets/in_floating_action_sheet.dart';
import '../widgets/in_progress_dashboard_card.dart';

class InDashboardScreen extends ConsumerWidget {
  const InDashboardScreen({super.key});

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
              height: 150.h,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    InProgressIndicatorCard(
                      numberOfTrips: '0',
                      divideNumber2: '0',
                      divideNumber1: '0',
                      barPercentage: 0,
                      title: 'Descarga total',
                      deficit: '',
                    ),
                    InProgressIndicatorCard(
                      numberOfTrips: '0',
                      divideNumber2: '0',
                      divideNumber1: '0',
                      barPercentage: 0,
                      title: 'Bodega # 1 ',
                      deficit: '',
                    ),
                  ]),
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return ref.watch(getIndustriaIndustry( ref.read(authNotifierCtr).userModel?.industryId?? "")).
                when(
                  data: (industryModel){
                    return  SizedBox(
                      height: 150.h,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            InProgressIndicatorCard(
                              numberOfTrips: industryModel.viajesIds.length.toString(),
                              divideNumber2: industryModel.cargoUnloaded.toString(),
                              divideNumber1: industryModel.cargoAssigned.toString(),
                              barPercentage: double.parse((industryModel.cargoUnloaded/industryModel.cargoAssigned).toStringAsFixed(2)),
                              title: industryModel.industryName,
                              deficit: '0',
                            ),
                          ]),
                    );
                  },
                  error: (error, st){
                    debugPrintStack(stackTrace: st);
                    debugPrint(error.toString());
                    return const SizedBox();
                  },
                  loading: (){
                    return const SizedBox();
                  },
                );
              },
            ),
            SizedBox(
              height: 116.h,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:  const [
                    InDashboardMiniCard(
                        title: 'Saldo',
                        subTitle: ' total',
                        value: "0"),
                    InDashboardMiniCard(
                        title: 'Viajes',
                        subTitle: ' en camino',
                        value: "0"),

                  ]),
            ),
            SizedBox(height: 36.h,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              elevation: 0,
              context: context,
              builder: (context) => const InFloadtingActionSheet());
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
