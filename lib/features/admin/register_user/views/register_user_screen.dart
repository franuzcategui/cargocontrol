import 'package:cargocontrol/commons/common_functions/validator.dart';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_appbar.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/enums/account_type.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_industry/controllers/ad_industry_noti_controller.dart';
import 'package:cargocontrol/features/auth/controllers/auth_controller.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:cargocontrol/common_widgets/main_text_button.dart';

import '../../../../commons/common_widgets/custom_dropdown.dart';

class RegisterUserScreen extends ConsumerStatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  ConsumerState<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends ConsumerState<RegisterUserScreen> {

  final formKey  = GlobalKey<FormState>();
  final emailCtr = TextEditingController();
  final passCtr = TextEditingController();
  final accountTypeCtr = TextEditingController();
  final industryNameCtr = TextEditingController();

  AccountTypeEnum? accountTypeEnum;
  bool isIndustry = false;
  String? industryName;
  String? industryId;



  
  @override
  void initState() {
    super.initState();
    initiallization();
  }
  
  initiallization(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      await ref.read(adIndustryNotiController).getAllIndustriesModel();
    });
  }

  @override
  void dispose() {
    emailCtr.dispose();
    passCtr.dispose();
    accountTypeCtr.dispose();
    industryNameCtr.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context, ) {

    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: constants.kMainBackroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(constants.Images.logo, width: 290.w, height: 78.h,),
            Container(
              padding: EdgeInsets.all(20.sp),
              margin: EdgeInsets.all(20.sp),
              decoration: constants.DecorationStyles.shadow1,
              child:
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Row(
                    children: [
                      Text(
                        'Registro de usuario',
                        style: getRegularStyle(color: context.text3Color),
                      ),
                      SizedBox(
                        width: 20.h,
                      ),
                      Expanded(
                        child: Container(
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: context.brandColor,
                            borderRadius: BorderRadius.circular(24.r)
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  CustomDropDown(
                      ctr: accountTypeCtr,
                      list: const [
                        "administrador",
                        "coordinator",
                        "industria",
                      ],
                      labelText: "Tipo de usuario",
                    onChange: (val){
                      accountTypeEnum = (val as String).toAccountTypeEnum();
                      accountTypeCtr.text = val;
                        if(val == AccountTypeEnum.industria.type){
                          setState(() {
                            isIndustry = true;
                          });
                        }else{
                          setState(() {
                            isIndustry = false;
                          });
                        }

                    },
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  isIndustry ?
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      return Column(
                        children: [
                          CustomDropDown(
                            ctr: industryNameCtr,
                            list: ref.read(adIndustryNotiController).industryNames,
                            labelText: "Industrias",
                            onChange: (String val){
                              if(val != ''){
                                ref.read(adIndustryNotiController).allIndustriesModels.forEach((element) {
                                  if(element.industryName == val){
                                    setState(() {
                                      industryName = element.industryName;
                                      industryId = element.industryId;
                                    });
                                  }
                                });
                              }
                            },
                          ),
                          SizedBox(
                            height: 13.h,
                          ),
                        ],
                      );
                    },

                  ): const SizedBox.shrink(),

                  CustomTextField(
                      controller: emailCtr,
                      hintText: "",
                      onChanged: (val){},
                      onFieldSubmitted: (val){},
                      obscure: false,
                      validatorFn: emailValidator,
                      label: "correo electrónico"
                  ),
                  CustomTextField(
                      controller: passCtr,
                      hintText: "",
                      onChanged: (val){},
                      onFieldSubmitted: (val){},
                      obscure: false,
                      validatorFn: sectionValidator,
                      label: "contraseña"
                  ),
                  const SizedBox(
                    height: 60,
                  )
                ]),
              ),
            ),
            //Log in buttons
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return CustomButton(
                  isLoading: ref.watch(authControllerProvider),
                  onPressed: ()async{
                      if(formKey.currentState!.validate()){
                        await ref.read(authControllerProvider.notifier).registerWithEmailAndPassword(
                            email: emailCtr.text,
                            password: passCtr.text ,
                            industryName: industryName,
                            industryId: industryId,
                            accountTypeEnum: accountTypeEnum ?? AccountTypeEnum.administrador,
                            context: context
                        );
                      }else{

                      }
                    },
                    buttonText: "REGISTRO"
                );
              },

            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w ),
              child: MainTextButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: 'REGRESAR',
                  buttonStyle: ButtonThemeStyle.secondary),
            ),
          ],
        ),
      ),
    );
  }
}
