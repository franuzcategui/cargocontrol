import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';

import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/constants/font_manager.dart';
import '../widgets/in_choferes_list.dart';

class InChoferesScreen extends ConsumerWidget {
  const InChoferesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Choferes', style: getBoldStyle(
            color: context.textColor,
          fontSize: MyFonts.size28
        )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            CustomTextField(
                controller: TextEditingController(),
                hintText: "",
                onChanged: (val){},
                onFieldSubmitted: (val){},
                obscure: false,
                label: 'Buscar chofer',
              tailingIcon: Image.asset(AppAssets.searchIcon, scale: 2,),
            ),
            SizedBox(height: 13.h,),
            const InChoferesList(),
          ],
        ),
      ),
    );
  }
}
