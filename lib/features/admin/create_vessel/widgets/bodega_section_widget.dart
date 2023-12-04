import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';

import '../../../../commons/common_imports/common_libs.dart';

class BodegaSectionWidget extends StatelessWidget {
  final int index;
  final Widget productWidget;
  final Widget varietyWidget;
  final Widget weightWidget;
  final VoidCallback onRemove;
  const BodegaSectionWidget({Key? key, required this.index, required this.productWidget, required this.varietyWidget, required this.weightWidget, required this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Bodega #${index+1}', style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size14),),
            GestureDetector(
                onTap: onRemove,
                child: Icon(Icons.cancel_outlined, size: 18.sp, color: context.errorColor,))
          ],
        ),
        SizedBox(height: 8.h,),
        productWidget,
        SizedBox(height: 10.h,),
        varietyWidget,
        SizedBox(height: 10.h,),
        weightWidget
      ],
    );
  }
}
