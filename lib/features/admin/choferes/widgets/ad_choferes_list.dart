import 'package:cargocontrol/common_widgets/cargo_card.dart';
import 'package:cargocontrol/common_widgets/loading_sheet.dart';
import 'package:cargocontrol/features/choferes/controller/choferes_list_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

@override
class AdChoferesList extends ConsumerStatefulWidget {
  const AdChoferesList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdChoferesListState();
}

class _AdChoferesListState extends ConsumerState<AdChoferesList> {

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: ListView.builder(
          itemCount: 10,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return const CargoCard(
                topLeftText: "ID 123456",
                topRightText: "Viajes 0",
                titleText: "Intento- 0.0",
                bottomLeftText: "Deficit 0.0",
                bottomRightText:
                "Retraso Promedio : 0.0");

          }),
    );
  }
}
