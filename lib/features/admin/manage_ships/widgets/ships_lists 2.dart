import 'dart:async';

import 'package:cargocontrol/common_widgets/cargo_card.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/manage_ships/widgets/ad_ship_card.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/utils/loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../commons/common_widgets/CustomTextFields.dart';
import '../../../../models/choferes_models/choferes_model.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../controllers/ship_noti_controller.dart';

@override
class AdShipsList extends ConsumerStatefulWidget {
  const AdShipsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdChoferesListState();
}

class _AdChoferesListState extends ConsumerState<AdShipsList> {
  late ScrollController _scrollController;
  final searchCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    initiallization();
  }

  initiallization(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async{
      await ref.read(shipNotiController).firstTime();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final choferesNotiCtr = ref.read(shipNotiController);
      choferesNotiCtr.getAllShips(searchWord: searchCtr.text);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchCtr.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final shipsNotiCtr = ref.watch(shipNotiController);
        return Expanded(
          child:GestureDetector(
            onTap:() => FocusManager.instance.primaryFocus!.unfocus(),
            child: Column(
              children: [
                CustomTextField(
                  controller: searchCtr,
                  hintText: "",
                  onChanged: (val){
                    shipsNotiCtr.getAllShips(searchWord: searchCtr.text);
                    if(searchCtr.text.isEmpty){
                      shipsNotiCtr.firstTime();
                    }
                    setState(() {
                    });
                  },
                  onFieldSubmitted: (val){},
                  obscure: false,
                  label: 'Buscar buques',
                  tailingIcon: Image.asset(AppAssets.searchIcon, scale: 2,),
                ),
                SizedBox(height: 13.h,),
                shipsNotiCtr.isLoading ?
                  const LoadingWidget():
                shipsNotiCtr.shipsModels.isEmpty ?
                  const Text("No Vessels!"):
                  Expanded(
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: shipsNotiCtr.shipsModels.length,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          VesselModel model = shipsNotiCtr.shipsModels[index];
                          return  AdShipCard(vesselModel: model,);

                        }),
                  ),
                ref.watch(shipNotiController).isSecondaryLoading?
                const LoadingWidget(): const SizedBox()
              ],
            ),
          ),
        );
      },

    );
  }
}
