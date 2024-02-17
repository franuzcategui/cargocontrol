import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_industry/widgets/confirm_industry_dialog.dart';
import 'package:cargocontrol/features/admin/create_vessel/controllers/ad_vessel_noti_controller.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:uuid/uuid.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_header.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../commons/common_widgets/custom_dropdown.dart';
import '../../../../commons/common_widgets/show_toast.dart';
import '../../../../models/vessel_models/vessel_cargo_model.dart';
import '../../create_vessel/controllers/ad_vessel_controller.dart';
import '../controllers/ad_industry_noti_controller.dart';
import '../widgets/industry_section_widget.dart';

class CreateIndustryInformationScreen extends ConsumerStatefulWidget {
  // final int numberOfIndustries;
  const CreateIndustryInformationScreen({Key? key,}) : super(key: key);

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

  int findCargoModelIndex(List<VesselCargoModel> cargoList, VesselCargoModel cargoModel) {
    for (int i = 0; i < cargoList.length; i++) {
      if (cargoList[i].cargoId == cargoModel.cargoId) {
        return i;
      }
    }
    // If no match is found, return -1 to indicate that the cargoModel is not in the list.
    return -1;
  }
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

  List<double> cargoHoldWeights=[
    0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0
  ];

  double totalCargoLoad = 0.0;
  double totalIndustryLoads = 0.0;

  @override
  void initState() {
    super.initState();
    createIndustrySection();
  }

  Future<void> confirmDialog({required BuildContext context,required double differenceWeight,   required Function() onConfirm}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ConfirmIndustryDialog(differenceWeight: differenceWeight, onTap: onConfirm,);
      },
    );
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60.h,),
                  _industrySections(),
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Consumer(
                            builder: (BuildContext context, WidgetRef ref, Widget? child) {
                              return ref.watch(fetchCurrentVesselsProvider).when(
                                  data: (vesselModel) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ListView.builder(
                                          itemCount: vesselModel.cargoModels.length,
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context, int index) {
                                            VesselCargoModel cargoModel =  vesselModel.cargoModels[index];
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${cargoModel.productName}, ${cargoModel.variety}, ${cargoModel.cosecha}, ${cargoModel.tipo}: ',
                                                  style: getBoldStyle(color:context.textColor, fontSize: MyFonts.size14),
                                                ),
                                                Text(
                                                  '${cargoModel.pesoTotal}/${cargoHoldWeights[index]}',
                                                  style: getBoldStyle(color:(cargoModel.pesoTotal<cargoHoldWeights[index])?context.errorColor:MyColors.kBrandColor, fontSize: MyFonts.size14),
                                                ),
                                              ],
                                            );

                                          },
                                        ),

                                        Row(
                                          children: [
                                            Text(
                                              'Peso total :',
                                              style: getBoldStyle(color:context.textColor, fontSize: MyFonts.size14),
                                            ),
                                            Text(
                                              ' ${vesselModel.totalCargoWeight}/${totalIndustryLoads}',
                                              style: getBoldStyle(color:(vesselModel.totalCargoWeight<totalIndustryLoads)?context.errorColor:MyColors.kBrandColor, fontSize: MyFonts.size14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }, error: (error, st) {
                                //debugPrintStack(stackTrace: st);
                                //debugPrint(error.toString());
                                return const SizedBox();
                              }, loading: () {
                                return const SizedBox();
                              });
                            },
                          ),
                          //
                          // Text(
                          //   'Peso total en bodegas: ${totalCargoLoad}',
                          //   style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size14),
                          // ),
                          // Text(
                          //   'Peso total : ${totalIndustryLoads}',
                          //   style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size14),
                          // ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 15.h,),
                  Center(
                    child: CustomButton(
                      onPressed: (){
                        Map<VesselCargoModel, List<_IndustryControllers>> cargoSectionsMap = {};
                        totalCargoLoad = 0;
                        totalIndustryLoads = 0;
                        cargoHoldWeights=[
                          0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0
                        ];
                        for (var section in _industryControllers) {
                          VesselCargoModel? cargo;
                          ref.read(adVesselNotiController).vesselModel!.cargoModels.forEach((model) {
                            if (section.cargoIdCtr.text == model.cargoId) {
                              cargo = model;
                            }
                          });

                          if (cargo != null) {
                            if (cargoSectionsMap.containsKey(cargo!)) {
                              cargoSectionsMap[cargo!]!.add(section);
                            } else {
                              cargoSectionsMap[cargo!] = [section];
                            }
                          }
                        }


                        cargoSectionsMap.forEach((cargo, sections) {
                          double totalLoad = sections.fold(0, (sum, section) => sum + double.parse(section.loadCtr.text));
                          double cargoWeight = cargo.pesoTotal;

                          if(ref.read(adVesselNotiController).vesselModel!=null){
                            int index= findCargoModelIndex(ref.read(adVesselNotiController).vesselModel!.cargoModels,cargo);
                            if (index != -1) {
                              cargoHoldWeights[index]=cargoHoldWeights[index]+totalLoad;
                            }
                          }


                          totalCargoLoad = totalCargoLoad + cargoWeight;
                          totalIndustryLoads = totalIndustryLoads + totalLoad;
                        });
                        createIndustrySection();
                      },
                      buttonText: "Generate New Section",
                      backColor: context.scaffoldBackgroundColor,
                      textColor: context.mainColor,
                    ),
                  ),
                  Center(
                    child: CustomButton(
                        onPressed: (){
                          for (var section in _industryControllers) {
                            if(section.productCtr.text == "" || section.nameCtr.text == "" ||
                                section.endOfGuideCtr.text == "" || section.comienzeCtr.text == "" ||
                                section.loadCtr.text == "" ){
                              setState(() {
                                allGood = false;
                              });

                              showToast(msg:  "Fill All Fields!",);
                              break;
                            }else{
                              setState(() {
                                allGood = true;
                              });
                            }
                          }
                          if (allGood) {
                            for (int i = 0; i < _industryControllers.length - 1; i++) {
                              _IndustryControllers section1 = _industryControllers[i];
                              _IndustryControllers section2 = _industryControllers[i + 1];

                              double endOfGuideCtrValue1 = double.parse(section1.endOfGuideCtr.text);
                              double endOfGuideCtrValue2 = double.parse(section2.endOfGuideCtr.text);
                              double comienzeCtrValue1 = double.parse(section1.comienzeCtr.text);
                              double comienzeCtrValue2 = double.parse(section2.comienzeCtr.text);

                              if (endOfGuideCtrValue1 < comienzeCtrValue2 &&
                                  endOfGuideCtrValue1 != endOfGuideCtrValue2 &&
                                  comienzeCtrValue1 != comienzeCtrValue2
                              ) {
                                setState(() {
                                  allGood = true;
                                });
                              }else{
                                setState(() {
                                  allGood = false;
                                });
                                showSnackBar(
                                  context: context,
                                  content: "Industry guides cannot be same, and first guide should start after the second guide! ",
                                  duration: const Duration(milliseconds: 4000),
                                );
                              }
                            }
                          }

                          if (allGood) {
                            for (int i = 0; i < _industryControllers.length - 1; i++) {
                              _IndustryControllers section1 = _industryControllers[i];
                              _IndustryControllers section2 = _industryControllers[i + 1];

                              String industry1 = section1.industryIdCtr.text;
                              String industry2 = section2.industryIdCtr.text;

                              if (industry1 != industry2) {
                                setState(() {
                                  allGood = true;
                                });
                              }else{
                                setState(() {
                                  allGood = false;
                                });
                                showSnackBar(
                                  context: context,
                                  content: "Cannot select same Industry Multiple Times!",
                                  duration: const Duration(milliseconds: 4000),
                                );
                              }
                            }
                          }


                          if (allGood) {
                            totalCargoLoad = 0;
                            totalIndustryLoads = 0;
                            cargoHoldWeights=[
                              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0
                            ];
                            Map<VesselCargoModel, List<_IndustryControllers>> cargoSectionsMap = {};

                            for (var section in _industryControllers) {
                              VesselCargoModel? cargo;
                              ref.read(adVesselNotiController).vesselModel!.cargoModels.forEach((model) {
                                if (section.cargoIdCtr.text == model.cargoId) {
                                  cargo = model;
                                }
                              });

                              if (cargo != null) {
                                if (cargoSectionsMap.containsKey(cargo!)) {
                                  cargoSectionsMap[cargo!]!.add(section);
                                } else {
                                  cargoSectionsMap[cargo!] = [section];
                                }
                              }
                            }



                            cargoSectionsMap.forEach((cargo, sections) {
                              double totalLoad = sections.fold(0, (sum, section) => sum + double.parse(section.loadCtr.text));
                              double cargoWeight = cargo.pesoTotal;


                              if(ref.read(adVesselNotiController).vesselModel!=null){
                                int index= findCargoModelIndex(ref.read(adVesselNotiController).vesselModel!.cargoModels,cargo);
                                if (index != -1) {
                                  cargoHoldWeights[index]=cargoHoldWeights[index]+totalLoad;
                                }
                              }

                              totalCargoLoad = totalCargoLoad + cargoWeight;
                              totalIndustryLoads = totalIndustryLoads + totalLoad;
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
                                lastGuide: double.parse(section.endOfGuideCtr.text), deficit: 0, cargoHoldId: cargo!.cargoId,
                              );
                              industrySubModels.add(model);

                            }

                            if(ref.read(adVesselNotiController).vesselModel!.totalCargoWeight>totalIndustryLoads){
                              confirmDialog(context:context, differenceWeight:ref.read(adVesselNotiController).vesselModel!.totalCargoWeight-totalIndustryLoads, onConfirm: () {        Navigator.pushNamed(
                                  context,
                                  AppRoutes.adminCreateIndustryCompleteDataScreen,
                                  arguments: {
                                    'industrySubModels' : industrySubModels,
                                    'cargoHoldWeights':cargoHoldWeights,
                                  }
                              );},);
                            }else{
                              Navigator.pushNamed(
                                  context,
                                  AppRoutes.adminCreateIndustryCompleteDataScreen,
                                  arguments: {
                                    'industrySubModels' : industrySubModels,
                                    'cargoHoldWeights':cargoHoldWeights,
                                  }
                              );
                            }
                          }
                        },
                        buttonText: "CONTINUAR"
                    ),
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

