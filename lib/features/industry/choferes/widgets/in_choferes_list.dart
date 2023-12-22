import 'package:cargocontrol/common_widgets/cargo_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../commons/common_widgets/CustomTextFields.dart';
import '../../../../models/choferes_models/choferes_model.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/loading.dart';
import '../../../admin/choferes/controllers/choferes_noti_controller.dart';

@override
class InChoferesList extends ConsumerStatefulWidget {
  const InChoferesList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InChoferesListState();
}

class _InChoferesListState extends ConsumerState<InChoferesList> {
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
      await ref.read(choferesNotiController).firstTime();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final choferesNotiCtr = ref.read(choferesNotiController);
      choferesNotiCtr.getAllChoferes(searchWord: searchCtr.text);
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
        final choferesNotiCtr = ref.watch(choferesNotiController);
        return Expanded(
          child: Column(
            children: [
              CustomTextField(
                controller: searchCtr,
                hintText: "",
                onChanged: (val){
                  choferesNotiCtr.getAllChoferes(searchWord: searchCtr.text);
                  if(searchCtr.text.isEmpty){
                    choferesNotiCtr.firstTime();
                  }
                  setState(() {
                  });
                },
                onFieldSubmitted: (val){},
                obscure: false,
                label: 'Buscar chofer',
                tailingIcon: Image.asset(AppAssets.searchIcon, scale: 2,),
              ),
              SizedBox(height: 13.h,),
              choferesNotiCtr.isLoading ?
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
                      return CargoCard(
                          topLeftText: "ID ${model.choferNationalId}",
                          topRightText: "Viajes ${model.numberOfTrips}",
                          titleText: "${model.firstName} ${model.lastName}",
                          bottomLeftText: "Deficit ${model.averageCargoDeficit}",
                          bottomRightText: "Retraso Promedio : 2:00H");

                    }),
              ),
            ],
          ),
        );
      },

    );
  }
}
