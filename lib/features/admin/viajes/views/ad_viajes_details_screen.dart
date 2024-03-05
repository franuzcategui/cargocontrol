import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/viajes/views/empty_truck_weight_update_dialog.dart';
import 'package:cargocontrol/features/admin/viajes/views/guide_number_update_dialog.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common_widgets/carga_widget.dart';
import '../../../../common_widgets/datos_generales_widget.dart';
import '../../../../common_widgets/tiempo_widget.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../controllers/viajes_completed_noti_controller.dart';
import '../controllers/viajes_controller.dart';
import '../controllers/viajes_inprogess_noti_controller.dart';
import '../controllers/viajes_noti_controller.dart';
import 'exit_port_weight_update_dialog.dart';
import 'industry_unloading_weight_update_dialog.dart';

class AdViajesDetailsScreen extends StatefulWidget {
  final ViajesModel viajesModel;
  const AdViajesDetailsScreen({Key? key, required this.viajesModel})
      : super(key: key);

  @override
  State<AdViajesDetailsScreen> createState() => _AdViajesDetailsScreenState();
}

class _AdViajesDetailsScreenState extends State<AdViajesDetailsScreen> {
  Future<void> guideNoUpdateDialog(
      BuildContext context, ViajesModel viajesModel, WidgetRef ref) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GuideNumberUpdateDialog(viajesModel: viajesModel);
      },
    ).then((value) async {
      await reloadAllViajes(ref);
    });
  }

  Future<void> emptyTruckWeightDialog(
      BuildContext context, ViajesModel viajesModel, WidgetRef ref) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return EmptyTruckWeightWeightUpdateDialog(viajesModel: viajesModel);
      },
    ).then((value) async {
      await reloadAllViajes(ref);
    });
  }
  Future<void> exitPortWeightEditDialog(
      BuildContext context, ViajesModel viajesModel, WidgetRef ref) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ExitPortWeightUpdateDialog(viajesModel: viajesModel);
      },
    ).then((value) async {
      await reloadAllViajes(ref);
    });
  }

  Future<void> industryUnloadingWeightEditDialog(
      BuildContext context, ViajesModel viajesModel, WidgetRef ref) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return IndustryUnloadingWeightUpdateDialog(viajesModel: viajesModel);
      },
    ).then((value) async {
      await reloadAllViajes(ref);
    });
  }

  Future<void> reloadAllViajes(WidgetRef ref) async {
    await Future.delayed(Duration(seconds: 5));
    await ref.read(viajesNotiController).firstTime(ref: ref);
    await ref.read(viajesInprogessNotiController).firstTime(ref: ref);
    await ref.read(viajesCompletedNotiController).firstTime(ref: ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ref
                .watch(getViajesModelFromViajesIdProvider(
                    widget.viajesModel.viajesId))
                .when(data: (viajesModel) {
              return Column(
                children: [
                  const TitleHeader(
                    title: "",
                    subtitle: "",
                    logo: true,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 14.h,
                        ),
                        Text(
                          "Datos del viaje de ${viajesModel.chofereName}",
                          style: getRegularStyle(
                              color: context.textColor,
                              fontSize: MyFonts.size16),
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                        Divider(
                          height: 1.h,
                          color: context.textFieldColor,
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                        DatosGeneralesWidget(
                          viajesModel: viajesModel,
                          onGuideNumberEdit: () =>
                              guideNoUpdateDialog(context, viajesModel, ref),
                          isEditable: true,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Divider(
                          height: 1.h,
                          color: context.textFieldColor,
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                        TiempoWidget(
                          viajesModel: viajesModel,
                          onEdit: () {
                            Navigator.pushNamed(
                                context, AppRoutes.adViajesTimeEditScreen,
                                arguments: {'viajesModel': viajesModel});
                          },
                          isEditable: true,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Divider(
                          height: 1.h,
                          color: context.textFieldColor,
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                        CargaWidget(
                          viajesModel: viajesModel,
                          isEditable: true,
                          onExitPortWeightEdit: () {
                            exitPortWeightEditDialog(context,viajesModel,ref);
                          },
                          onIndustryUnloadingWeightEdit: () {
                            industryUnloadingWeightEditDialog(context,viajesModel,ref);
                          },
                          onTruckWeightEdit: () {
                            emptyTruckWeightDialog(context,viajesModel,ref);
                          },
                        ),
                        SizedBox(
                          height: 26.h,
                        ),
                        CustomButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            backColor: context.secondaryMainColor,
                            buttonText: "REGRESAR"),
                        SizedBox(
                          height: 35.h,
                        )
                      ],
                    ),
                  )
                ],
              );
            }, error: (error, st) {
              //debugPrintStack(stackTrace: st);
              //debugPrint(error.toString());
              return SizedBox(
                height: 0.5.sh,
                child: Center(
                  child: Text(
                    "Error while loading data",
                    style: getRegularStyle(
                        color: context.textColor, fontSize: MyFonts.size16),
                  ),
                ),
              );
            }, loading: () {
              return SizedBox(
                height: 0.5.sh,
                child: Center(child: LoadingWidget()),
              );
            });
          },
        ),
      ),
    );
  }
}
