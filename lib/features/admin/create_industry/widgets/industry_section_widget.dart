import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_industry/controllers/ad_industry_noti_controller.dart';
import 'package:cargocontrol/features/admin/create_vessel/controllers/ad_vessel_noti_controller.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_dropdown.dart';

class IndustrySectionWidget extends ConsumerStatefulWidget {
  final int index;
  final TextEditingController industryNameCtr;
  final TextEditingController industryIdCtr;
  final TextEditingController cargoIdCtr;
  final TextEditingController productNameCtr;
  final Widget comenzoWIdget;
  final Widget endOfGuideWidget;
  final Widget loadWidget;
  final VoidCallback onRemove;
  const IndustrySectionWidget({Key? key, required this.index,required this.industryIdCtr,required this.cargoIdCtr,  required this.onRemove, required this.comenzoWIdget, required this.endOfGuideWidget, required this.loadWidget, required this.industryNameCtr, required this.productNameCtr}) : super(key: key);

  @override
  ConsumerState<IndustrySectionWidget> createState() => _IndustrySectionWidgetState();
}

class _IndustrySectionWidgetState extends ConsumerState<IndustrySectionWidget> {


  List<String> industryNames = [

  ];

  List<String> productNames = [

  ];

  // @override
  // void initState() {
  //   super.initState();
  //   initialization();
  // }
  //
  // initialization()async{
  //   ref.read(adIndustryNotiController).industryNames;
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Industria #${widget.index+1}', style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size14),),
            GestureDetector(
                onTap: widget.onRemove,
                child: Icon(Icons.cancel_outlined, size: 18.sp, color: context.errorColor,))
          ],
        ),
        SizedBox(height: 8.h,),
        CustomDropDown(
          ctr: widget.industryNameCtr,
          list: ref.read(adIndustryNotiController).industryNames,
          labelText: 'Nombre',
          onChange: (String val){
            ref.read(adIndustryNotiController).allIndustriesModels.forEach((industry) {
              if(val == industry.industryName){
                widget.industryIdCtr.text = industry.industryId;
              }
            });
          },
        ),
        SizedBox(height: 16.h,),
        widget.comenzoWIdget,
        widget.endOfGuideWidget,
        CustomDropDown(
          ctr: widget.productNameCtr,
          list: ref.read(adVesselNotiController).vesselProductNames,
          labelText: 'Producto (Variedad)',
          onChange: (String val){
            ref.read(adVesselNotiController).vesselModel!.cargoModels.forEach((cargo) {
              if(val == cargo.productName){
                widget.cargoIdCtr.text = cargo.cargoId;
              }
            });
          },
        ),
        SizedBox(height: 16.h,),
        widget.loadWidget,
      ],
    );
  }
}
