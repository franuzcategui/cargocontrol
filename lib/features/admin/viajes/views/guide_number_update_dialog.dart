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

class GuideNumberUpdateDialog extends StatefulWidget {
  const GuideNumberUpdateDialog({
    super.key,
    required this.viajesModel,
  });
  final ViajesModel viajesModel;

  @override
  State<GuideNumberUpdateDialog> createState() =>
      _GuideNumberUpdateDialogState();
}

class _GuideNumberUpdateDialogState extends State<GuideNumberUpdateDialog> {
  TextEditingController guideNumberCtr = TextEditingController();

  @override
  void initState() {
    guideNumberCtr.text = widget.viajesModel.guideNumber.toInt().toString();
    super.initState();
  }

  @override
  void dispose() {
    guideNumberCtr.dispose();
    super.dispose();
  }

  updateGuideNumber({required WidgetRef ref}) async {
    try {
      ViajesModel currentViajesModel = widget.viajesModel;

      // Step 1: Get Industry model if the guide model is valid else return.
      IndustrySubModel? updatedIndustryModel = await getIndustryModel(ref: ref);
      if (updatedIndustryModel == null) {
        /// No Industry Found / Guide no. is used!
        showToast(
            msg: 'No se encontró ninguna industria / Guía no. esta usado!',
            textColor: MyColors.red);
        return;
      }

      // Step 2: get current Vesesel Model
      VesselModel currentVesselModel =
          ref.read(viajesUpdateNotiControllerProvider).vesselModel!;

      //Step 3: get current industry model
      IndustrySubModel currentIndustrySubModel =
          ref.read(viajesUpdateNotiControllerProvider).currentIndustryModel!;

      print(currentIndustrySubModel.industryName);
      print(updatedIndustryModel.industryName);

      //Step 4:  from current industry model  --remove guide no,--remove viajes id, -- minus unloading cargo, -- minus defit, -- minus selected vessel cargo peso unloaded
      currentIndustrySubModel = ref
          .read(viajesUpdateNotiControllerProvider)
          .updateCurrentInustrySubModel(
              currentIndustrySubModel, widget.viajesModel);


      //Step 5:  from updated industry model  --add guide no,--add viajes id, -- add unloading cargo, -- add  defit, -- add  selected vessel cargo peso unloaded ///if it exceeds the quantity then show error,
     print(updatedIndustryModel.cargoUnloaded);
      updatedIndustryModel = ref
          .read(viajesUpdateNotiControllerProvider)
          .updateOtherInustrySubModel(updatedIndustryModel, widget.viajesModel,double.parse(guideNumberCtr.text));
      if(currentIndustrySubModel.industryId==updatedIndustryModel.industryId ) {
       updatedIndustryModel = updatedIndustryModel.copyWith(
         cargoUnloaded:  updatedIndustryModel.cargoUnloaded - (currentViajesModel.cargoUnloadWeight -
             currentViajesModel.entryTimeTruckWeightToPort)
       );
      }
      print(updatedIndustryModel.cargoUnloaded);
      print(updatedIndustryModel.cargoAssigned);

      if(updatedIndustryModel.cargoUnloaded > updatedIndustryModel.cargoAssigned){
        showToast(msg: "Cargo Exceed the assigned limit of Industry",textColor: MyColors.red);
        return ;
      }
      //Step 6:  from cargohold id related to current industry model cargo hold -- minus the peso unloaded,
      currentVesselModel = ref
          .read(viajesUpdateNotiControllerProvider)
          .removeWeightInVesselCargo(
              originalModel: currentVesselModel,
              updatedCargoModel: currentIndustrySubModel.selectedVesselCargo,
              cargoWeight: currentViajesModel.exitTimeTruckWeightToPort -
                  currentViajesModel.entryTimeTruckWeightToPort);
      //Step 7:  from cargohold id related to updated industry model cargo hold -- add the peso unloaded,
      currentVesselModel = ref
          .read(viajesUpdateNotiControllerProvider)
          .addWeightInVesselCargo(
              originalModel: currentVesselModel,
              updatedCargoModel: updatedIndustryModel.selectedVesselCargo,
              cargoWeight: currentViajesModel.exitTimeTruckWeightToPort -
                  currentViajesModel.entryTimeTruckWeightToPort);
      //Step 8 : in Viajes model update --guide number,cargo hold, industry id, real industry id, industry name
      currentViajesModel = currentViajesModel.copyWith(
          guideNumber: double.parse(guideNumberCtr.text),
          industryId: updatedIndustryModel.industryId,
          realIndustryId: updatedIndustryModel.realIndustryId,
          industryName: updatedIndustryModel.industryName,
          cargoId: updatedIndustryModel.cargoHoldId,
          cargoHoldCount: currentVesselModel.cargoModels.indexWhere(
              (cargoModel) =>
                  cargoModel.cargoId == updatedIndustryModel!.cargoHoldId) +1,);
      // Step 9: update all four models.
      ref.read(viajesControllerProvider.notifier).updateVaijesModels(
          viajesModel: currentViajesModel,
          vesselModel: currentVesselModel,
          currentIndustryModel: currentIndustrySubModel,
          updatedIndustryModel: updatedIndustryModel,
          ref: ref,
          context: context);
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<IndustrySubModel?> getIndustryModel({required WidgetRef ref}) async {
    await ref
        .read(viajesUpdateNotiControllerProvider)
        .getCurrentVessel(ref: ref);
    await ref.read(viajesUpdateNotiControllerProvider).getCurrentIndustry(
        industryId: widget.viajesModel.industryId, ref: ref);
    await ref.read(viajesUpdateNotiControllerProvider).getAllIndustriesModel();
    await ref
        .read(viajesUpdateNotiControllerProvider)
        .getIndusytryFromGuideNumber(
            guideNumber: double.parse(guideNumberCtr.text));
    if (ref.read(viajesUpdateNotiControllerProvider).industryMatched) {
      return ref.read(viajesUpdateNotiControllerProvider).selectedIndustry;
    } else {
      return null;
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
              'Número de guía actualizado',
              textAlign: TextAlign.left,
              style: getRegularStyle(
                  color: context.textColor, fontSize: MyFonts.size16),
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomTextField(
              controller: guideNumberCtr,
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
                        if(guideNumberCtr.text.isEmpty){
                          return;
                        }
                        await updateGuideNumber(ref: ref);
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
