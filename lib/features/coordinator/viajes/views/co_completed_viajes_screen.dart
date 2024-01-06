import 'package:cargocontrol/common_widgets/viajes_card.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../core/enums/viajes_type.dart';
import '../widgets/co_viajes_card.dart';

class CoCompletedViajesSreen extends StatelessWidget {
  const CoCompletedViajesSreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.symmetric(vertical: 26.h),
      itemBuilder: (BuildContext context, int index) {
        return const CoViajesCard(
          viajesEnum: ViajesTypeEnum.completed,
        );
      },
    );
  }
}
