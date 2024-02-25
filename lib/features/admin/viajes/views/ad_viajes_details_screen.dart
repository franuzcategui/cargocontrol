import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/viajes/views/guide_number_update_dialog.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import '../../../../common_widgets/carga_widget.dart';
import '../../../../common_widgets/datos_generales_widget.dart';
import '../../../../common_widgets/tiempo_widget.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';

class AdViajesDetailsScreen extends StatefulWidget {
  final ViajesModel viajesModel;
  const AdViajesDetailsScreen({Key? key, required this.viajesModel})
      : super(key: key);

  @override
  State<AdViajesDetailsScreen> createState() => _AdViajesDetailsScreenState();
}

class _AdViajesDetailsScreenState extends State<AdViajesDetailsScreen> {
  Future<void> guideNoUpdateDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GuideNumberUpdateDialog(viajesModel: widget.viajesModel);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TitleHeader(
              title: "",
              subtitle: "",
              logo: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 14.h,
                  ),
                  Text(
                    "Datos del viaje de ${widget.viajesModel.chofereName}",
                    style: getRegularStyle(
                        color: context.textColor, fontSize: MyFonts.size16),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Divider(
                    height: 1.h,
                    color: context.textFieldColor,
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  DatosGeneralesWidget(
                    viajesModel: widget.viajesModel,
                    onGuideNumberEdit: () => guideNoUpdateDialog(context),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Divider(
                    height: 1.h,
                    color: context.textFieldColor,
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  TiempoWidget(
                    viajesModel: widget.viajesModel,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Divider(
                    height: 1.h,
                    color: context.textFieldColor,
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  CargaWidget(viajesModel: widget.viajesModel),
                  SizedBox(
                    height: 26.h,
                  ),
                  CustomButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      backColor: context.secondaryMainColor,
                      buttonText: "REGRESAR"),
                  SizedBox(
                    height: 35.h,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
