import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_dropdown.dart';
import '../../../../utils/constants/font_manager.dart';

class AdGeneralesEditWidget extends StatefulWidget {
  const AdGeneralesEditWidget({Key? key}) : super(key: key);

  @override
  State<AdGeneralesEditWidget> createState() => _AdGeneralesEditWidgetState();
}

class _AdGeneralesEditWidgetState extends State<AdGeneralesEditWidget> {
  final guideNumberCtr= TextEditingController();
  String? selectedProduct;

  List<String> products = [
    "Rice",
    "Corn",
    "Veggie"
  ];


  @override
  void dispose() {
    guideNumberCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Generales", style: getBoldStyle(
          color: context.textColor,
          fontSize: MyFonts.size14,
        ),),
        SizedBox(height: 18.h,),
        CustomTextField(
            controller: guideNumberCtr,
            hintText: '',
            onChanged: (val){},
            onFieldSubmitted: (val){},
            obscure: false,
            label: 'Número de guia'
        ),
        CustomDropDown(
          list: products,
          labelText: "Producto (Variedad)",
          onChange: (val){
          },
        ),

      ],
    );
  }
}
