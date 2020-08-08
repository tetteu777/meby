import 'package:meby/controle/controle.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastroFoto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TelaCadastroBio extends StatelessWidget {
  static const String rota = '/telaCadastroBio';

  Controle controle = Get.find();

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
                Controle.to.bioTextController = TextEditingController();
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
                                  width: (130.w / 7) * 5,
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
                                'Sobre mim...',
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
                                minLines: 1,
                                maxLines: 3,
                                controller: _.bioTextController,
                              ),
                            ),
                            SizedBox(
                              height: 450.h,
                            ),
                            Container(
                              width: 328.w,
                              height: 56.h,
                              child: RaisedButton(
                                color: Color(0xff058BC6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Color(0xff058BC6)),
                                ),
                                child: Text(
                                  _.bioTextController.text.isNotEmpty
                                      ? 'Próximo'
                                      : 'Pular',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  controle
                                      .usuarioById(controle.uid)
                                      .setBio(_.bioTextController.text);
                                  controle.updateUsuario(controle.uid,
                                      controle.usuarioById(controle.uid));

                                  Get.off(TelaCadastroFoto());
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
