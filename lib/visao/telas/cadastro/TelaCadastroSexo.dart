import 'package:meby/controle/controle.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastroDataDeNascimento.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TelaCadastroSexo extends StatelessWidget {
  static const String rota = '/telaCadastroSexo';

  Controle controle = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<Controle>(
            init: controle,
            initState: (_) {
              Controle.to.botaoMasculinoCorTexto = Color(0xff989898);
              Controle.to.botaoFemininoCorTexto = Color(0xff989898);
            },
            builder: (_) {
              return SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: 28.h,
                    ),
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(9.w),
                            ),
                            color: Color(0xffD9D9D9),
                          ),
                          width: 130.w,
                          height: 17.h,
                        ),
                        Container(
                          width: (130.w / 7) * 2,
                          height: 17.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(9.w),
                              ),
                              color: Color(0xff058BC6)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 63.h,
                    ),
                    Container(
                      child: Text(
                        'Com qual gênero você se identifica?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 32.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 450.h,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 278.w,
                          height: 56.h,
                          child: RaisedButton(
                            color: _.botaoFemininoCorFundo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Color(0xff989898)),
                            ),
                            child: Text(
                              'Feminino',
                              style: TextStyle(
                                  color: _.botaoFemininoCorTexto,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              _.usuarioById(_.uid).setSexo('feminino');

                              _.setBotaoFemCorTexto(Color(0xff058BC6));
                              await _.updateUsuario(_.uid, _.usuarioById(_.uid));

                              Get.off(TelaCadastroDataDeNascimento());
                            },
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Container(
                          width: 278.w,
                          height: 56.h,
                          child: RaisedButton(
                            color: _.botaoMasculinoCorFundo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Color(0xff989898)),
                            ),
                            child: Text(
                              'Masculino',
                              style: TextStyle(
                                  color: _.botaoMasculinoCorTexto,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              _.usuarioById(_.uid).setSexo('masculino');

                              _.setBotaoMascCorTexto(Color(0xff058BC6));
                              await _.updateUsuario(_.uid, _.usuarioById(_.uid));

                              Get.off(TelaCadastroDataDeNascimento());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
