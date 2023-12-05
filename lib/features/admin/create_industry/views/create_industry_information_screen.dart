import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_header.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../commons/common_widgets/custom_dropdown.dart';
import '../widgets/industry_section_widget.dart';

class CreateIndustryInformationScreen extends StatefulWidget {
  const CreateIndustryInformationScreen({Key? key}) : super(key: key);

  @override
  State<CreateIndustryInformationScreen> createState() => _CreateIndustryInformationScreenState();
}

class _CreateIndustryInformationScreenState extends State<CreateIndustryInformationScreen> {
  List<_IndustryControllers> _industryControllers = [];
  List<Widget> _nameDropDowns = [];
  List<Widget> _productDropDowns = [];
  List<Widget> _comienzos = [];
  List<Widget> _endOfGuides = [];
  List<Widget> _loads = [];

  createIndustrySection() {
    final section = _IndustryControllers();
    final product =  CustomDropDown(ctr: section.nameCtr, list: names, labelText: 'Nombre',);
    final variety = CustomDropDown(ctr: section.productCtr, list: products, labelText: 'Producto (Variedad)',);
    final comenzio = CustomTextField(
      controller: section.comienzeCtr,
      onTap: (){},
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
          comenzoWIdget: _comienzos[i],
          endOfGuideWidget: _endOfGuides[i],
          loadWidget: _loads[i],
          nameWidget: _nameDropDowns[i],
          productWidget: _productDropDowns[i],
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
    createIndustrySection();
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
                        Navigator.pushNamed(context, AppRoutes.adminCreateIndustryCompleteDataScreen);
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
  void dispose() {
    nameCtr.dispose();
    comienzeCtr.dispose();
    endOfGuideCtr.dispose();
    productCtr.dispose();
    loadCtr.dispose();
  }

  void clear() {
    nameCtr.clear();
    comienzeCtr.clear();
    endOfGuideCtr.clear();
    productCtr.clear();
    loadCtr.clear();
  }
}

