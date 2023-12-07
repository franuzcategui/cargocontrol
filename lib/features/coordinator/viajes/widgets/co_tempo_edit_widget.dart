import 'package:cargocontrol/commons/common_widgets/common_datpicker.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class CoTempoEditWidget extends StatefulWidget {
  const CoTempoEditWidget({Key? key}) : super(key: key);

  @override
  State<CoTempoEditWidget> createState() => _CoTempoEditWidgetState();
}

class _CoTempoEditWidgetState extends State<CoTempoEditWidget> {
  final departureTimeCtr= TextEditingController();
  final arrivalTimeCtr= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tiempo de viaje", style: getBoldStyle(
          color: context.textColor,
          fontSize: MyFonts.size14,
        ),),
        SizedBox(height: 18.h,),
        CommonDatePicker(
            ctr: departureTimeCtr,
            labelText: "Hora de salida"
        ),
        CommonDatePicker(
            ctr: arrivalTimeCtr,
            labelText: "Hora de llegada"
        ),
      ],
    );
  }
}
