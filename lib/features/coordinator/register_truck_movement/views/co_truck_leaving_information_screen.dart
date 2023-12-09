import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/information_preliminar_widget.dart';
import 'package:cargocontrol/routes/route_manager.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_header.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../commons/common_widgets/wine_celler_widget.dart';
import '../widgets/co_preliminary_leaving_info_widget.dart';

class CoTruckLeavingInformationScreen extends StatefulWidget {
  const CoTruckLeavingInformationScreen({Key? key}) : super(key: key);

  @override
  State<CoTruckLeavingInformationScreen> createState() => _CoTruckLeavingInformationScreenState();
}

class _CoTruckLeavingInformationScreenState extends State<CoTruckLeavingInformationScreen> {



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
                  SizedBox(height: 28.h,),
                  const CoPreliminarLeavingInfoWidget(),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  NumberOfCargoHoldsWidget(
                    seletedWines: (int selectedValue){},
                  ),
                  SizedBox(height: 45.h,),
                  CustomButton(
                      onPressed: (){
                        Navigator.pushNamed(context, AppRoutes.coTruckLeavingBriefScreen);
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

