import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';

import '../../../../common_widgets/title_header.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_datpicker.dart';
import '../../../../commons/common_widgets/common_header.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../widgets/wine_celler_widget.dart';

class CreateVesselScreen extends StatefulWidget {
  const CreateVesselScreen({Key? key}) : super(key: key);

  @override
  State<CreateVesselScreen> createState() => _CreateVesselScreenState();
}

class _CreateVesselScreenState extends State<CreateVesselScreen> {
  final vesselNameCtr = TextEditingController();
  final procedenciaCtr = TextEditingController();
  final shipperCtr = TextEditingController();
  final unCodeCtr = TextEditingController();


  DateTime? portDate;
  int? numberOfWines;

  @override
  void dispose() {
    vesselNameCtr.dispose();
    procedenciaCtr.dispose();
    shipperCtr.dispose();
    unCodeCtr.dispose();
    super.dispose();
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
                   CustomTextField(
                     controller: vesselNameCtr,
                     hintText: "",
                     label: "Nombre de buque",
                     onChanged: (val){},
                     onFieldSubmitted: (val){},
                     obscure: false,
                   ),
                   CustomTextField(
                     controller: procedenciaCtr,
                     hintText: "",
                     label: "Procedencia ",
                     onChanged: (val){},
                     onFieldSubmitted: (val){},
                     obscure: false,
                   ),
                   CustomTextField(
                     controller: shipperCtr,
                     hintText: "",
                     label: "Shipper ",
                     onChanged: (val){},
                     onFieldSubmitted: (val){},
                     obscure: false,
                   ),
                   CommonDatePicker(
                     labelText: "Fecha en puerto",
                     ctr: TextEditingController(),
                   ),
                   CustomTextField(
                     controller: unCodeCtr,
                     hintText: "",
                     label: "UN/Locode",
                     onChanged: (val){},
                     onFieldSubmitted: (val){},
                     obscure: false,
                   ),
                   WineCellerWidget(
                     seletedWines: (int selectedValue){},
                   ),
                   SizedBox(height: 45.h,),
                   CustomButton(
                       onPressed: (){
                         Navigator.pushNamed(context, AppRoutes.adminCreateVesselBodegaInfoScreen);
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

