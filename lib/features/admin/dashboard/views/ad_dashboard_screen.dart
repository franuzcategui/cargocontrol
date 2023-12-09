import 'package:cargocontrol/authentication/controller/authentication_controller.dart';
import 'package:cargocontrol/common_widgets/cargo_bar_chart.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/dashboard/widgets/ad_dashboard_mini_card.dart';
import 'package:cargocontrol/common_widgets/progress_indicator_card.dart';
import 'package:cargocontrol/features/auth/controllers/auth_notifier_controller.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

import '../../../../routes/route_manager.dart';
import '../../../auth/controllers/auth_controller.dart';
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
              height: 126.h,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    AdProgressIndicatorCard(
                      numberOfTrips: '0',
                      divideNumber2: '0',
                      divideNumber1: '0',
                      barPercentage: 0,
                      title: 'Descarga total',
                    ),
                    AdProgressIndicatorCard(
                      numberOfTrips: '0',
                      divideNumber2: '0',
                      divideNumber1: '0',
                      barPercentage: 0,
                      title: 'Bodega # 1 ',
                    ),
                  ]),
            ),
            SizedBox(
              height: 126.h,
              child: ListView.builder(
                itemCount: 2,
                scrollDirection: Axis.horizontal,

                itemBuilder: (BuildContext context, int index) {
                  return AdProgressIndicatorCard(
                    numberOfTrips: '0',
                    divideNumber2: '0',
                    divideNumber1: '0',
                    barPercentage: 0,
                    title: 'Industria #${index+1}',
                  );
                },

              ),
            ),
            const Row(
                children:  [
                  AdDashboardMiniCard(title: 'Descarga total', value: "0"),
                  AdDashboardMiniCard(title: 'Viajes en camino', value: "0"),
                ]),
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
                        child: AdRecentRecordCard(
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
