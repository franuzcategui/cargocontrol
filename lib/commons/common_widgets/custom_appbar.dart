
import 'package:cargocontrol/core/extensions/color_extension.dart';

import '../../utils/constants/assets_manager.dart';
import '../common_imports/common_libs.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({this.showBackButton = false});
  final bool showBackButton;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: showBackButton,
      leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Image.asset(AppAssets.arrowBack, height: 12.h, width: 19.w, )
      ),
    );
  }
}