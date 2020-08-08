import 'package:meby/controle/controle.dart';
import 'package:meby/util/CalculadoraDeIdade.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastroProfissao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:date_text_masked/date_text_masked.dart';

class TelaCadastroDataDeNascimento extends StatelessWidget {
  static const String rota = '/telaCadastroDataDeNascimento';

  Controle controle = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<Controle>(
            init: controle,
            builder: (_) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        alignment: Alignment.center,
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
                                  width: (130.w / 7) * 3,
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
                                _.usuarioById(_.uid).dataDeNascimento == null
                                    ? 'Qual a sua data de nascimento?'
                                    : 'Você nasceu no dia:\n\n${_.usuarioById(_.uid).dataDeNascimento.day}/${_.usuarioById(_.uid).dataDeNascimento.month}/${_.usuarioById(Controle.to.uid).dataDeNascimento.year}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 32.sp, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 81.h,
                            ),
                            RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xff058BC6)),
                              ),
                              child: Text(
                                _.usuarioById(_.uid).dataDeNascimento == null ? 'Inserir data' : 'Alterar data',
                                style: TextStyle(
                                    color: Color(0xff058BC6),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                DateTime hoje = DateTime.now();

                                showDatePicker(
                                  context: context,
                                  initialEntryMode: DatePickerEntryMode.input,
                                  initialDate: DateTime(hoje.year - 14),
                                  firstDate: DateTime(hoje.year - 120),
                                  lastDate: DateTime(hoje.year - 14),
                                ).then((data) {
                                  _.usuarioById(_.uid).setDataDeNascimento(data);
                                  _.update();

//                  setState(() {
//                    _dataDeNascimento = data;
//                  });
                                });
                              },
                            ),
                            SizedBox(
                              height: 330.h,
                            ),
                            Container(
                              child: RaisedButton(
                                color:
                                    _.usuarioById(_.uid).dataDeNascimento != null
                                        ? Color(0xff058BC6)
                                        : Color(0xffCECECE),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      color:
                                          _.usuarioById(_.uid).dataDeNascimento !=
                                                  null
                                              ? Color(0xff058BC6)
                                              : Color(0xffCECECE)),
                                ),
                                child: Text(
                                  _.usuarioById(_.uid).dataDeNascimento == null
                                      ? 'Insira uma data válida'
                                      : 'Tenho ${CalculadoraDeIdade.obterIdade(_.usuarioById(_.uid).dataDeNascimento.toString())}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  if (_.usuarioById(_.uid).dataDeNascimento !=
                                      null) {
                                    _.updateUsuario(_.uid, _.usuarioById(_.uid));

                                    Get.off(TelaCadastroProfissao());
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
