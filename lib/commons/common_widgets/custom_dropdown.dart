import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/assets_manager.dart';

import '../../utils/constants/font_manager.dart';
import '../common_imports/common_libs.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> list;
  final String labelText;
  final TextEditingController? ctr;
  final Function(String? val)? onChange;
  const CustomDropDown({Key? key, required this.list, this.onChange, required this.labelText, this.ctr}) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  FocusNode _focusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  // @override
  // void dispose() {
  //   _focusNode.dispose();
  //   super.dispose();
  // }

  void _requestFocus(){
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }


  @override
  Widget build(BuildContext context) {
    return  DropdownButtonFormField<String>(
      validator: (value) =>
      value == null ? 'field required' : null,
      icon: Image.asset(AppAssets.arrowDown, width: 16.w, height: 8.h,),
      onTap: _requestFocus,
      style: getMediumStyle(fontSize: MyFonts.size12, color: context.textColor),
      decoration: InputDecoration(
        label: Text(widget.labelText, style: getRegularStyle(color: _focusNode.hasFocus?
        context.mainColor : context.secondaryTextColor, fontSize: MyFonts.size12),),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(56.r),
          borderSide: BorderSide(width: 1.w, color: context.textFieldColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(56.r),
          borderSide: BorderSide(
              width: 1.w, color: context.textFieldColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(56.r),
          borderSide: BorderSide(width: 1.w, color: context.textFieldColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(56.sp),
          borderSide: BorderSide(
              width: 1.w, color: context.errorColor),
        ),
      ),

      items: widget.list
          .map<DropdownMenuItem<String>>(
              (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
      onChanged: (val){
        if(widget.onChange != null){
          widget.onChange!(val);
        }
        if(widget.ctr != null){
          widget.ctr!.text = val as String;
        }
        setState(() {
        });
      },
    );
  }
}
