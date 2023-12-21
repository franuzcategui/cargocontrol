import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/controllers/ad_vessel_noti_controller.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:uuid/uuid.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_header.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../commons/common_widgets/custom_dropdown.dart';
import '../../../../commons/common_widgets/show_toast.dart';
import '../../../../models/vessel_models/vessel_cargo_model.dart';
import '../widgets/industry_section_widget.dart';

class CreateIndustryInformationScreen extends ConsumerStatefulWidget {
  final int numberOfIndustries;
  const CreateIndustryInformationScreen({Key? key, required this.numberOfIndustries}) : super(key: key);

  @override
  ConsumerState<CreateIndustryInformationScreen> createState() => _CreateIndustryInformationScreenState();
}

class _CreateIndustryInformationScreenState extends ConsumerState<CreateIndustryInformationScreen> {
  List<_IndustryControllers> _industryControllers = [];
  List<Widget> _nameDropDowns = [];
  List<Widget> _productDropDowns = [];
  List<Widget> _comienzos = [];
  List<Widget> _endOfGuides = [];
  List<Widget> _loads = [];

  bool allGood = false;


  createIndustrySection() {
    final section = _IndustryControllers();
    final product =  CustomDropDown(ctr: section.nameCtr, list: names, labelText: 'Nombre',);
    final variety = CustomDropDown(ctr: section.productCtr, list: products, labelText: 'Producto (Variedad)',);
    final comenzio = CustomTextField(
      controller: section.comienzeCtr,
      onTap: (){},
      inputType: TextInputType.number,
      hintText: "",
      label: 'Comienzo de guia',
      onChanged: (val){},
      obscure: false,
      onFieldSubmitted: (val){},
    );
    final endOfGuide = CustomTextField(
      controller: section.endOfGuideCtr,
      onTap: (){},
      hintText: "",
      label: 'Final de guia',
      inputType: TextInputType.number,
      onChanged: (val){},
      obscure: false,
      onFieldSubmitted: (val){},
    );
    final load = CustomTextField(
      controller: section.loadCtr,
      onTap: (){},
      hintText: "",
      label: 'Carga asignada',
      onChanged: (val){},
      obscure: false,
      inputType: TextInputType.number,
      onFieldSubmitted: (val){},
    );
    setState(() {
      _industryControllers.add(section);
      _nameDropDowns.add(product);
      _productDropDowns.add(variety);
      _comienzos.add(comenzio);
      _endOfGuides.add(endOfGuide);
      _loads.add(load);
    });
  }

  Widget _industrySections() {
    final children = [
      for (var i = 0; i < _industryControllers.length; i++)
        IndustrySectionWidget(
          index: i,
          industryIdCtr: _industryControllers[i].industryIdCtr,
          cargoIdCtr: _industryControllers[i].cargoIdCtr,
          comenzoWIdget: _comienzos[i],
          endOfGuideWidget: _endOfGuides[i],
          loadWidget: _loads[i],
          industryNameCtr: _industryControllers[i].nameCtr,
          productNameCtr: _industryControllers[i].productCtr,
          onRemove: (){
            if(i ==0){

            }else{
              setState(() {
                _industryControllers.removeAt(i);
                _nameDropDowns.removeAt(i);
                _productDropDowns.removeAt(i);
                _comienzos.removeAt(i);
                _endOfGuides.removeAt(i);
                _loads.removeAt(i);
              });
            }

          },
        )
    ];
    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }

  List<String> names = [
    "C.A.C.S.A",
    "B.A.C.S.A",
    "D.A.C.S.A",
  ];

  List<String> products = [
    "Rice",
    "Corn",
    "Veggie"
  ];

  @override
  void initState() {
    super.initState();
    for(int i = 1; i <= widget.numberOfIndustries; i++){
      createIndustrySection();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonHeader(
              title: "Información de",
              subtitle: "industria" ,
              description: "Indique la información de la/s industria/s a registrar",
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 60.h,),
                  _industrySections(),
                  SizedBox(height: 15.h,),
                  CustomButton(
                    onPressed: createIndustrySection,
                    buttonText: "Generate New Section",
                    backColor: context.scaffoldBackgroundColor,
                    textColor: context.mainColor,
                  ),
                  CustomButton(
                      onPressed: (){
                        for (var section in _industryControllers) {
                          if(section.productCtr.text == "" || section.nameCtr.text == "" ||
                              section.endOfGuideCtr.text == "" || section.comienzeCtr.text == "" ||
                              section.loadCtr.text == "" ){
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


                        if (allGood) {
                          Map<VesselCargoModel, List<_IndustryControllers>> cargoSectionsMap = {};

                          for (var section in _industryControllers) {
                            VesselCargoModel? cargo;
                            ref.read(adVesselNotiController).vesselModel!.cargoModels.forEach((model) {
                              if (section.cargoIdCtr.text == model.cargoId) {
                                cargo = model;
                              }
                            });

                            if (cargo != null) {
                              // Check if cargo is already in the map
                              if (cargoSectionsMap.containsKey(cargo!)) {
                                cargoSectionsMap[cargo!]!.add(section);
                              } else {
                                cargoSectionsMap[cargo!] = [section];
                              }
                            }
                            // if (double.parse(section.loadCtr.text) > cargo!.pesoTotal) {
                            //   setState(() {
                            //     allGood = false;
                            //   });
                            //   showSnackBar(
                            //     context: context,
                            //     content: "Cannot Assign more than Cargo weight!",
                            //     duration: const Duration(milliseconds: 1000),
                            //   );
                            //   break;  // Exit the loop if one section exceeds cargo weight
                            // }
                          }

                          cargoSectionsMap.forEach((cargo, sections) {
                            double totalLoad = sections.fold(0, (sum, section) => sum + double.parse(section.loadCtr.text));
                            if (totalLoad > cargo.pesoTotal) {
                              setState(() {
                                allGood = false;
                              });
                              showSnackBar(
                                context: context,
                                content: "Total load exceeds Assigned Cargo weight! Limit is ${cargo.pesoTotal}",
                                duration: const Duration(milliseconds: 4000),
                              );
                            }
                          });

                          if (allGood) {
                            setState(() {
                              allGood = true;
                            });
                          }
                        }



                        if(allGood){
                          List<IndustrySubModel> industrySubModels = [];
                          for (var section in _industryControllers) {
                            VesselCargoModel? cargo;
                            ref.read(adVesselNotiController).vesselModel!.cargoModels.forEach((model) {
                              if (section.cargoIdCtr.text == model.cargoId) {
                                cargo = model;
                              }
                            });
                            final industryId = Uuid().v4();
                            IndustrySubModel model = IndustrySubModel(
                              vesselId: ref.read(adVesselNotiController).vesselModel?.vesselId ?? '',
                              vesselName: ref.read(adVesselNotiController).vesselModel?.vesselName ?? '',
                              usedGuideNumbers: [],
                              viajesIds: [],
                              industryId: industryId,
                              realIndustryId: section.industryIdCtr.text,
                              industryName: section.nameCtr.text,
                              selectedVesselCargo: cargo!,
                              finishedUnloading: false,
                              cargoAssigned: double.parse(section.loadCtr.text),
                              cargoUnloaded: 0,
                              initialGuide: double.parse(section.comienzeCtr.text),
                              lastGuide: double.parse(section.endOfGuideCtr.text),
                            );
                            industrySubModels.add(model);

                          }
                          Navigator.pushNamed(
                              context,
                              AppRoutes.adminCreateIndustryCompleteDataScreen,
                              arguments: {
                                'industrySubModels' : industrySubModels,
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

class _IndustryControllers {
  TextEditingController nameCtr = TextEditingController();
  TextEditingController comienzeCtr = TextEditingController();
  TextEditingController endOfGuideCtr = TextEditingController();
  TextEditingController productCtr = TextEditingController();
  TextEditingController loadCtr = TextEditingController();
  TextEditingController industryIdCtr = TextEditingController();
  TextEditingController cargoIdCtr = TextEditingController();
  void dispose() {
    nameCtr.dispose();
    comienzeCtr.dispose();
    endOfGuideCtr.dispose();
    productCtr.dispose();
    loadCtr.dispose();
    industryIdCtr.dispose();
    cargoIdCtr.dispose();
  }

  void clear() {
    nameCtr.clear();
    comienzeCtr.clear();
    endOfGuideCtr.clear();
    productCtr.clear();
    loadCtr.clear();
    industryIdCtr.clear();
    cargoIdCtr.clear();
  }
}

