import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class CoCargaEditWidget extends StatefulWidget {
  const CoCargaEditWidget({Key? key}) : super(key: key);

  @override
  State<CoCargaEditWidget> createState() => _CoCargaEditWidgetState();
}

class _CoCargaEditWidgetState extends State<CoCargaEditWidget> {
  final grossOutputCtr= TextEditingController();
  final grossWeightOfArrivalCtr= TextEditingController();
  final weightCtr= TextEditingController();


  @override
  void dispose() {
    grossOutputCtr.dispose();
    grossWeightOfArrivalCtr.dispose();
    weightCtr.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Carga", style: getBoldStyle(
          color: context.textColor,
          fontSize: MyFonts.size14,
        ),),
        SizedBox(height: 18.h,),
        CustomTextField(
            controller: grossOutputCtr,
            hintText: '',
            onChanged: (val){},
            onFieldSubmitted: (val){},
            obscure: false,
            label: 'Peos bruto de salida'
        ),
        CustomTextField(
            controller: grossWeightOfArrivalCtr,
            hintText: '',
            onChanged: (val){},
            onFieldSubmitted: (val){},
            obscure: false,
            label: 'Peso bruto de llegada'
        ),
        CustomTextField(
            controller: weightCtr,
            hintText: '',
            onChanged: (val){},
            onFieldSubmitted: (val){},
            obscure: false,
            label: 'Peso tara '
        ),
      ],
    );
  }
}
