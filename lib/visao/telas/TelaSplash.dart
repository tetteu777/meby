import 'package:meby/controle/controle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TelaSplash extends StatelessWidget {
  Controle controle = Get.put(Controle());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(Get.context,
        width: 414, height: 896, allowFontScaling: true);
    print('splash');

    return Scaffold(
      backgroundColor: Color(0xff058BC6),
      body: Center(
        child: Container(
          width: 244.w,
          height: 226.h,
          child: Image(
            image: AssetImage('assets/images/splash.png'),
          ),
        ),
      ),
    );
  }
}
