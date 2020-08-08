import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/images/logo_azul.svg', color: Color(0xff058BC6),);
  }
}
