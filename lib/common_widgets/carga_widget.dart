import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/controllers/ad_vessel_controller.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';
import '../features/admin/create_vessel/widgets/custom_editable_tile.dart';
import '../features/coordinator/register_truck_movement/controllers/truck_registration_controller.dart';
import '../features/industry/register_truck_movements/controllers/in_truck_registration_controller.dart';

class CargaWidget extends StatelessWidget {
  const CargaWidget(
      {Key? key,
      required this.viajesModel,
      this.isEditable = false,
      this.onTruckWeightEdit,
      this.onExitPortWeightEdit,
      this.onIndustryUnloadingWeightEdit})
      : super(key: key);
  final ViajesModel viajesModel;
  final bool isEditable;
  final Function()? onTruckWeightEdit;
  final Function()? onExitPortWeightEdit;
  final Function()? onIndustryUnloadingWeightEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Carga",
          style: getBoldStyle(
            color: context.textColor,
            fontSize: MyFonts.size14,
          ),
        ),
        SizedBox(
          height: 28.h,
        ),
        CustomTile(
            title: "Producto (Variedad)", subText: viajesModel.productName),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ref
                .watch(getIndustriaIndustryByIndustryId(viajesModel.industryId))
                .when(
              data: (industryModel) {
                return Column(
                  children: [
                    CustomTile(
                      title: "Tipo",
                      subText: industryModel.selectedVesselCargo.tipo,
                    ),
                    CustomTile(
                      title: "Origen",
                      subText: industryModel.selectedVesselCargo.origen,
                    ),
                    CustomTile(
                      title: "Variedad",
                      subText: industryModel.selectedVesselCargo.variety,
                    ),
                    CustomTile(
                      title: "Cosecha",
                      subText: industryModel.selectedVesselCargo.cosecha,
                    ),
                  ],
                );
              },
              error: (error, st) {
                debugPrintStack(stackTrace: st);
                debugPrint(error.toString());
                return const SizedBox();
              },
              loading: () {
                return const SizedBox();
              },
            );
          },
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ref.watch(fetchCurrentVesselsProvider).when(
              data: (vesselModel) {
                return Column(
                  children: [
                    CustomTile(
                        title: "Procedencia", subText: vesselModel.entryPort),
                  ],
                );
              },
              error: (error, st) {
                debugPrintStack(stackTrace: st);
                debugPrint(error.toString());
                return const SizedBox();
              },
              loading: () {
                return const SizedBox();
              },
            );
          },
        ),
        if (viajesModel.entryTimeTruckWeightToPort != 0.0) ...[
          if (!isEditable)
            CustomTile(
                title: "Peso tara ",
                subText: viajesModel.entryTimeTruckWeightToPort.toString()),
          if (isEditable)
            CustomEditableTile(
              title: "Peso tara ",
              subText: viajesModel.entryTimeTruckWeightToPort.toString(),
              onTap: onTruckWeightEdit!,
            ),
        ],
        if (viajesModel.exitTimeTruckWeightToPort != 0.0) ...[
          if (!isEditable)
            CustomTile(
                title: "Peso bruto de salida",
                subText: viajesModel.exitTimeTruckWeightToPort.toString()),
          if (isEditable)
            CustomEditableTile(
              title: "Peso bruto de salida",
              subText: viajesModel.exitTimeTruckWeightToPort.toString(),
              onTap: onExitPortWeightEdit!,
            ),
        ],
        if (viajesModel.exitTimeTruckWeightToPort != 0.0)
          CustomTile(
              title: "Total de carga inicial",
              subText: (viajesModel.exitTimeTruckWeightToPort -
                      viajesModel.entryTimeTruckWeightToPort)
                  .toString()),
        if (viajesModel.cargoUnloadWeight != 0.0) ...[
          if (!isEditable)
            CustomTile(
                title: "Peso bruto de llegada",
                subText: viajesModel.cargoUnloadWeight.toString()),
          if (isEditable)
            CustomEditableTile(
              title: "Peso bruto de llegada",
              subText: viajesModel.cargoUnloadWeight.toString(),
              onTap: onIndustryUnloadingWeightEdit!,
            ),
        ],
        if (viajesModel.cargoUnloadWeight != 0.0)
          CustomTile(
              title: "Total de carga final",
              subText: (viajesModel.cargoUnloadWeight -
                      viajesModel.entryTimeTruckWeightToPort)
                  .toString()),
        if (viajesModel.cargoUnloadWeight != 0.0) ...[
          CustomTile(
            title: "Pérdida de viaje (kg)",
            subText: (viajesModel.cargoUnloadWeight -
                    viajesModel.exitTimeTruckWeightToPort)
                .toString(),
            isGoodSign: true,
          ),
          CustomTile(
            title: "Pérdida de viaje (%)",
            subText:
                "${(((viajesModel.cargoUnloadWeight - viajesModel.entryTimeTruckWeightToPort) - (viajesModel.exitTimeTruckWeightToPort - viajesModel.entryTimeTruckWeightToPort)) / (viajesModel.exitTimeTruckWeightToPort - viajesModel.entryTimeTruckWeightToPort)).toStringAsFixed(2)}%",
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return ref
                  .watch(
                      getIndustriaIndustryByIndustryId(viajesModel.industryId))
                  .when(
                data: (industryModel) {
                  return CustomTile(
                    title: "Deficit promedio industria",
                    subText:
                        "${"-" + (industryModel.deficit / (industryModel.cargoUnloaded + industryModel.deficit)).toStringAsFixed(2)}%",
                    isGoodSign: true,
                  );
                },
                error: (error, st) {
                  debugPrintStack(stackTrace: st);
                  debugPrint(error.toString());
                  return const SizedBox();
                },
                loading: () {
                  return const SizedBox();
                },
              );
            },
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return ref
                  .watch(getChoferModelByNationalId(viajesModel.chofereId))
                  .when(
                data: (model) {
                  return CustomTile(
                    title: "Deficit promedio de chofer",
                    subText: model.averageCargoDeficit.toString(),
                    isGoodSign: true,
                  );
                },
                error: (error, st) {
                  debugPrintStack(stackTrace: st);
                  debugPrint(error.toString());
                  return const SizedBox();
                },
                loading: () {
                  return const SizedBox();
                },
              );
            },
          ),
        ]
      ],
    );
  }
}
