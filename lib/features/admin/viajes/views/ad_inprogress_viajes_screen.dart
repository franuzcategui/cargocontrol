import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/features/admin/viajes/controllers/viajes_inprogess_noti_controller.dart';
import 'package:cargocontrol/features/admin/viajes/widgets/ad_viajes_card.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../core/enums/viajes_type.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../utils/loading.dart';

class AdInProgressViajesSreen extends ConsumerStatefulWidget {
  const AdInProgressViajesSreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AdInProgressViajesSreen> createState() => _AdInProgressViajesSreenState();
}

class _AdInProgressViajesSreenState extends ConsumerState<AdInProgressViajesSreen> {
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
      await ref.read(viajesInprogessNotiController).firstTime(ref: ref);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final notiCtr = ref.read(viajesInprogessNotiController);
      notiCtr.getInprogessViajes(ref: ref);
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
        final viajesNotiCtr = ref.watch(viajesInprogessNotiController);
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
            ref.watch(viajesInprogessNotiController).isSecondaryLoading?
            const LoadingWidget(): const SizedBox()
          ],
        );
      },

    );
  }
}
