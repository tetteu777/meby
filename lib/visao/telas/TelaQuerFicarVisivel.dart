import 'package:meby/controle/controle.dart';
import 'package:meby/visao/telas/TelaContatos2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TelaQuerFicarVisivel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: 277.w,
              margin: EdgeInsets.only(top: 70.h, left: 60.w, right: 60.w),
              child: Text(
                'Quer ficar vísivel?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff131313)),
              ),
            ),
            SizedBox(
              height: 96.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.w),
              child: Text(
                'Fique visível para que possa encontrar e ser encontrado por '
                'usuários próximos. Usamos a sua localização'
                ' apenas para isso.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 21.sp, color: Color(0xff515050)),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.w),
              child: Text(
                'Permita o acesso à sua localização na caixa de diálogo a seguir.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 21.sp, color: Color(0xff515050)),
              ),
            ),
            SizedBox(
              height: 130.h,
            ),
            Container(
              width: 300.w,
              margin: EdgeInsets.only(top: 38.h, left: 57.w, right: 57.w),
              child: RaisedButton(
                color: Color(0xff058BC6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Color(0xff058BC6)),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 10.h, bottom: 9.h),
                  child: FittedBox(
                    child: Text(
                      'Sim, AGORA',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onPressed: () async {
                  Controle.to.usuarioById(Controle.to.uid).setVisivel(true);
                  Controle.to
                      .usuarioById(Controle.to.uid)
                      .setSexoDoOutro('ambos');
                  Controle.to.ambos = true;
                  await Controle.to.updateUsuario(Controle.to.uid,
                      Controle.to.usuarioById(Controle.to.uid));
                  Get.off(TelaContatos2());
                },
              ),
            ),
            Container(
              width: 300.w,
              margin: EdgeInsets.only(top: 38.h, left: 57.w, right: 57.w),
              child: RaisedButton(
                padding: EdgeInsets.all(0),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Color(0xff989898)),
                ),
                child: Container(
                  // margin: EdgeInsets.only(top: 10.h, bottom: 9.h),
                  child: Text(
                    'Talvez mais tarde',
                    style: TextStyle(
                        color: Color(0xff989898),
                        fontSize: 23.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  Controle.to.usuarioById(Controle.to.uid).setVisivel(false);

                  Get.off(TelaContatos2());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
