import 'package:cargocontrol/common_widgets/loading_sheet.dart';
import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_functions/validator.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/features/admin/choferes/controllers/choferes_controller.dart';
import 'package:cargocontrol/features/admin/choferes/controllers/choferes_noti_controller.dart';
import 'package:cargocontrol/features/choferes/components/add_chofer_button.dart';
import 'package:cargocontrol/features/choferes/components/chofer_text_field.dart';
import 'package:cargocontrol/features/choferes/components/id_text_field.dart';
import 'package:cargocontrol/features/choferes/controller/add_choferes_controller.dart';
import 'package:cargocontrol/features/choferes/controller/add_choferes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

class AddChoferesModal extends StatefulWidget {
  const AddChoferesModal({super.key});

  @override
  State<AddChoferesModal> createState() => _AddChoferesModalState();
}

class _AddChoferesModalState extends State<AddChoferesModal> {

  final nameCtr = TextEditingController();
  final identificationCtr = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TitleHeader(
          title: 'Agregar nuevo chofer',
          subtitle: 'Registrar a nuevo chofer',
        ),
        SizedBox(height: 20.h,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                    controller: nameCtr,
                    hintText: '',
                    onChanged: (val){},
                    onFieldSubmitted: (val){},
                    obscure: false,
                    validatorFn: sectionValidator,
                    label: 'Nombre de chofer'
                ),
                CustomTextField(
                    controller: identificationCtr,
                    hintText: '',
                    onChanged: (val){},
                    onFieldSubmitted: (val){},
                    obscure: false,
                    label: 'Identificación',
                  validatorFn: sectionValidator,
                  inputType: TextInputType.number,
                ),
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    return CustomButton(
                      isLoading: ref.watch(choferesControllerProvider),
                      onPressed: ()async{
                          if(formKey.currentState!.validate()){
                            await ref.read(choferesControllerProvider.notifier).
                            registerChofere(
                              firstName: nameCtr.text,
                              choferNationalId: identificationCtr.text,
                              context: context,
                              ref: ref,
                            );
                            await ref.read(choferesNotiController).firstTime();
                          }
                      },
                      buttonText: 'REGISTRAR'
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                ),
              ],
            ),
          ),
        )

      ],
    );
  }
}
