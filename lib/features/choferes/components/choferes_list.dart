import 'package:cargocontrol/common_widgets/cargo_card.dart';
import 'package:cargocontrol/common_widgets/loading_sheet.dart';
import 'package:cargocontrol/features/choferes/controller/choferes_list_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

@override
class ChoferesList extends ConsumerStatefulWidget {
  const ChoferesList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChoferesListState();
}

class _ChoferesListState extends ConsumerState<ChoferesList> {
  late final ScrollController _scrollController;
  bool fetchMore = false;

  void endOfList() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        fetchMore = true;
      });
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(endOfList);

    super.initState();
  }

  @override
  void dispose() {
    //_scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final choferesValue = ref.watch(choferListControllerProvider);
    final choferes = choferesValue.value ?? [];
    final isInitialLoading =
        choferesValue.isLoading && choferesValue.value == null;

    final choferesController = ref.watch(choferListControllerProvider.notifier);
    final hasMore = choferesController.hasMore;
    final isLoadingMore = choferesValue.isLoading && choferes.isNotEmpty;

    if (fetchMore) {
      choferesController.fetchMore();
      setState(() {
        fetchMore = false;
      });
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: isInitialLoading
          ? const LoadingSheet()
          : ListView.builder(
              itemCount: choferes.length + (!hasMore || isLoadingMore ? 1 : 0),
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final chofer = choferes[index];
                if (index == choferes.length) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!hasMore) {
                  return const Center(
                    child: Text('No hay más choferes'),
                  );
                }
                return CargoCard(
                    topLeftText: "ID ${chofer.id}",
                    topRightText: "Viajes ${chofer.viajes}",
                    titleText: "${chofer.nombre} - ${chofer.rating}",
                    bottomLeftText: "Deficit ${chofer.deficitPromedio}",
                    bottomRightText:
                        "Retraso Promedio : ${chofer.deficitPromedio}");
              }),
    );
  }
}
