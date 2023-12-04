import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/bodegas_for_all_data_widget.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../widgets/information_preliminar_widget.dart';

class CreateVesselCompleteDataScreen extends StatefulWidget {
  const CreateVesselCompleteDataScreen({Key? key}) : super(key: key);

  @override
  State<CreateVesselCompleteDataScreen> createState() => _CreateVesselCompleteDataScreenState();
}

class _CreateVesselCompleteDataScreenState extends State<CreateVesselCompleteDataScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TitleHeader(
              title: "",
              subtitle: "" ,
              logo: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 14.h,),
                  Text("Resumen de registro de camión", style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size16),),
                  SizedBox(height: 14.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  const InformationPreliminarWidget(),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  const BodegasForAllData(),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 20.h,),
                  Text("Peso total : 27,964,420", style: getBoldStyle(
                    color: context.textColor,
                    fontSize: MyFonts.size14,
                  ),),
                  SizedBox(height: 26.h,),
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

