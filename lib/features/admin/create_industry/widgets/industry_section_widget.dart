import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';

import '../../../../commons/common_imports/common_libs.dart';

class IndustrySectionWidget extends StatelessWidget {
  final int index;
  final Widget nameWidget;
  final Widget comenzoWIdget;
  final Widget endOfGuideWidget;
  final Widget productWidget;
  final Widget loadWidget;
  final VoidCallback onRemove;
  const IndustrySectionWidget({Key? key, required this.index, required this.productWidget, required this.onRemove, required this.nameWidget, required this.comenzoWIdget, required this.endOfGuideWidget, required this.loadWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Industria #${index+1}', style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size14),),
            GestureDetector(
                onTap: onRemove,
                child: Icon(Icons.cancel_outlined, size: 18.sp, color: context.errorColor,))
          ],
        ),
        SizedBox(height: 8.h,),
        nameWidget,
        SizedBox(height: 10.h,),
        comenzoWIdget,
        SizedBox(height: 10.h,),
        endOfGuideWidget,
        SizedBox(height: 10.h,),
        productWidget,
        SizedBox(height: 10.h,),
        loadWidget,
      ],
    );
  }
}
