import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/misc_models/industry_vessel_ids_model.dart';
import '../../../admin/create_vessel/controllers/ad_vessel_controller.dart';
import '../../../auth/controllers/auth_notifier_controller.dart';
import '../../../coordinator/register_truck_movement/controllers/truck_registration_controller.dart';
import 'in_all_viajes_screen.dart';
import 'in_completed_viajes_screen.dart';
import 'in_inprogress_viajes_screen.dart';

class InViajesScreen extends StatelessWidget {
  const InViajesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return ref.watch(fetchCurrentVesselsProvider).when(
              data: (vesselModel) {
            return Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return ref
                    .watch(getIndustriaIndustry(IndustryAndVesselIdsModel(industryId: ref.read(authNotifierCtr).userModel?.industryId ?? "", vesselId: vesselModel.vesselId)
                ))
                    .when(
                  data: (industryModel) {
                    return  DefaultTabController(
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
                          body:  TabBarView(
                            children: [
                              InAllViajesSreen(industryId: industryModel.industryId,),
                              InInProgressViajesSreen(industryId: industryModel.industryId,),
                              InCompletedViajesSreen(industryId: industryModel.industryId,),
                            ],
                          )),
                    );
                  },
                  error: (error, st) {
                    debugPrintStack(stackTrace: st);
                    debugPrint(error.toString());
                    return  DefaultTabController(
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
                          body:  const TabBarView(
                            children: [
                              Center(
                                child: Text("No Viajes!"),
                              ),    Center(
                                child: Text("No Viajes!"),
                              ),    Center(
                                child: Text("No Viajes!"),
                              ),
                            ],
                          )),
                    );
                  },
                  loading: () {
                    return const SizedBox();
                  },
                );
              },
            );
              }, error: (error, st) {
            //debugPrintStack(stackTrace: st);
            //debugPrint(error.toString());
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
                  body:  TabBarView(
                    children: [
                      Center(
                        child: const Text("No Viajes!"),
                      ),    Center(
                        child: const Text("No Viajes!"),
                      ),    Center(
                        child: const Text("No Viajes!"),
                      ),
                    ],
                  )),
            );
          }, loading: () {
            return const SizedBox();
          });
        },
      );




  }
}
