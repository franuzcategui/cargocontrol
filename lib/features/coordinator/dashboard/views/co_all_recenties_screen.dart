import 'package:cargocontrol/commons/common_widgets/custom_appbar.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../widgets/co_recent_record_card.dart';

class CoAllRecentiesScreen extends StatelessWidget {
  const CoAllRecentiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Text('Registros recientes', style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size28),),
              SizedBox(height: 43.h,),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){

                    },
                    child: CoRecentRecordCard(
                      isEntered: index %2 ==0 ? true : false,
                      isLeaving:  index %2 !=0 ? true : false,
                    ),
                  );
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}
