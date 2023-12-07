import 'package:cargocontrol/core/enums/viajes_type.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../widgets/in_viajes_card.dart';

class InAllViajesSreen extends StatelessWidget {
  const InAllViajesSreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.symmetric(vertical: 26.h),
      itemBuilder: (BuildContext context, int index) {
        return const InViajesCard(
          viajesEnum: ViajesTypeEnum.inProgress,
        );
      },
    );
  }
}
