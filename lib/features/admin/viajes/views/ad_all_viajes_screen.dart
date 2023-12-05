import 'package:cargocontrol/core/enums/viajes_type.dart';
import 'package:cargocontrol/features/admin/viajes/widgets/ad_viajes_card.dart';

import '../../../../commons/common_imports/common_libs.dart';

class AdAllViajesSreen extends StatelessWidget {
  const AdAllViajesSreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.symmetric(vertical: 26.h),
      itemBuilder: (BuildContext context, int index) {
        return const AdViajesCard(
          viajesEnum: ViajesTypeEnum.inProgress,
        );
      },
    );
  }
}
