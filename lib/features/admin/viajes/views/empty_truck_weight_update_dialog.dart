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
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/constants/font_manager.dart';
import '../../../coordinator/register_truck_movement/controllers/truck_registration_noti_controller.dart';
import '../controllers/viajes_controller.dart';
import '../controllers/viajes_update_noti_controller.dart';

class EmptyTruckWeightWeightUpdateDialog extends StatefulWidget {
  const EmptyTruckWeightWeightUpdateDialog({
    super.key,
    required this.viajesModel,
  });
  final ViajesModel viajesModel;

  @override
  State<EmptyTruckWeightWeightUpdateDialog> createState() =>
      _EmptyTruckWeightWeightUpdateDialogState();
}

class _EmptyTruckWeightWeightUpdateDialogState
    extends State<EmptyTruckWeightWeightUpdateDialog> {
  TextEditingController emptyTruckWeightCtr = TextEditingController();

  @override
  void initState() {
    emptyTruckWeightCtr.text =
        widget.viajesModel.entryTimeTruckWeightToPort.toString();
    super.initState();
  }

  @override
  void dispose() {
    emptyTruckWeightCtr.dispose();
    super.dispose();
  }

  update({required WidgetRef ref}) async {
    try {
      double pesoTara = double.parse(emptyTruckWeightCtr.text);
      if (pesoTara < 1) {
        showToast(msg: "Invalid Weight");
        return;
      }
      ViajesModel viajesModel = widget.viajesModel;
      double updatedExitTimeTruckWeightToPort =
          viajesModel.exitTimeTruckWeightToPort -
              viajesModel.entryTimeTruckWeightToPort +
              pesoTara;
      double updatedCargoUnloadWeight = viajesModel.cargoUnloadWeight -
          viajesModel.entryTimeTruckWeightToPort +
          pesoTara;

      viajesModel = viajesModel.copyWith(
        entryTimeTruckWeightToPort: pesoTara,
        exitTimeTruckWeightToPort: updatedExitTimeTruckWeightToPort,
        cargoUnloadWeight: updatedCargoUnloadWeight,
      );

      ref
          .read(viajesControllerProvider.notifier)
          .updateVaijesModel(viajesModel: viajesModel, ref: ref);
    } catch (e) {
      showToast(msg: e.toString());
    }
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
              'Peso tara',
              textAlign: TextAlign.left,
              style: getRegularStyle(
                  color: context.textColor, fontSize: MyFonts.size16),
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomTextField(
              controller: emptyTruckWeightCtr,
              hintText: "",
              onChanged: (val) {},
              onFieldSubmitted: (val) {},
              obscure: false,
              inputType: TextInputType.number,
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
