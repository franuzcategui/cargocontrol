import 'dart:async';

import 'package:cargocontrol/common_widgets/cargo_card.dart';
import 'package:cargocontrol/common_widgets/loading_sheet.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/choferes/controllers/choferes_noti_controller.dart';
import 'package:cargocontrol/features/choferes/controller/choferes_list_controller.dart';
import 'package:cargocontrol/utils/loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../models/choferes_models/choferes_model.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../controllers/choferes_controller.dart';

@override
class AdChoferesList extends ConsumerStatefulWidget {
  const AdChoferesList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdChoferesListState();
}

class _AdChoferesListState extends ConsumerState<AdChoferesList> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    initiallization();
  }

  initiallization(){
    ref.read(choferesNotiController).firstTime();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final choferesNotiCtr = ref.read(choferesNotiController);
      choferesNotiCtr.getAllChoferes();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final choferesNotiCtr = ref.watch(choferesNotiController);
        return choferesNotiCtr.isLoading ?
          const LoadingWidget():
        choferesNotiCtr.choferesModels.isEmpty ?
          const Text("No Chores!"):
          Expanded(
          child: ListView.builder(
              controller: _scrollController,
              itemCount: choferesNotiCtr.choferesModels.length,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                ChoferesModel model = choferesNotiCtr.choferesModels[index];
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: context.errorColor,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AppAssets.deleteArrowIcon,
                          color: Colors.white.withOpacity(0.5),
                          width: 25.w,
                          height: 25.h,
                        ),
                        Image.asset(
                          AppAssets.deleteIcon,
                          color: Colors.white,
                          width: 30.w,
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                  child: CargoCard(
                      topLeftText: "ID ${model.choferNationalId}",
                      topRightText: "Viajes ${model.numberOfTrips}",
                      titleText: "${model.firstName} ${model.lastName}",
                      bottomLeftText: "Deficit ${model.averageCargoDeficit}",
                      bottomRightText: "Retraso Promedio : 2:00H"),
                );

              }),
                  );
      },

    );
  }
}
