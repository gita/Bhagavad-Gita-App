import 'package:flutter/material.dart';

Color primaryColor = HexColor.fromHex('#F57903');
Color primaryLightColor = HexColor.fromHex('#FFF5EA');
Color whiteColor = HexColor.fromHex('#FFFFFF');
Color blackColor = HexColor.fromHex('#0A0A0A');
Color orangeColor = HexColor.fromHex('#FF922C');
Color appBarTitleColor = HexColor.fromHex('#0A0A0A');
Color textLightGreyColor = HexColor.fromHex('#666666');
Color greyScalBodyColor = HexColor.fromHex('#333333');
Color greyScalLableColor = HexColor.fromHex('#666666');
Color titleLableColor = HexColor.fromHex('#1A1A1A');
Color settingColor = HexColor.fromHex('#804916');
Color editBoxBorderColor = HexColor.fromHex('#D9DBE9');
Color effectColor = HexColor.fromHex('#FBF0DA');
Color lightOrangeColor = HexColor.fromHex('#FBF0DA');
Color darkOrangeColor = HexColor.fromHex('#FFBE80');

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
