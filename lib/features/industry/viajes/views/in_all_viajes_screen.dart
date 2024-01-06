import 'package:cargocontrol/core/enums/viajes_type.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common_widgets/cargo_card.dart';
import '../../../../common_widgets/viajes_card.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../models/choferes_models/choferes_model.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../routes/route_manager.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/loading.dart';
import '../controllers/in_viajes_noti_controller.dart';

class InAllViajesSreen extends ConsumerStatefulWidget {
  const InAllViajesSreen({required this.industryId, Key? key})
      : super(key: key);
  final String industryId;

  @override
  ConsumerState<InAllViajesSreen> createState() => _AdAllViajesSreenState();
}

class _AdAllViajesSreenState extends ConsumerState<InAllViajesSreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    initiallization();
  }

  initiallization() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref
          .read(inViajesNotiController)
          .firstTime(ref: ref, industryId: widget.industryId);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final notiCtr = ref.read(inViajesNotiController);
      notiCtr.getAllViajes(ref: ref, industryId: widget.industryId);
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
        final viajesNotiCtr = ref.watch(inViajesNotiController);
        return Column(
          children: [
            viajesNotiCtr.isLoading
                ? const LoadingWidget()
                : viajesNotiCtr.viajesModels.isEmpty
                    ? Padding(
                        padding: EdgeInsets.all(32.0.h),
                        child: const Text("No Viajes!"),
                      )
                    : Expanded(
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: viajesNotiCtr.viajesModels.length,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              ViajesModel model =
                                  viajesNotiCtr.viajesModels[index];
                              return ViajesCard(
                                viajesEnum: model.viajesTypeEnum,
                                model: model,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.inViajesDetailsScreen,
                                      arguments: {'viajesModel': model});
                                },
                              );
                            }),
                      ),
            ref.watch(inViajesNotiController).isSecondaryLoading
                ? const LoadingWidget()
                : const SizedBox()
          ],
        );
      },
    );
  }
}
