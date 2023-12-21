import 'package:cargocontrol/commons/common_widgets/custom_appbar.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';

import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../core/enums/viajes_status_enum.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../utils/loading.dart';
import '../../../coordinator/register_truck_movement/controllers/truck_registration_controller.dart';
import '../widgets/ad_recent_record_widget.dart';

class AdAllRecentiesScreen extends StatelessWidget {
  const AdAllRecentiesScreen({Key? key}) : super(key: key);

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
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return ref.watch(getAllViajesList).
                  when(
                    data: (viajesList){
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viajesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          ViajesModel model =  viajesList[index];
                          return GestureDetector(
                            onTap: (){

                            },
                            child: AdRecentRecordCard(
                              isEntered: model.viajesStatusEnum.type == ViajesStatusEnum.portEntered.type ? true : false,
                              isLeaving:  model.viajesStatusEnum.type == ViajesStatusEnum.portLeft.type ? true : false,
                              guideNumber: model.guideNumber.toString(),
                              driverName: model.chofereName,
                              portEntryTime: model.entryTimeToPort,
                            ),
                          );
                        },
                      );
                    },
                    error: (error, st){
                      debugPrintStack(stackTrace: st);
                      debugPrint(error.toString());
                      return const SizedBox.shrink();
                    },
                    loading: (){
                      return const LoadingWidget();
                    },
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
