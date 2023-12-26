import 'package:cargocontrol/commons/common_functions/validator.dart';
import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/enums/weight_unit_enum.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/bodega_section_widget.dart';
import 'package:cargocontrol/models/vessel_models/vessel_cargo_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:uuid/uuid.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_header.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../commons/common_widgets/custom_dropdown.dart';
import '../../../../commons/common_widgets/show_toast.dart';

class CreateVesselBodegaInfoScreen extends StatefulWidget {
  final String vesselName;
  final String procedencia;
  final String shipper;
  final String unCode;
  final DateTime portDate;
  final WeightUnitEnum weightUnitEnum;
  const CreateVesselBodegaInfoScreen({Key? key, required this.vesselName, required this.procedencia, required this.shipper, required this.unCode, required this.portDate, required this.weightUnitEnum}) : super(key: key);

  @override
  State<CreateVesselBodegaInfoScreen> createState() => _CreateVesselBodegaInfoScreenState();
}

class _CreateVesselBodegaInfoScreenState extends State<CreateVesselBodegaInfoScreen> {
  List<_BodegaInfoControllers> _bodegaInfoControllers = [];
  List<Widget> _productDropDown = [];
  List<Widget> _varietyDropDown = [];
  List<Widget> _weights = [];
  List<Widget> _origins = [];
  List<Widget> _tipos = [];
  List<Widget> _cosechas = [];
  bool allGood = false;

  final formKey = GlobalKey<FormState>();



  createBodegaSection() {
    final section = _BodegaInfoControllers();
    final product =  CustomDropDown(ctr: section.productCtr, list: products, labelText: 'Producto',);
    final variety = CustomDropDown(ctr: section.varietyCtr, list: varieties, labelText: 'Variedad',);
    final origin = CustomDropDown(ctr: section.originCtr, list: originList, labelText: 'Origen',);
    final tipo = CustomDropDown(ctr: section.tipoCtr, list: tipoList, labelText: 'Tipo',);
    final cosecha = CustomDropDown(ctr: section.cosechaCtr, list: cosechaList, labelText: 'Cosecha',);
    final weight = CustomTextField(
      validatorFn: sectionValidator,
      controller: section.weightCtr,
      inputType: TextInputType.number,
      onTap: (){},
      hintText: "",
      label: 'Peso',
      onChanged: (val){},
      obscure: false,
      onFieldSubmitted: (val){},
    );
    setState(() {
      _bodegaInfoControllers.add(section);
      _productDropDown.add(product);
      _varietyDropDown.add(variety);
      _origins.add(origin);
      _tipos.add(tipo);
      _cosechas.add(cosecha);
      _weights.add(weight);
    });
  }

  Widget _bodegaSections() {
    final children = [
      for (var i = 0; i < _bodegaInfoControllers.length; i++)
        BodegaSectionWidget(
          formKey: formKey,
          index: i,
          productCtr: _bodegaInfoControllers[i].productCtr,
          cosechaCtr: _bodegaInfoControllers[i].cosechaCtr,
          originCtr: _bodegaInfoControllers[i].originCtr,
          tipoCtr: _bodegaInfoControllers[i].tipoCtr,
          varietyCtr: _bodegaInfoControllers[i].varietyCtr,
          onRemove: (){
            if(i ==0){

            }else{
              setState(() {
                _bodegaInfoControllers.removeAt(i);
                _productDropDown.removeAt(i);
                _varietyDropDown.removeAt(i);
                _cosechas.removeAt(i);
                _origins.removeAt(i);
                _tipos.removeAt(i);
                _weights.removeAt(i);
              });
            }

          },
          weightWidget: _weights[i],
        )
    ];
    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }

  List<String> products = [
    "Rice",
    "Corn",
    "piso",
    "Veggie"
  ];

  List<String> varieties = [
    "Rice",
    "Corn",
    "Veggie"
  ];

  List<String> tipoList = [
    "Grano Largo",
    "Grano corto",
  ];

  List<String> originList = [
    "Estados Unidos",
    "United Kingdom",
    "Spain"
  ];

  List<String> cosechaList = [
    "Vieja",
    "Nuevo",
  ];

  @override
  void initState() {
    super.initState();
    createBodegaSection();
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
              child: Column(
                children: [
                  SizedBox(height: 60.h,),
                  _bodegaSections(),
                  SizedBox(height: 15.h,),
                  CustomButton(
                      onPressed: createBodegaSection,
                      buttonText: "Generate New Section",
                    backColor: context.scaffoldBackgroundColor,
                    textColor: context.mainColor,
                  ),
                  CustomButton(
                      onPressed: (){
                        for (var section in _bodegaInfoControllers) {
                          if(section.weightCtr.text == "" || section.productCtr.text == "" ||
                              section.varietyCtr.text == "" || section.originCtr.text == "" ||
                              section.tipoCtr.text == "" || section.cosechaCtr.text == ""){
                            setState(() {
                              allGood = false;
                            });
                            showSnackBar(context: context,content:  "Fill All Fields!", duration: const Duration(milliseconds: 700) );
                            break;
                          }else{
                            setState(() {
                              allGood = true;
                            });
                          }
                        }

                        if(allGood){
                          List<VesselCargoModel> bogedaModels = [];
                          for (var section in _bodegaInfoControllers) {
                            final cargoId = Uuid().v4();
                            VesselCargoModel model = VesselCargoModel(
                              cargoId: cargoId,
                              cosecha: section.cosechaCtr.text,
                              origen: section.originCtr.text,
                              pesoTotal: double.parse(section.weightCtr.text),
                              pesoUnloaded: 0.0,
                              productName: section.productCtr.text,
                              tipo: section.tipoCtr.text,
                              variety: section.varietyCtr.text,
                            );
                            bogedaModels.add(model);

                          }
                          Navigator.pushNamed(
                              context,
                              AppRoutes.adminCreateVesselCompleteDataScreen,
                              arguments: {
                                'vesselName' : widget.vesselName,
                                'procedencia' : widget.procedencia,
                                'shipper' : widget.shipper,
                                'unCode' : widget.unCode,
                                'portDate' : widget.portDate,
                                'numberOfWines' : _bodegaInfoControllers.length,
                                'weightUnitEnum' : widget.weightUnitEnum,
                                'bogedaModels' : bogedaModels,
                              }
                          );
                        }
                      },
                      buttonText: "CONTINUAR"
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BodegaInfoControllers {
  TextEditingController weightCtr = TextEditingController();
  TextEditingController productCtr = TextEditingController();
  TextEditingController varietyCtr = TextEditingController();
  TextEditingController tipoCtr = TextEditingController();
  TextEditingController originCtr = TextEditingController();
  TextEditingController cosechaCtr = TextEditingController();




  void dispose() {
    weightCtr.dispose();
    productCtr.dispose();
    varietyCtr.dispose();
    tipoCtr.dispose();
    originCtr.dispose();
    cosechaCtr.dispose();
  }

  void clear() {
    weightCtr.clear();
    productCtr.clear();
    varietyCtr.clear();
    tipoCtr.clear();
    originCtr.clear();
    cosechaCtr.clear();
  }
}

