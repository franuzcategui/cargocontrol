import 'package:cargocontrol/core/enums/viajes_type.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/viajes/controllers/viajes_noti_controller.dart';
import 'package:cargocontrol/features/admin/viajes/widgets/ad_viajes_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/cargo_card.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../models/choferes_models/choferes_model.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/loading.dart';
import '../../choferes/controllers/choferes_controller.dart';

class AdAllViajesSreen extends ConsumerStatefulWidget {
  const AdAllViajesSreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AdAllViajesSreen> createState() => _AdAllViajesSreenState();
}

class _AdAllViajesSreenState extends ConsumerState<AdAllViajesSreen> {

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    initiallization();
  }

  initiallization(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async{
      await ref.read(viajesNotiController).firstTime(ref: ref);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final notiCtr = ref.read(viajesNotiController);
      notiCtr.getAllViajes(ref: ref);
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
        final viajesNotiCtr = ref.watch(viajesNotiController);
        return Column(
          children: [
            viajesNotiCtr.isLoading ?
            const LoadingWidget():
            viajesNotiCtr.viajesModels.isEmpty ?
            Padding(
              padding: EdgeInsets.all(32.0.h),
              child: const Text("No Viajes!"),
            ):
            Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: viajesNotiCtr.viajesModels.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    ViajesModel model = viajesNotiCtr.viajesModels[index];
                    return  AdViajesCard(
                      viajesEnum: model.viajesTypeEnum,
                      model: model,
                    );

                  }),
            ),
            ref.watch(viajesNotiController).isSecondaryLoading?
            const LoadingWidget(): const SizedBox()
          ],
        );
      },

    );
  }

}
