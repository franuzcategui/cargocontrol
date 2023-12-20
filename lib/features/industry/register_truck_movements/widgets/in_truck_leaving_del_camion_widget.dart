import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../utils/constants/font_manager.dart';
import '../controllers/in_truck_registration_noti_controller.dart';

class InTruckLeavingDelCamionWidget extends ConsumerStatefulWidget {
  final double cargoUnloadWeight;
  const InTruckLeavingDelCamionWidget({Key? key, required this.cargoUnloadWeight}) : super(key: key);

  @override
  ConsumerState<InTruckLeavingDelCamionWidget> createState() => _InTruckLeavingDelCamionWidgetState();
}

class _InTruckLeavingDelCamionWidgetState extends ConsumerState<InTruckLeavingDelCamionWidget> {


  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        ViajesModel model = ref.watch(inTruckRegistrationNotiControllerProvider).matchedViajes!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Información del camión", style: getBoldStyle(
              color: context.textColor,
              fontSize: MyFonts.size14,
            ),),
            SizedBox(height: 28.h,),

            //
            CustomTile(
                title: "Placa",
                subText: model.licensePlate
            ),
            CustomTile(
                title: "Nombre de chofer",
                subText: model.chofereName
            ),
            CustomTile(
                title: "Producto",
                subText: '${ref.read(inTruckRegistrationNotiControllerProvider).vesselCargoModel?.productName}'
                    ' ${ref.read(inTruckRegistrationNotiControllerProvider).vesselCargoModel?.tipo} '
                    '${ref.read(inTruckRegistrationNotiControllerProvider).vesselCargoModel?.variety} '
                    '${ref.read(inTruckRegistrationNotiControllerProvider).vesselCargoModel?.origen} '

            ),
            CustomTile(
                title: "Número de bodega",
                subText: model.cargoId
            ),
            CustomTile(
                title: "Peso tara",
                subText: model.entryTimeTruckWeightToPort.toString()
            ),
            CustomTile(
                title: "Peso bruto de salida",
                subText: model.exitTimeTruckWeightToPort.toString()
            ),
            CustomTile(
                title: "Peso bruto de llegada",
                subText: widget.cargoUnloadWeight.toString()
            ),
          ],
        );
      },

    );
  }
}
