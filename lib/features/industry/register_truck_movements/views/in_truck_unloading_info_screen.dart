import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../widgets/in_preminar_info_widget.dart';

class InTruckLeavingInfoScreen extends StatefulWidget {
  const InTruckLeavingInfoScreen({Key? key}) : super(key: key);

  @override
  State<InTruckLeavingInfoScreen> createState() => _InTruckLeavingInfoScreenState();
}

class _InTruckLeavingInfoScreenState extends State<InTruckLeavingInfoScreen> {

  final grossWeightOfArrivalCtr  = TextEditingController();

  @override
  void dispose() {
    grossWeightOfArrivalCtr.dispose();
    super.dispose();
  }

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

                  SizedBox(height: 28.h,),
                  const InPreliminarInfoWidget(),
                  SizedBox(height: 185.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 20.h,),
                  CustomTextField(
                      controller: grossWeightOfArrivalCtr,
                      hintText: '',
                      onChanged: (val){},
                      onFieldSubmitted: (val){},
                      obscure: false,
                      label:  'Peso bruto de llegada'
                  ),

                  SizedBox(height: 60.h,),
                  CustomButton(
                      onPressed: (){
                        Navigator.pushNamed(context, AppRoutes.inTruckLeavingBriefScreen);
                      },
                      buttonText: "CONTINUAR"
                  ),
                  SizedBox(height: 30.h,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

