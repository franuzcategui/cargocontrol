import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/choferes/widgets/add_choferes_modal.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/constants/font_manager.dart';
import '../../../../utils/loading.dart';
import '../controllers/choferes_noti_controller.dart';
import '../widgets/ad_choferes_list.dart';

class AdChoferesScreen extends ConsumerWidget {
  const AdChoferesScreen({super.key});

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
            const AdChoferesList(),
            ref.watch(choferesNotiController).isSecondaryLoading?
            const LoadingWidget(): const SizedBox()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.white,
              elevation: 0,
              context: context,
              builder: (context) => const AddChoferesModal());
        },
        backgroundColor: constants.kMainColor,
        child: const FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
      ),
    );
  }
}
