import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_appbar.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/assets_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../widgets/in_report_card.dart';

class InAllReportsScreen extends StatefulWidget {
  const InAllReportsScreen({Key? key}) : super(key: key);

  @override
  State<InAllReportsScreen> createState() => _InAllReportsScreenState();
}

class _InAllReportsScreenState extends State<InAllReportsScreen> {
  final searchCtr = TextEditingController();

  @override
  void dispose() {
    searchCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Registro de buques", style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size28),),
            SizedBox(height: 24.h,),
            CustomTextField(
              controller: searchCtr,
              hintText: '',
              onChanged: (val){},
              onFieldSubmitted: (val){},
              obscure: false,
              label: 'Buscar buques',
              tailingIcon: Image.asset(AppAssets.searchIcon, scale: 2,),
            ),
            SizedBox(height: 12.h,),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return const InReportCard();
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
