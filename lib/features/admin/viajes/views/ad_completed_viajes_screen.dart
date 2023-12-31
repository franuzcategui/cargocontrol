import 'package:cargocontrol/features/admin/viajes/widgets/ad_viajes_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../core/enums/viajes_type.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../utils/loading.dart';
import '../controllers/viajes_completed_noti_controller.dart';

class AdCompletedViajesSreen extends ConsumerStatefulWidget {
  const AdCompletedViajesSreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AdCompletedViajesSreen> createState() => _AdCompletedViajesSreenState();
}

class _AdCompletedViajesSreenState extends ConsumerState<AdCompletedViajesSreen> {
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
      await ref.read(viajesCompletedNotiController).firstTime(ref: ref);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final notiCtr = ref.read(viajesCompletedNotiController);
      notiCtr.getCompletedViajes(ref: ref);
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
        final viajesNotiCtr = ref.watch(viajesCompletedNotiController);
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
            ref.watch(viajesCompletedNotiController).isSecondaryLoading?
            const LoadingWidget(): const SizedBox()
          ],
        );
      },

    );
  }
}
