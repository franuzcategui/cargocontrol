import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

import '../../../../core/enums/viajes_type.dart';

class InViajesCard extends StatelessWidget {
  final ViajesTypeEnum viajesEnum;
  const InViajesCard({super.key, required this.viajesEnum});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, AppRoutes.adminViajesDetailsScreen);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          height: 100.h,
          decoration: constants.DecorationStyles.shadow2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Camión',
                        style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                      ),
                      Text(
                        ' Juan Perez - 135526',
                        style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size12),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: constants.DecorationStyles.viajesChipDecoration.copyWith(
                      border:  Border.all(
                        color: viajesEnum.type == ViajesTypeEnum.completed.type ?
                        context.brandColor : context.mainColor,
                      )
                    ),
                    child: Text(
                        viajesEnum.type == ViajesTypeEnum.all.type ? 'Todos':
                        viajesEnum.type == ViajesTypeEnum.inProgress.type ? 'En camino':
                        'Completados',
                      style: getRegularStyle(color: viajesEnum.type == ViajesTypeEnum.completed.type ?
                          context.brandColor:
                      context.mainColor, fontSize: MyFonts.size8)
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Carga',
                    style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                  ),
                  Text(
                    ' 40,340 - Paddy Rice',
                    style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size12),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'No Guia',
                        style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                      ),
                      Text(
                        ' 10701',
                        style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Hora de salida',
                        style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                      ),
                      Text(
                        ' 20:55:12',
                        style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size12),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
