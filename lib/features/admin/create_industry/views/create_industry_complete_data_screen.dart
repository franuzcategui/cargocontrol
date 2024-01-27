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
import '../../../../models/vessel_models/vessel_cargo_model.dart';
import '../../../../utils/thems/my_colors.dart';
import '../../create_vessel/controllers/ad_vessel_controller.dart';
import '../../create_vessel/widgets/information_preliminar_widget.dart';
import '../widgets/industries_for_all_data.dart';
import '../widgets/info_preliminar_widget.dart';

class CreateIndustryCompleteDataScreen extends ConsumerStatefulWidget {
  final List<IndustrySubModel> industrySubModels;
  final List<double> cargoHoldWeights;
  const CreateIndustryCompleteDataScreen({required this.cargoHoldWeights,Key? key,  required this.industrySubModels}) : super(key: key);

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

                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      return ref.watch(fetchCurrentVesselsProvider).when(
                          data: (vesselModel) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
                                  itemCount: vesselModel.cargoModels.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    VesselCargoModel cargoModel =  vesselModel.cargoModels[index];
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${cargoModel.productName}, ${cargoModel.variety}, ${cargoModel.cosecha}, ${cargoModel.tipo}: ',
                                          style: getBoldStyle(color:context.textColor, fontSize: MyFonts.size14),
                                        ),
                                        Text(
                                          '${cargoModel.pesoTotal}/${widget.cargoHoldWeights[index]}',
                                          style: getBoldStyle(color:(cargoModel.pesoTotal<widget.cargoHoldWeights[index])?context.errorColor:MyColors.kBrandColor, fontSize: MyFonts.size14),
                                        ),
                                      ],
                                    );

                                  },
                                ),

                                Row(
                                  children: [
                                    Text(
                                      'Peso total :',
                                      style: getBoldStyle(color:context.textColor, fontSize: MyFonts.size14),
                                    ),
                                    Text(
                                      ' ${vesselModel.totalCargoWeight}/${calculateTotalWeight(widget.industrySubModels)}',
                                      style: getBoldStyle(color:(vesselModel.totalCargoWeight<calculateTotalWeight(widget.industrySubModels))?context.errorColor:MyColors.kBrandColor, fontSize: MyFonts.size14),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }, error: (error, st) {
                        //debugPrintStack(stackTrace: st);
                        //debugPrint(error.toString());
                        return const SizedBox();
                      }, loading: () {
                        return const SizedBox();
                      });
                    },
                  ),
                  // Text("Peso total : ${calculateTotalWeight(widget.industrySubModels)}", style: getBoldStyle(
                  //   color: context.textColor,
                  //   fontSize: MyFonts.size14,
                  // ),),
                  SizedBox(height: 26.h,),
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      return CustomButton(
                        isLoading: ref.watch(adIndustryProvider),
                          onPressed: (){
                            ref.read(adIndustryProvider.notifier).createIndustryGuideModel(
                                industrySubModels: widget.industrySubModels,
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

