import 'package:cargocontrol/common_widgets/cargo_card.dart';
import 'package:cargocontrol/common_widgets/loading_sheet.dart';
import 'package:cargocontrol/features/choferes/controller/choferes_list_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ChoferesList extends ConsumerWidget {
  const ChoferesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final choferesValue = ref.watch(choferListControllerProvider);
    final choferes = choferesValue.value ?? [];
    final isInitialLoading = choferesValue.isLoading && choferes.isEmpty;

    return isInitialLoading
        ? const LoadingSheet()
        : ListView.builder(
            itemCount: choferes.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final chofer = choferes[index];
              return CargoCard(
                  topLeftText: "ID ${chofer.id}",
                  topRightText: "Viajes ${chofer.viajes}",
                  titleText: "${chofer.nombre} - ${chofer.rating}",
                  bottomLeftText: "Deficit ${chofer.deficitPromedio}",
                  bottomRightText:
                      "Retraso Promedio : ${chofer.deficitPromedio}");
            });
  }
}
