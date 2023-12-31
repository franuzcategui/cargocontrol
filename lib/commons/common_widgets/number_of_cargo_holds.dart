import 'package:cargocontrol/core/extensions/color_extension.dart';

import '../common_imports/common_libs.dart';
import '../../utils/constants/font_manager.dart';

class NumberOfCargoHoldsWidget extends StatefulWidget {
  final Function(int val) seletedCargosNumber;
  final int? numberOfCargoHolds;
  const NumberOfCargoHoldsWidget({Key? key, required this.seletedCargosNumber, this.numberOfCargoHolds, }) : super(key: key);

  @override
  State<NumberOfCargoHoldsWidget> createState() => _NumberOfCargoHoldsWidgetState();
}

class _NumberOfCargoHoldsWidgetState extends State<NumberOfCargoHoldsWidget> {
  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Cantidad de bodegas',style: getRegularStyle(color: context.text3Color, fontSize: MyFonts.size14),),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(widget.numberOfCargoHolds ?? 5, (index){
            bool isSelected = selectedValue == index;
            return  GestureDetector(
              onTap: (){
                setState(() {
                  selectedValue = index;
                  widget.seletedCargosNumber(index+1);
                });
              },
              child: Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.scaffoldBackgroundColor,
                    border: Border.all(
                        color:  isSelected? context.mainColor: context.textFieldColor,
                        width: 1.w
                    )
                ),
                alignment: Alignment.center,
                child: Text('${index+1}', style: getRegularStyle(
                    color: isSelected? context.mainColor: context.textFieldColor, fontSize: MyFonts.size14),),
              ),
            );
          }),
        ),
      ],
    );
  }
}
