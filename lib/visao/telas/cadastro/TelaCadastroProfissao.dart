import 'package:meby/controle/controle.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastroBio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TelaCadastroProfissao extends StatelessWidget {
  static const String rota = '/telaCadastroProfissao';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: GetBuilder<Controle>(
              init: Controle.to,
              initState: (_) {
                Controle.to.profissaoTextController = TextEditingController();
              },
              builder: (_) {
                return SafeArea(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                  width: (130.w / 7) * 4,
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
                                'Qual é a sua profissão?',
                                style: TextStyle(
                                    fontSize: 32.sp, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              child: TextFormField(
                                maxLength: 30,
                                maxLengthEnforced: true,
                                controller: _.profissaoTextController,
                              ),
                            ),
                            SizedBox(
                              height: 400.h,
                            ),
                            Container(
                              width: 328.w,
                              height: 56.h,
                              child: RaisedButton(
                                color: _.profissaoTextController.text.isNotEmpty
                                    ? Color(0xff058BC6)
                                    : Color(0xffD9D9D9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                    color:
                                        _.profissaoTextController.text.isNotEmpty
                                            ? Color(0xff058BC6)
                                            : Color(0xffD9D9D9),
                                  ),
                                ),
                                child: Text(
                                  'Próximo',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  if (_.profissaoTextController.text.isNotEmpty) {
                                    Controle.to
                                        .usuarioById(Controle.to.uid)
                                        .setProfissao(
                                            _.profissaoTextController.text);
                                    Controle.to.updateUsuario(Controle.to.uid,
                                        Controle.to.usuarioById(Controle.to.uid));
                                    Get.off(TelaCadastroBio());
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
