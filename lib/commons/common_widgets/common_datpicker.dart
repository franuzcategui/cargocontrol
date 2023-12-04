import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:intl/intl.dart';
import '../common_imports/common_libs.dart';

class CommonDatePicker extends StatefulWidget {
  final  TextEditingController ctr;
  final  String labelText;
  final  String? headerText;
  const CommonDatePicker({Key? key, required this.ctr, required this.labelText, this.headerText}) : super(key: key);

  @override
  State<CommonDatePicker> createState() => _CommonDatePickerState();
}

class _CommonDatePickerState extends State<CommonDatePicker> {
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      readOnly: true,
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2050),
        );
        if (date != null) {
          setState(() {
          });
          widget.ctr.text = DateFormat('dd/MM/yyyy').format(date);
        }
      },
      label: widget.labelText,
      hintText: "",
      onFieldSubmitted: (val){},
      onChanged: (val){},
      obscure: false,
      controller: widget.ctr,
    );
  }
}
