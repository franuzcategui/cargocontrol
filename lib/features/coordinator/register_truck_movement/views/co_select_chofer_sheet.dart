import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';

import '../../../../common_widgets/cargo_card.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/CustomTextFields.dart';
import '../../../../utils/constants/assets_manager.dart';

class CoSelectChoferScreen extends StatelessWidget {
  final Function(String choferName) selectChofer;
  const CoSelectChoferScreen({Key? key, required this.selectChofer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: context.scaffoldBackgroundColor
      ),
      height: 750.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h,),
          Text('Choferes', style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size28),),
          SizedBox(height: 20.h,),
          CustomTextField(
            controller: TextEditingController(),
            hintText: "",
            onChanged: (val){},
            onFieldSubmitted: (val){},
            obscure: false,
            label: 'Buscar chofer',
            tailingIcon: Image.asset(AppAssets.searchIcon, scale: 2.2.sp,),
          ),
          SizedBox(height: 13.h,),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      selectChofer("Hola Kapito");
                      Navigator.pop(context);
                    },
                    child: const CargoCard(
                        topLeftText: "ID 123456",
                        topRightText: "Viajes 0",
                        titleText: "Intento- 0.0",
                        bottomLeftText: "Deficit 0.0",
                        bottomRightText:
                        "Retraso Promedio : 0.0"),
                  );

                }),
          ),
          CustomButton(
              onPressed: (){},
              buttonText: 'AGREGAR CHOFER'
          ),
          CustomButton(
              onPressed: (){
                Navigator.pop(context);
              },
              buttonText: 'REGRESAR',
            backColor: context.secondaryMainColor,
          ),
        ],
      ),
    );
  }
}
