import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';

import 'co_all_viajes_screen.dart';
import 'co_completed_viajes_screen.dart';
import 'co_inprogress_viajes_screen.dart';

class CoViajesScreen extends StatelessWidget {
  const CoViajesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title:
            Text('Viajes', style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size28)),
            bottom: const TabBar(
                tabs: [
                  Tab(text: 'Todos'),
                  Tab(text: 'En camino'),
                  Tab(text: 'Completados'),
                ]),
          ),
          body: const TabBarView(
            children: [
              CoAllViajesSreen(),
              CoInProgressViajesSreen(),
              CoCompletedViajesSreen(),
            ],
          )),
    );
  }
}
