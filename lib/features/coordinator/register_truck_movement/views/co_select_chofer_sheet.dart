import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';

import '../../../../common_widgets/cargo_card.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/CustomTextFields.dart';
import '../../../../models/choferes_models/choferes_model.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/loading.dart';
import '../../../admin/choferes/controllers/choferes_noti_controller.dart';

class CoSelectChoferScreen extends ConsumerStatefulWidget {
  final Function(String choferName) selectChofer;
  const CoSelectChoferScreen({Key? key, required this.selectChofer}) : super(key: key);

  @override
  ConsumerState<CoSelectChoferScreen> createState() => _CoSelectChoferScreenState();
}

class _CoSelectChoferScreenState extends ConsumerState<CoSelectChoferScreen> {

  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    initiallization();
  }

  initiallization(){
    ref.read(choferesNotiController).firstTime();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final choferesNotiCtr = ref.read(choferesNotiController);
      choferesNotiCtr.getAllChoferes();
    }
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: context.scaffoldBackgroundColor
      ),
      height: 750.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h,),
          Text('Choferes', style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size28),),
          SizedBox(height: 20.h,),
          CustomTextField(
            controller: TextEditingController(),
            hintText: "",
            onChanged: (val){},
            onFieldSubmitted: (val){},
            obscure: false,
            label: 'Buscar chofer',
            tailingIcon: Image.asset(AppAssets.searchIcon, scale: 2.2.sp,),
          ),
          SizedBox(height: 13.h,),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final choferesNotiCtr = ref.watch(choferesNotiController);
              return choferesNotiCtr.isLoading ?
              LoadingWidget(
                size: 300.h,
              ):
              choferesNotiCtr.choferesModels.isEmpty ?
              const Text("No Chores!"):
              Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: choferesNotiCtr.choferesModels.length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      ChoferesModel model = choferesNotiCtr.choferesModels[index];
                      return CargoCard(
                          topLeftText: "ID ${model.choferNationalId}",
                          topRightText: "Viajes ${model.numberOfTrips}",
                          titleText: "${model.firstName} ${model.lastName}",
                          bottomLeftText: "Deficit ${model.averageCargoDeficit}",
                          bottomRightText: "Retraso Promedio : 2:00H");

                    }),
              );
            },

          ),
          CustomButton(
              onPressed: (){},
              buttonText: 'AGREGAR CHOFER'
          ),
          CustomButton(
              onPressed: (){
                Navigator.pop(context);
              },
              buttonText: 'REGRESAR',
            backColor: context.secondaryMainColor,
          ),
        ],
      ),
    );
  }
}
