import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/manage_ships/controllers/ship_controller.dart';
import 'package:cargocontrol/features/admin/manage_ships/widgets/ships_bottom_sheet.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/app_constants.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:cargocontrol/utils/loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AdShipCard extends StatelessWidget {
  const AdShipCard({
    super.key,
    required this.vesselModel,
  });
  final VesselModel vesselModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      child: GestureDetector(
        onTap: () {
          if (!vesselModel.isFinishedUnloading) {
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                elevation: 0,
                context: context,
                isDismissible: true,
                builder: (context) => ShipsBottomSheet(
                      vesselModel: vesselModel,
                    ));
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          decoration: constants.DecorationStyles.shadow2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    vesselModel.entryPort,
                    style: getBoldStyle(
                        color: context.textColor, fontSize: MyFonts.size12),
                  ),
                  Row(
                    children: [
                      Text(
                        'Fecha de salida: ',
                        style: getRegularStyle(
                            color: context.textColor, fontSize: MyFonts.size12),
                      ),
                      Text(
                        vesselModel.isFinishedUnloading
                            ? DateFormat('MM/dd/yy')
                                .format(vesselModel.exitDate)
                            : 'En puerto',
                        style: getBoldStyle(
                            color: context.textColor, fontSize: MyFonts.size12),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 14.h,
              ),
              Text(
                vesselModel.vesselName,
                style: getRegularStyle(
                    color: context.textColor, fontSize: MyFonts.size14),
              ),
              SizedBox(
                height: 14.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    vesselModel.shipper,
                    style: getRegularStyle(
                        color: context.textColor, fontSize: MyFonts.size12),
                  ),
                  Consumer(builder: (context, ref, child) {
                    return ref.watch(shipControllerProvider)
                        ? LoadingWidget(
                            color: context.mainColor,
                          )
                        : InkWell(
                            onTap: () async {
                              await ref
                                  .read(shipControllerProvider.notifier)
                                  .createReports(
                                      vesselModel: vesselModel,
                                      ref: ref,
                                      context: context);
                            },
                            child: Text(
                              'Descargar',
                              style: getBoldStyle(
                                  color: context.mainColor,
                                  fontSize: MyFonts.size12),
                            ),
                          );
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
