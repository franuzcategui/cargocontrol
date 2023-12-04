import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/thems/styles_manager.dart';

class KeyboardTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onFieldSubmitted;
  final TextInputType? inputType;
  final bool obscure;
  final IconData? icon;
  final String? Function(String?)? validatorFn;
  final Widget? leadingIcon;
  final Widget? tailingIcon;
  final String? leadingIconPath;
  final double? texfieldHeight;
  final VoidCallback? onTap;
  final bool? readOnly;
  final String label;
  final bool showLabel;

  const KeyboardTextfield({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    required this.onFieldSubmitted,
    this.inputType,
    this.leadingIcon,
    required this.obscure,
    this.validatorFn,
    this.icon,
    this.tailingIcon,
    this.leadingIconPath,
    this.texfieldHeight,
    required this.label,
    this.showLabel = true, this.onTap, this.readOnly,
  }) : super(key: key);

  @override
  State<KeyboardTextfield> createState() => _KeyboardTextfieldState();
}

class _KeyboardTextfieldState extends State<KeyboardTextfield> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45.w),
      child: Column(
        children: [
          TextFormField(
            validator: widget.validatorFn,
            obscureText: widget.obscure,
            readOnly: true,
            controller: widget.controller,
            keyboardType: widget.inputType,
            style: getMediumStyle(fontSize: MyFonts.size12, color: context.textColor),
            decoration: InputDecoration(
              label: Text(widget.label, style: getRegularStyle(color:  context.secondaryTextColor, fontSize: MyFonts.size12),),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              prefixIcon: widget.leadingIcon,
              errorStyle: getRegularStyle(
                  fontSize: MyFonts.size10,
                  color: Theme.of(context).colorScheme.error),
              suffixIcon: widget.tailingIcon,
              hintText: widget.hintText,
              hintStyle: getMediumStyle(
                  fontSize: MyFonts.size12,
                  color: context.textFieldColor),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: context.textFieldColor
                  )
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: context.mainColor
                  )
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: context.textFieldColor
                  )
              ),
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: context.errorColor
                  )
              ),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: context.errorColor
                  )
              ),
            ),
            onFieldSubmitted: widget.onFieldSubmitted,
            onChanged: widget.onChanged,
          ),
        ],
      ),
    );
  }
}
