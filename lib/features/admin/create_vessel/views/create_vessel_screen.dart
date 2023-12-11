import 'package:cargocontrol/commons/common_functions/validator.dart';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/enums/weight_unit_enum.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';

import '../../../../common_widgets/title_header.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_datpicker.dart';
import '../../../../commons/common_widgets/common_header.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../commons/common_widgets/custom_dropdown.dart';
import '../../../../commons/common_widgets/wine_celler_widget.dart';
import '../controllers/ad_vessel_noti_controller.dart';

class CreateVesselScreen extends ConsumerStatefulWidget {
  const CreateVesselScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateVesselScreen> createState() => _CreateVesselScreenState();
}

class _CreateVesselScreenState extends ConsumerState<CreateVesselScreen> {
  final vesselNameCtr = TextEditingController();
  final procedenciaCtr = TextEditingController();
  final shipperCtr = TextEditingController();
  final dateCtr = TextEditingController();
  final unCodeCtr = TextEditingController();
  final weightUnitCtr = TextEditingController();
  final formKey = GlobalKey<FormState>();


  DateTime? portDate;
  int? numberOfWines;
  WeightUnitEnum? weightUnitEnum;



  @override
  void dispose() {
    vesselNameCtr.dispose();
    procedenciaCtr.dispose();
    shipperCtr.dispose();
    unCodeCtr.dispose();
    dateCtr.dispose();
    weightUnitCtr.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    initialization();
  }

  initialization()async{
    await Future.wait([
    ref.read(adVesselNotiController).getAllProducts(),
    ref.read(adVesselNotiController).getOrigins()
    ]);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonHeader(
              title: "Información del",
              subtitle: "buque" ,
              description: "Indique la información del buque a registrar",
            ),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: 20.w),
               child: Form(
                 key: formKey,
                 child: Column(
                   children: [
                     SizedBox(height: 60.h,),
                     CustomTextField(
                       controller: vesselNameCtr,
                       hintText: "",
                       label: "Nombre de buque",
                       onChanged: (val){},
                       onFieldSubmitted: (val){},
                       obscure: false,
                       validatorFn: sectionValidator,
                     ),
                     CustomTextField(
                       controller: procedenciaCtr,
                       hintText: "",
                       label: "Procedencia ",
                       onChanged: (val){},
                       onFieldSubmitted: (val){},
                       obscure: false,
                       validatorFn: sectionValidator,
                     ),
                     CustomTextField(
                       controller: shipperCtr,
                       hintText: "",
                       label: "Shipper ",
                       onChanged: (val){},
                       onFieldSubmitted: (val){},
                       obscure: false,
                       validatorFn: sectionValidator,
                     ),
                     CommonDatePicker(
                       labelText: "Fecha en puerto",
                       ctr: dateCtr,
                       selectedDate: (DateTime date){
                         portDate = date;
                       },
                     ),
                     CustomTextField(
                       controller: unCodeCtr,
                       hintText: "",
                       label: "UN/Locode",
                       onChanged: (val){},
                       onFieldSubmitted: (val){},
                       obscure: false,
                       validatorFn: sectionValidator,
                     ),
                     CustomDropDown(
                       ctr: weightUnitCtr,
                       list: const [
                         "Kg",
                         "Lb",
                       ],
                       labelText: "Unidad de peso",
                       onChange: (val){
                         weightUnitEnum = (val as String).toWeightUnitEnum();
                         weightUnitCtr.text = val as String;
                         setState(() {
                         });
                       },
                     ),
                     SizedBox(height: 14.h,),
                     NumberOfCargoHoldsWidget(
                       seletedCargosNumber: (int selectedValue){
                         numberOfWines = selectedValue;
                         print(numberOfWines);
                       },
                     ),
                     SizedBox(height: 45.h,),
                     CustomButton(
                         onPressed: (){
                           if(formKey.currentState!.validate()){
                             if(numberOfWines != null){
                               Navigator.pushNamed(
                                 context,
                                 AppRoutes.adminCreateVesselBodegaInfoScreen,
                                 arguments: {
                                   'vesselName' : vesselNameCtr.text,
                                   'procedencia' : procedenciaCtr.text,
                                   'shipper' : shipperCtr.text,
                                   'unCode' : unCodeCtr.text,
                                   'portDate' : portDate,
                                   'numberOfWines' : numberOfWines,
                                   'weightUnitEnum' : weightUnitEnum,
                                 }
                               );
                             }
                           }
                         },
                         buttonText: "CONTINUAR"
                     ),
                   ],
                 ),
               ),
             )
          ],
        ),
      ),
    );
  }
}

