import 'package:cargocontrol/authentication/controller/authentication_controller.dart';
import 'package:cargocontrol/common_widgets/cargo_bar_chart.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/common_widgets/progress_indicator_card.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

import '../widgets/in_dashboard_mini_card.dart';
import '../widgets/in_floating_action_sheet.dart';
import '../widgets/in_progress_dashboard_card.dart';

class InDashboardScreen extends ConsumerWidget {
  const InDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authenticationState = ref.watch(authProvider);
    final String  userType = authenticationState.user.userType.toString().split('.').last;

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
              child: Text(
                userType,
                style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size36),
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
              height: 116,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const <ProgressIndicatorCard>[
                    ProgressIndicatorCard(),
                    ProgressIndicatorCard(),
                  ]),
            ),
            SizedBox(
              height: 116,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return const InProgressIndicatorCard(
                    title: 'C.A.C.S.A',
                    barPercentage: 0.2,
                    deficit: '20',
                    divideNumber1: '6,991,105' ,
                    divideNumber2: '40,340',
                    numberOfTrips: '1',
                  );
                },
              ),
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
