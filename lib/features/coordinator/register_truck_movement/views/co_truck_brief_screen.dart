import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../admin/create_vessel/widgets/information_preliminar_widget.dart';
import '../widgets/co_preliminary_info_widget.dart';
import '../widgets/co_truck_info_widget.dart';

class CoTruckBriefScreen extends StatefulWidget {
  const CoTruckBriefScreen({Key? key}) : super(key: key);

  @override
  State<CoTruckBriefScreen> createState() => _CoTruckBriefScreenState();
}

class _CoTruckBriefScreenState extends State<CoTruckBriefScreen> {

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
                  const CoPreliminarInfoWidget(),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  const CoTruckInfoWidget(),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  
                  SizedBox(height: 26.h,),
                  CustomButton(
                      onPressed: (){
                        Navigator.pushNamed(context, AppRoutes.coRegistrationSuccessFullScreen);
                      },
                      buttonText: "CONFIRMAR"
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

