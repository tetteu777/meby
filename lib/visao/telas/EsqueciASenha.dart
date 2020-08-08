import 'package:meby/controle/controle.dart';
import 'package:meby/visao/telas/login/TelaLogin.dart';
import 'package:meby/visao/widgets/PopUpEsqueciSenha.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'login/TelaLoginEmail.dart';

class EsqueciASenha extends StatelessWidget {
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Esqueci a senha',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 35.w),
              child: Text(
                'Informe o seu endereço de e-mail e vamos lhe enviar um link para uma nova senha',
                style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 35.w),
              child: TextField(
                controller: email,
                decoration: InputDecoration(hintText: 'Seu e-mail'),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Container(
              width: 218.w,
              height: 56.h,
              child: RaisedButton(
                color: Color(0xff058BC6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                  side: BorderSide(color: Color(0xff058BC6)),
                ),
                child: Text(
                  'Redefinir senha',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp),
                ),
                onPressed: () async {
                  bool erro = false;
                  final auth = await Controle.to.firebase.getAuth();
                  await auth
                      .sendPasswordResetEmail(email: email.text)
                      .catchError((error) {
                    erro = true;
                    if (error.code == 'ERROR_USER_NOT_FOUND') {
                      Get.defaultDialog(
                          title: 'Erro', middleText: 'Usuário não existe');
                    }
                  });
                  if (!erro) {
                    Get.to(TelaLoginEmail());
                    Get.dialog(PopUpEsqueciSenha());
                  }
                  ;
//                  Get.defaultDialog(
//                      title: 'E-mail enviado com sucesso!',
//                      middleText:
//                          'Clique no link no que enviamos para o seu e-mail para redefinir sua nova senha. Se você não receber o e-mail nos próximos 10 minutos, verifique se o e-mail informado está correto e procure na pasta spam ou lixo eletrônico. Caso não encontre, faça uma nova solicitação.',
//                      confirm: FlatButton(
//                        child: Text('OK'),
//                        onPressed: () {
//                          Get.back();
//                        },
//                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
