import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../widgets/co_carga_widget.dart';
import '../widgets/co_datos_generales_widget.dart';
import '../widgets/co_tiempo_widget.dart';

class CoViajesDetailsScreen extends StatelessWidget {
  const CoViajesDetailsScreen({Key? key}) : super(key: key);

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
                  const CoDatosGeneralesWidget(),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  const CoTiempoWidget(),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  const CoCargaWidget(),
                  SizedBox(height: 26.h,),
                  CustomButton(
                      onPressed: (){
                        Navigator.pushNamed(context, AppRoutes.adminViajesEditScreen);
                      },
                      backColor: context.brandColor,
                      buttonText: "EDITAR"
                  ),
                  CustomButton(
                      onPressed: (){
                        Navigator.pop(context);
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

