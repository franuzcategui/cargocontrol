import 'package:cargocontrol/widgets/cargo_bar_chart.dart';
import 'package:cargocontrol/widgets/dashboard_mini_card.dart';
import 'package:cargocontrol/widgets/progress_indicator_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cargocontrol/constants.dart' as constants;
import 'package:cargocontrol/widgets/dashboard_button_modal.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => const DashboardButtonModal());
        },
        backgroundColor: constants.kMainColor,
        child: const FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Bienvenido',
              style: const constants.TextStyles().auxTitleText1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Administrador',
              style: const constants.TextStyles().titleText1,
            ),
          ),
          Container(
            height: 0.2 * MediaQuery.of(context).size.height,
            width: 0.9 * MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Image.asset(constants.Images.ship),
                Positioned(
                  left: 0.04 * MediaQuery.of(context).size.width,
                  bottom: 0.06 * MediaQuery.of(context).size.height,
                  child: CargoBarChart(),
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
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: const <ProgressIndicatorCard>[
                  ProgressIndicatorCard(),
                  ProgressIndicatorCard(),
                ]),
          ),
          SizedBox(
            height: 116,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: const <DashboardMiniCard>[
                  DashboardMiniCard(),
                  DashboardMiniCard(),
                  DashboardMiniCard(),
                  DashboardMiniCard(),
                ]),
          ),
        ],
      ),
    );
  }
}
