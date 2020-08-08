import 'package:meby/controle/controle.dart';
import 'package:meby/modelo/Usuario.dart';
import 'package:meby/util/CalculadoraDeIdade.dart';
import 'package:meby/visao/telas/login/TelaLogin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopUpExcluirConta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: 338.w,
        height: 400.h,
        margin:
            EdgeInsets.only(top: 192.h, left: 38.w, right: 38.w, bottom: 180.h),
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            Container(
              alignment: Alignment.topCenter,
              width: 340.w,
              margin: EdgeInsets.only(top: 0.h),
              child: Column(
                children: [
                  Text(
                    'Vai mesmo embora?',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 35.w),
                    child: Text(
                      'Vamos sentir a sua falta. Esperamos vê-lo novamente.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff4F4F50),
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 259.w,
                        height: 61.h,
                        child: RaisedButton(
                          elevation: 0,
                          color: Color(0xff058BC6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(31.0.w),
                              side: BorderSide(color: Color(0xff058BC6))),
                          child: Text(
                            'Sim, delete minha conta',
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.sp),
                          ),
                          onPressed: () async {
                            await Controle.to.excluirConta(
                                Controle.to.usuarioById(Controle.to.uid));
                            print(Controle.to.toString());
                            await Controle.to.limparControle();

                            Get.off(TelaLogin());
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                        child: FlatButton(
                          child: Text(
                            'Não, vou ficar',
                            style: TextStyle(
                                color: Colors.black87, fontSize: 17.sp),
                          ),
                          onPressed: () async {
                            Get.back();
                          },
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
