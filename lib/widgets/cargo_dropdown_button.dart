import 'package:flutter/material.dart';
import 'package:cargocontrol/constants.dart' as constants;

class CargoDropdownButton extends StatelessWidget {
  const CargoDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(deviceWidth / 20, 0, deviceWidth / 20, 15),
      child: Container(
        //padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: constants.kOutlineTextFieldColor,
            ),
            bottom: BorderSide(
              color: constants.kOutlineTextFieldColor,
            ),
            left: BorderSide(
              color: constants.kOutlineTextFieldColor,
            ),
            right: BorderSide(
              color: constants.kOutlineTextFieldColor,
            ),
          ),
          borderRadius: BorderRadius.all(Radius.circular(25)),
          //color: constants.kOutlineTextFieldColor,
        ),
        child: DropdownButton(
            value: 'hello',
            underline: SizedBox(),
            isExpanded: true,
            items: <DropdownMenuItem>[
              DropdownMenuItem(
                value: 'hello',
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Text(
                    'hello',
                    style: const constants.TextStyles().bodyText1,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: 'tokyo',
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Text(
                    'hello',
                    style: const constants.TextStyles().bodyText1,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: 'tokyo',
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Text(
                    'hello',
                    style: const constants.TextStyles().bodyText1,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: 'tokyo',
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Text(
                    'hello',
                    style: const constants.TextStyles().bodyText1,
                  ),
                ),
              ),
            ],
            onChanged: (value) {}),
      ),
    );
  }
}
