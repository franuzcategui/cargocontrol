import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../widgets/ad_carga_edit_widget.dart';
import '../widgets/ad_carga_widget.dart';
import '../widgets/ad_datos_generales_widget.dart';
import '../widgets/ad_generales_edit_widget.dart';
import '../widgets/ad_tempo_edit_widget.dart';
import '../widgets/ad_tiempo_widget.dart';

class AdViajesEditScreen extends StatelessWidget {
  const AdViajesEditScreen({Key? key}) : super(key: key);

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
                  Text("Datos del viaje de Juan Perez", style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size16),),
                  SizedBox(height: 14.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  const AdDatosGeneralesWidget(),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  const AdGeneralesEditWidget(),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  const AdTempoEditWidget(),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  const AdCargaEditWidget(),
                  SizedBox(height: 26.h,),
                  CustomButton(
                      onPressed: (){
                        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.adminMainMenuScreen, (route) => false);
                      },
                      backColor: context.mainColor,
                      buttonText: "GUARDAR"
                  ),
                  CustomButton(
                      onPressed: (){
                        Navigator.pushNamed(context, AppRoutes.registrationSuccessFullScreen);
                      },
                      backColor: context.secondaryMainColor,
                      buttonText: "REGRESAR"
                  ),
                  SizedBox(height: 35.h,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

