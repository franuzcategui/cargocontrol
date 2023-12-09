import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/bodega_section_widget.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_header.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../commons/common_widgets/custom_dropdown.dart';

class CreateVesselBodegaInfoScreen extends StatefulWidget {
  const CreateVesselBodegaInfoScreen({Key? key}) : super(key: key);

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

  createBodegaSection() {
    final section = _BodegaInfoControllers();
    final product =  CustomDropDown(ctr: section.productCtr, list: products, labelText: 'Producto',);
    final variety = CustomDropDown(ctr: section.varietyCtr, list: varieties, labelText: 'Variedad',);
    final origin = CustomDropDown(ctr: section.originCtr, list: originList, labelText: 'Origen',);
    final tipo = CustomDropDown(ctr: section.tipoCtr, list: tipoList, labelText: 'Tipo',);
    final cosecha = CustomDropDown(ctr: section.cosechaCtr, list: cosechaList, labelText: 'Cosecha',);
    final weight = CustomTextField(
      controller: section.weightCtr,
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
          index: i,
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
          productWidget: _productDropDown[i],
          varietyWidget: _varietyDropDown[i],
          weightWidget: _weights[i],
          cosechaWidget: _cosechas[i],
          originWidget: _origins[i],
          tipoWidget: _tipos[i],
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
                        Navigator.pushNamed(context, AppRoutes.adminCreateVesselCompleteDataScreen);
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

