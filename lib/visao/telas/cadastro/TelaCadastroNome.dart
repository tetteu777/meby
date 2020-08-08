import 'package:meby/controle/controle.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastroSexo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TelaCadastroNome extends StatelessWidget {
  static const String rota = '/telaCadastroNome';

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
                Controle.to.nomeTextController = TextEditingController(
                    text: Controle.to.usuarioById(Controle.to.uid).nome ?? '');
              },
              builder: (_) {
                return SafeArea(
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
                                width: 130.w / 7,
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
                              'Qual é o seu nome?',
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
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'Por favor, digite seu nome completo';
                                }
                                return null;
                              },
                              controller: _.nomeTextController,
                            ),
                          ),
                          SizedBox(
                            height: 500.h,
                          ),
                          Container(
                            width: 328.w,
                            height: 56.h,
                            child: RaisedButton(
                              color: _.nomeTextController.text.isNotEmpty
                                  ? Color(0xff058BC6)
                                  : Color(0xffD9D9D9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    color: _.nomeTextController.text.isNotEmpty
                                        ? Color(0xff058BC6)
                                        : Color(0xffD9D9D9)),
                              ),
                              child: Text(
                                'Próximo',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                if (_.nomeTextController.text.isNotEmpty) {
                                  controle
                                      .usuarioById(controle.uid)
                                      .setNome(_.nomeTextController.text);

                                  controle.updateUsuario(
                                    controle.uid,
                                    controle.usuarioById(controle.uid),
                                  );
                                  Get.off(TelaCadastroSexo());
                                }
                              },
                            ),
                          ),
                        ],
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
