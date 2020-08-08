import 'package:meby/controle/controle.dart';
import 'package:meby/modelo/Usuario.dart';
import 'package:meby/util/CalculadoraDeIdade.dart';
import 'package:meby/visao/telas/login/TelaLogin.dart';
import 'package:meby/visao/telas/welcomeBack/WelcomeEmail.dart';
import 'package:meby/visao/telas/welcomeBack/WelcomeFacebook.dart';
import 'package:meby/visao/telas/welcomeBack/WelcomeGoogle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopUpEsqueciSenha extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: 338.w,
        height: 500.h,
        margin:
            EdgeInsets.only(top: 192.h, left: 38.w, right: 38.w, ),
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 0.h),
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
                      'E-mail enviado com sucesso!',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      child: Text(
                        'Clique no link no que enviamos para o seu e-mail para redefinir sua nova senha. Se você não receber o e-mail nos próximos 10 minutos, verifique se o e-mail informado está correto e procure na pasta spam ou lixo eletrônico. Caso não encontre, faça uma nova solicitação.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Color(0xff4F4F50),
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Container(
                      child: FlatButton(
                        child: Text(
                          'OK',
                          style: TextStyle(color: Colors.black, fontSize: 17.sp),
                        ),
                        onPressed: () async {
                          Get.back();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
