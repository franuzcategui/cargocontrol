import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';
import '../features/coordinator/register_truck_movement/controllers/truck_registration_controller.dart';
import '../features/industry/register_truck_movements/controllers/in_truck_registration_controller.dart';

class CargaWidget extends StatelessWidget {
  const CargaWidget({Key? key, required this.viajesModel}) : super(key: key);
  final ViajesModel viajesModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Carga", style: getBoldStyle(
          color: context.textColor,
          fontSize: MyFonts.size14,
        ),),
        SizedBox(height: 28.h,),
        CustomTile(
            title: "Producto (Variedad)",
            subText: viajesModel.productName
        ),
        if( viajesModel.exitTimeTruckWeightToPort!=0.0)
        CustomTile(
            title: "Peso bruto de salida",
            subText: viajesModel.exitTimeTruckWeightToPort.toString()
        ),
        if( viajesModel.cargoUnloadWeight!=0.0)

          CustomTile(
            title: "Peso bruto de llegada",
            subText: viajesModel.cargoUnloadWeight.toString()
        ),
        if( viajesModel.entryTimeTruckWeightToPort!=0.0)

          CustomTile(
            title: "Peso tara ",
            subText: viajesModel.entryTimeTruckWeightToPort.toString()
        ),
        if( viajesModel.cargoUnloadWeight!=0.0)
          CustomTile(
            title: "Peso neto de llegada",
            subText:(viajesModel.cargoUnloadWeight - viajesModel.entryTimeTruckWeightToPort).toString()
        ),
        if( viajesModel.cargoUnloadWeight!=0.0)
       CustomTile(
            title: "Deficit de chofer",
            subText: (viajesModel.exitTimeTruckWeightToPort -viajesModel.cargoUnloadWeight ).toString(),
          isGoodSign: true,
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ref
                .watch(getIndustriaIndustryByIndustryId(viajesModel.industryId))
                .when(
              data: (industryModel) {
                return CustomTile(
                  title: "Deficit promedio industria",
                  subText: industryModel.deficit.toString(),
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



      ],
    );
  }
}
