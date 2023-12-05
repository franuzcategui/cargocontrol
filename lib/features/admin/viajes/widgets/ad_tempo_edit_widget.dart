import 'package:cargocontrol/commons/common_widgets/common_datpicker.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class AdTempoEditWidget extends StatefulWidget {
  const AdTempoEditWidget({Key? key}) : super(key: key);

  @override
  State<AdTempoEditWidget> createState() => _AdTempoEditWidgetState();
}

class _AdTempoEditWidgetState extends State<AdTempoEditWidget> {
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
