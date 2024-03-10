import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/manage_ships/controllers/ship_controller.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_button.dart';
import '../../../../commons/common_widgets/show_toast.dart';
import '../../../../models/vessel_models/vessel_cargo_model.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/constants/font_manager.dart';
import '../../../coordinator/register_truck_movement/controllers/truck_registration_noti_controller.dart';
import '../controllers/viajes_controller.dart';
import '../controllers/viajes_update_noti_controller.dart';

class ExitPortWeightUpdateDialog extends StatefulWidget {
  const ExitPortWeightUpdateDialog({
    super.key,
    required this.viajesModel,
  });
  final ViajesModel viajesModel;

  @override
  State<ExitPortWeightUpdateDialog> createState() =>
      _ExitPortWeightUpdateDialogState();
}

class _ExitPortWeightUpdateDialogState
    extends State<ExitPortWeightUpdateDialog> {
  TextEditingController exitPortWeightCtr = TextEditingController();

  @override
  void initState() {
    exitPortWeightCtr.text =
        widget.viajesModel.exitTimeTruckWeightToPort.toInt().toString();
    super.initState();
  }

  @override
  void dispose() {
    exitPortWeightCtr.dispose();
    super.dispose();
  }

  update({required WidgetRef ref}) async {
    try {
      double exitTruckWeightAtPort = double.parse(exitPortWeightCtr.text);
      if (exitTruckWeightAtPort <
          widget.viajesModel.entryTimeTruckWeightToPort) {
        showToast(msg: "Peso bruto cannot be less than peso tara!");
        return;
      }
      if (exitTruckWeightAtPort < widget.viajesModel.cargoUnloadWeight) {
        showToast(msg: "Peso bruto cannot be less than peso unloading!");
        return;
      }
      ViajesModel currentViajesModel = widget.viajesModel;

      await getIndustryModel(ref: ref);

      // Step 2: get current Vesesel Model
      VesselModel currentVesselModel =
          ref.read(viajesUpdateNotiControllerProvider).vesselModel!;

      //Step 3: get current industry model
      IndustrySubModel currentIndustrySubModel =
          ref.read(viajesUpdateNotiControllerProvider).currentIndustryModel!;

      //Step 4: get this weight is valid.
      IndustrySubModel checkIndustrySubModel = ref
          .read(viajesUpdateNotiControllerProvider)
          .updateExitWeightIndustrySubModel(currentIndustrySubModel,
              currentViajesModel, exitTruckWeightAtPort);
      if (checkIndustrySubModel.cargoUnloaded >
          checkIndustrySubModel.cargoAssigned) {
        showToast(
            msg: "Cargo Exceed the assigned limit of Industry",
            textColor: MyColors.red);
        return;
      }
      //Step 5: update the industry deficit
      currentIndustrySubModel = currentIndustrySubModel.copyWith(
          deficit: currentIndustrySubModel.deficit -
              currentViajesModel.cargoDeficitWeight +
              (exitTruckWeightAtPort - currentViajesModel.cargoUnloadWeight));
      //Step 6:  update vessel model
      currentVesselModel = ref
          .read(viajesUpdateNotiControllerProvider)
          .updateExitWeightInVesselCargo(
              originalModel: currentVesselModel,
              updatedCargoModel: currentIndustrySubModel.selectedVesselCargo,
              exitTruckWeightMinusPeroTara: exitTruckWeightAtPort -
                  currentViajesModel.entryTimeTruckWeightToPort,
              oldExitTruckWeightMinusPeroTara:
                  currentViajesModel.exitTimeTruckWeightToPort -
                      currentViajesModel.entryTimeTruckWeightToPort);
      //Step 8 : in Viajes model update -exitPortWeight, deificit, pure cargo weight
      currentViajesModel = currentViajesModel.copyWith(
        exitTimeTruckWeightToPort: exitTruckWeightAtPort,
        cargoDeficitWeight:
            exitTruckWeightAtPort - currentViajesModel.cargoUnloadWeight,
        pureCargoWeight: exitTruckWeightAtPort -
            currentViajesModel.entryTimeTruckWeightToPort,
      );
      //Step 9: update all four models.
      ref
          .read(viajesControllerProvider.notifier)
          .updateVaijesModelsForWeightUpdate(
              viajesModel: currentViajesModel,
              vesselModel: currentVesselModel,
              currentIndustryModel: currentIndustrySubModel,
              ref: ref,
              context: context);
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<void> getIndustryModel({required WidgetRef ref}) async {
    await ref
        .read(viajesUpdateNotiControllerProvider)
        .getCurrentVessel(ref: ref);
    await ref.read(viajesUpdateNotiControllerProvider).getCurrentIndustry(
        industryId: widget.viajesModel.industryId, ref: ref);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20.h),
        decoration: BoxDecoration(
          color: context.scaffoldBackgroundColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              // spreadRadius: 12,
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(AppAssets.dialogCloseIcon,
                      width: 38.w, height: 38.h),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Peso bruto de salida',
              textAlign: TextAlign.left,
              style: getRegularStyle(
                  color: context.textColor, fontSize: MyFonts.size16),
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomTextField(
              controller: exitPortWeightCtr,
              hintText: "",
              onChanged: (val) {},
              onFieldSubmitted: (val) {},
              obscure: false,
              inputType: TextInputType.number,
              onlyNumber: true,
              label: "",
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      buttonWidth: 112.w,
                      buttonHeight: 42.h,
                      backColor: context.secondaryMainColor,
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      buttonText: 'Cancel',
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    CustomButton(
                      isLoading: ref.watch(viajesControllerProvider),
                      buttonWidth: 112.w,
                      buttonHeight: 42.h,
                      onPressed: () async {
                        if (exitPortWeightCtr.text.isEmpty) {
                          return;
                        }
                        await update(ref: ref);
                        Navigator.pop(context);
                      },
                      buttonText: 'Update',
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
