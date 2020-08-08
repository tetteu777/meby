import 'package:meby/controle/controle.dart';
import 'package:meby/visao/telas/login/TelaLogin.dart';
import 'package:meby/visao/widgets/Logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';



class WelcomeFacebook extends StatelessWidget {
  String nome;

  WelcomeFacebook(this.nome);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: 196.h,
              height: 196.h,
              margin: EdgeInsets.only(
                top: 163.h,
                left: 109.w,
                right: 109.w,
                bottom: 27.h,
              ),
              child: Logo(),
            ),
            Container(
              width: 243.w,
              margin: EdgeInsets.symmetric(horizontal: 85.w),
              child: Text(
                'Entrar como',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24.sp,
                    color: Color(0xff474747),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 300.w,
              height: 49.h,
              margin: EdgeInsets.only(top: 39.h, left: 57.w, right: 57.w),
              child: RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Color(0xff058BC6), width: 3),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 21.w,
                      height: 21.h,
                      margin: EdgeInsets.only(
                          left: 20.w, top: 14.h, bottom: 14.h, right: 10.w),
                      child: Image(
                        image: AssetImage('assets/images/facebook.png'),
                      ),
                    ),
                    Container(
                      width: 175.w,
                      margin: EdgeInsets.only(top: 16.h, bottom: 14.h),
                      child: FittedBox(
                        child: Text(
                          '${nome.toUpperCase()}',
                          style: TextStyle(
                              color: Color(0xff989898), fontSize: 14.sp),
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  facebookLogin();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 120.w, left: 120.w, top: 260.h),
              child: FlatButton(
                child: FittedBox(
                  child: Text(
                    'Trocar de conta',
                    style: TextStyle(
                        color: Color(0xff8E8E8E),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  Get.off(TelaLogin());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> facebookLogin() async {
    final authCredential = await Controle.to.facebook.getAuthCredential();
    final authResult = await Controle.to.firebase.signInWithCredential(authCredential);

    if (authResult != null) {
      Controle.to.setUID(authResult.user.uid);
      Controle.to.prepararParaLogin();
      Controle.to.getStorage.write('login', 'facebook');

    } else {
      Get.defaultDialog(title: 'Ops', middleText: 'Erro com o Facebook Login');
    }
  }
}
