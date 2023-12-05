import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Theme colors
var kColorScheme = ColorScheme.fromSeed(seedColor: kMainColor);

const kMainColor = Color.fromRGBO(18, 48, 179, 1);
const kOutlineTextFieldColor = Color.fromRGBO(215, 218, 230, 1);
const kBrandColor = Color.fromRGBO(58, 170, 53, 1);
const kMainBackroundColor = Colors.white;
const kSecondaryMainColor = Color.fromRGBO(12, 19, 62, 1);
const kTertiaryMainColor = Color.fromRGBO(32, 202, 254, 1);
const kQuaternaryMainColor = Color.fromRGBO(255, 222, 47, 1);

//Text styles

class TextStyles {
  final Color? color;
  const TextStyles({this.color});

  TextStyle get bodyHintText1 {
    return TextStyle(
      fontSize: 12,
      color: color ?? kOutlineTextFieldColor,
    );
  }

  TextStyle get bodyText1 {
    return TextStyle(
      fontSize: 12,
      color: color ?? Colors.black,
    );
  }

  TextStyle get headlineText1 {
    return TextStyle(
      fontSize: 24,
      color: color ?? Colors.black,
    );
  }

  TextStyle get titleText1 {
    return TextStyle(
      fontSize: 36,
      color: color ?? Colors.black,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get titleText2 {
    return TextStyle(
      fontSize: 24,
      color: color ?? Colors.black,
    );
  }

  TextStyle get titleText3 {
    return TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.black,
    );
  }

  TextStyle get auxTitleText1 {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.black,
    );
  }

  TextStyle get subtitleText1 {
    return TextStyle(
      fontSize: 24,
      color: color ?? Colors.black,
    );
  }

  TextStyle get subtitleText2 {
    return TextStyle(
      fontSize: 16,
      color: color ?? Colors.black,
    );
  }

  TextStyle get buttonText1 {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.white,
      letterSpacing: 1.2,
    );
  }

  TextStyle get buttonText2 {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: color ?? kMainColor,
    );
  }

  TextStyle get cardTitle1 {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.black,
    );
  }

  TextStyle get cardText1 {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.black,
    );
  }

  TextStyle get cardText2 {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.black,
    );
  }

  TextStyle get chipText1 {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.black,
    );
  }

  TextStyle get keyPadInputText {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.black,
    );
  }

  TextStyle get infoTitle1 {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.black,
    );
  }
}

//Button Styles

class ButtonStyles {
  static ButtonStyle buttonStyle1 = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
    ),
    minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(56)),
    backgroundColor: MaterialStateProperty.all<Color>(kMainColor),
  );

  static ButtonStyle buttonStyle2 = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        side: const BorderSide(),
        borderRadius: BorderRadius.circular(25.0),
      ),
    ),
    minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(56)),
    backgroundColor: MaterialStateProperty.all<Color>(kMainBackroundColor),
  );

  static ButtonStyle buttonStyle3 = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        side: const BorderSide(),
        borderRadius: BorderRadius.circular(25.0),
      ),
    ),
    alignment: Alignment.centerLeft,
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.only(left: 30)),
    minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(83)),
    backgroundColor: MaterialStateProperty.all<Color>(kMainBackroundColor),
  );
}

//Decoration styles

class DecorationStyles {
  static BoxDecoration shadow1 = BoxDecoration(
      color: kMainBackroundColor,
      borderRadius: BorderRadius.circular(25),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.08),
          blurRadius: 16,
          offset: Offset(0, 8),
        ),
      ]);

  static BoxDecoration shadow2 = BoxDecoration(
      color: kMainBackroundColor,
      borderRadius: BorderRadius.circular(25),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(148, 149, 204, 0.1727),
          blurRadius: 40,
          offset: Offset(0, 16),
        ),
      ]);

  static BoxDecoration viajesChipDecoration = BoxDecoration(
      color: kMainBackroundColor,
      border: Border.all(
        color: kMainColor,
        width: 1.w,
      ),
      borderRadius: BorderRadius.circular(25),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.08),
          blurRadius: 16,
          offset: Offset(0, 8),
        ),
      ]);

  static InputDecoration inputTextDecoration1 = const InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
      borderSide: BorderSide(
        color: kOutlineTextFieldColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
      borderSide: BorderSide(
        color: kMainColor,
      ),
    ),
  );

  static InputDecoration searchBarDecoration1 = const InputDecoration(
    suffixIcon: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(
          FontAwesomeIcons.magnifyingGlass,
          size: 20,
        ),
      ],
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
      borderSide: BorderSide(
        color: kOutlineTextFieldColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
      borderSide: BorderSide(
        color: kMainColor,
      ),
    ),
  );

  static InputDecoration keyPadTextFieldDecoration1 = const InputDecoration(
    prefixText: 'C - ',
  );
}

//Images

class Images {
  Images._();
  static const String logo = 'assets/images/logos/logo.png';

  static const String whiteLogo = 'assets/images/logos/white_logo.png';

  static const String ship = 'assets/images/general/ship.png';
}
