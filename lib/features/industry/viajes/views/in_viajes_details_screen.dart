import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import '../../../../common_widgets/carga_widget.dart';
import '../../../../common_widgets/datos_generales_widget.dart';
import '../../../../common_widgets/tiempo_widget.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../models/viajes_models/viajes_model.dart';


class InViajesDetailsScreen extends StatelessWidget {
  final ViajesModel viajesModel;

  const InViajesDetailsScreen({Key? key, required this.viajesModel}) : super(key: key);

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
                  Text("Datos del viaje de ${viajesModel.chofereName}", style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size16),),
                  SizedBox(height: 14.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  DatosGeneralesWidget(viajesModel: viajesModel, onGuideNumberEdit: () {  },),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  TiempoWidget(viajesModel: viajesModel,),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  CargaWidget(viajesModel: viajesModel),
                  SizedBox(height: 26.h,),
                  Center(
                    child: CustomButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        backColor: context.secondaryMainColor,
                        buttonText: "REGRESAR"
                    ),
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

