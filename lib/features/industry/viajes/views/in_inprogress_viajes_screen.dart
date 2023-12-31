import 'package:cargocontrol/commons/common_imports/apis_commons.dart';

import '../../../../common_widgets/viajes_card.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../core/enums/viajes_type.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../routes/route_manager.dart';
import '../../../../utils/loading.dart';
import '../controllers/in_viajes_inprogess_noti_controller.dart';

class InInProgressViajesSreen extends ConsumerStatefulWidget {
  const InInProgressViajesSreen({required this.industryId, Key? key}) : super(key: key);
  final String industryId;
  @override
  ConsumerState<InInProgressViajesSreen> createState() => _AdInProgressViajesSreenState();
}

class _AdInProgressViajesSreenState extends ConsumerState<InInProgressViajesSreen> {
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
      await ref.read(inViajesInprogessNotiController).firstTime(ref: ref,industryId: widget.industryId);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final notiCtr = ref.read(inViajesInprogessNotiController);
      notiCtr.getInprogessViajes(ref: ref,industryId: widget.industryId);
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
        final viajesNotiCtr = ref.watch(inViajesInprogessNotiController);
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
                    return  ViajesCard(
                      viajesEnum: model.viajesTypeEnum,
                      model: model,
                      onTap: (){
                        Navigator.pushNamed(context, AppRoutes.inViajesDetailsScreen,arguments: {
                          'viajesModel':model
                        });
                      },
                    );

                  }),
            ),
            ref.watch(inViajesInprogessNotiController).isSecondaryLoading?
            const LoadingWidget(): const SizedBox()
          ],
        );
      },

    );
  }
}
