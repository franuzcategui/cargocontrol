import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_industry/controllers/ad_industry_controller.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../models/industry_models/industry_sub_model.dart';
import '../../create_vessel/widgets/information_preliminar_widget.dart';
import '../widgets/industries_for_all_data.dart';
import '../widgets/info_preliminar_widget.dart';

class CreateIndustryCompleteDataScreen extends ConsumerStatefulWidget {
  final String vesselId;
  final List<IndustrySubModel> industrySubModels;
  const CreateIndustryCompleteDataScreen({Key? key, required this.vesselId, required this.industrySubModels}) : super(key: key);

  @override
  ConsumerState<CreateIndustryCompleteDataScreen> createState() => _CreateIndustryCompleteDataScreenState();
}

class _CreateIndustryCompleteDataScreenState extends ConsumerState<CreateIndustryCompleteDataScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TitleHeader(
              title: "",
              subtitle: "" ,
              logo: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 14.h,),
                  Text("Resumen de registro de camión", style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size16),),
                  SizedBox(height: 14.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  InfoPreliminarIndustryWidget(),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  IndustriesForAllData(industrySubModels: widget.industrySubModels,),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 20.h,),
                  Text("Peso total : ${calculateTotalWeight(widget.industrySubModels)}", style: getBoldStyle(
                    color: context.textColor,
                    fontSize: MyFonts.size14,
                  ),),
                  SizedBox(height: 26.h,),
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      return CustomButton(
                        isLoading: ref.watch(adIndustryProvider),
                          onPressed: (){
                            ref.read(adIndustryProvider.notifier).createIndustryGuideModel(
                                industrySubModels: widget.industrySubModels,
                                vesselId: widget.vesselId,
                                ref: ref,
                                context: context
                            );
                          },
                          buttonText: "CONTINUAR"
                      );
                    },

                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalWeight(List<IndustrySubModel> industriesList){
    double totalWeight = 0.0;
    industriesList.forEach((industry) {
      totalWeight = totalWeight + industry.cargoAssigned;
    });
    return totalWeight;
  }
}

