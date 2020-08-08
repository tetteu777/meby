import 'package:meby/controle/controle.dart';
import 'package:meby/modelo/Usuario.dart';
import 'package:meby/util/CalculadoraDeIdade.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopUpDeletar extends StatelessWidget {
  Usuario outroUsuario;
  Controle _;

  PopUpDeletar(this.outroUsuario, this._);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            width: 338.w,
            margin: EdgeInsets.only(
                top: 192.h, left: 38.w, right: 38.w, bottom: 180.h),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  width: 340.w,
                  margin: EdgeInsets.only(top: 0.h),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70.h,
                      ),
                      Text(
                        '${outroUsuario.nome}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 26.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        child: Text(
                          'Tem certeza que deseja\nexcluir ${outroUsuario.nome} de sua agenda?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xff4F4F50),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 90.w,
                            height: 44.h,
                            child: RaisedButton(
                              elevation: 0,
                              color: Color(0xff7B7979),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(31.0.w),
                                  side: BorderSide(color: Color(0xff7B7979))),
                              child: Text(
                                'Não',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17.sp),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ),
                          Container(
                            width: 90.w,
                            height: 44.h,
                            child: RaisedButton(
                              elevation: 0,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(31.0.w),
                                  side: BorderSide(color: Colors.red)),
                              child: Text(
                                'Excluir',
                                style: TextStyle(
                                    color: Colors.red, fontSize: 17.sp),
                              ),
                              onPressed: () async {
                                await _.removerContato(outroUsuario);
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
          Container(
            margin: EdgeInsets.only(left: 128.w, right: 128.w, top: 98.h),
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(new Radius.circular(79.h)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 15.w,
                    offset: Offset(0.0, 10.75))
              ],
            ),
            child: CircleAvatar(
              radius: 79.w,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 77.w,
                backgroundImage: NetworkImage(outroUsuario.imagemUrl),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: 174.w,
                right: 174.w,
                top: Get.height > 630 ? 710.h : 785.h),
            child: GestureDetector(
              child: Container(
                width: 66.w,
                height: 66.h,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Icon(Icons.clear),
              ),
              onTap: () {
                Get.back();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget Opcoes(Controle _, Usuario outroUsuario) {
    if (_.usuarioById(_.uid).solicitacoesFeitas.contains(outroUsuario.uid)) {
      return Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Status: ',
                  style: TextStyle(color: Color(0xff676161), fontSize: 18.sp),
                ),
                Text('Pendente',
                    style:
                        TextStyle(color: Color(0xffDE8109), fontSize: 18.sp)),
              ],
            ),
          ),
          SizedBox(
            height: 19.h,
          ),
          Container(
            width: 192.w,
            height: 34.h,
            child: RaisedButton(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(31.0.w),
                  side: BorderSide(color: Colors.red)),
              child: FittedBox(
                child: Text(
                  'Cancelar solicitação',
                  style: TextStyle(color: Colors.red, fontSize: 17.sp),
                ),
              ),
              onPressed: () async {
                if (_
                    .usuarioById(_.uid)
                    .solicitacoesFeitas
                    .contains(outroUsuario.uid)) {
                  await _.cancelarSolicitacao(outroUsuario);
                  Get.back();
                } else {
                  if (_
                      .usuarioById(_.uid)
                      .contatos
                      .contains(outroUsuario.uid)) {
                    Get.back();
                    Get.snackbar('Ops!',
                        'Você não pode cancelar a solicitação pois ${outroUsuario.nome} já aceitou',
                        snackPosition: SnackPosition.BOTTOM,
                        duration: Duration(seconds: 5));
                  } else {
                    Get.back();
                    Get.snackbar('Ops!',
                        '${outroUsuario.nome} acabou de recusar a solicitação',
                        snackPosition: SnackPosition.BOTTOM,
                        duration: Duration(seconds: 5));
                  }
                }
              },
            ),
          ),
        ],
      );
    } else if (_
        .usuarioById(_.uid)
        .solicitacoesRecebidas
        .contains(outroUsuario.uid)) {
      return Column(
        children: [
          Container(
            width: 192.w,
            height: 34.h,
            child: RaisedButton(
              elevation: 0,
              color: Color(0xff058BC6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(31.0.w),
                  side: BorderSide(color: Color(0xff058BC6))),
              child: Text(
                'Aceitar',
                style: TextStyle(color: Colors.white, fontSize: 17.sp),
              ),
              onPressed: () async {
                if (_
                    .usuarioById(_.uid)
                    .solicitacoesRecebidas
                    .contains(outroUsuario.uid)) {
                  Get.back();
                  await _.aceitarSolicitacao(outroUsuario);
                } else {
                  Get.back();
                  Get.snackbar('Ops!',
                      '${outroUsuario.nome} acabou de cancelar a solicitação',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: Duration(seconds: 5));
                }
              },
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          Container(
            width: 192.w,
            height: 34.h,
            child: RaisedButton(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(31.0.w),
                  side: BorderSide(color: Color(0xffEB262D))),
              child: Text(
                'Recusar',
                style: TextStyle(color: Color(0xffEB262D), fontSize: 17.sp),
              ),
              onPressed: () async {
                if (_
                    .usuarioById(_.uid)
                    .solicitacoesRecebidas
                    .contains(outroUsuario.uid)) {
                  await _.rejeitarSolicitacao(outroUsuario);
                  Get.back();
                } else {
                  Get.back();
                  Get.snackbar('Ops!',
                      '${outroUsuario.nome} acabou de cancelar a solicitação',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: Duration(seconds: 5));
                }
              },
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          Container(
            width: 192.w,
            height: 34.h,
            child: RaisedButton(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(31.0.w),
                  side: BorderSide(color: Color(0xff707070))),
              child: Text(
                'Bloquear',
                style: TextStyle(color: Color(0xff707070), fontSize: 17.sp),
              ),
              onPressed: () async {
                await _.bloquearUsuario(outroUsuario);
                Get.back();
              },
            ),
          ),
        ],
      );
    } else if (_.usuarioById(_.uid).contatos.contains(outroUsuario.uid)) {
    } else {
      return Container(
        width: 192.w,
        height: 34.h,
        child: RaisedButton(
          elevation: 0,
          color: Color(0xff058BC6),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(31.0.w),
              side: BorderSide(color: Color(0xff058BC6))),
          child: Text(
            'Enviar solicitação',
            style: TextStyle(color: Colors.white, fontSize: 17.sp),
          ),
          onPressed: () async {
            if (_
                .usuarioById(_.uid)
                .solicitacoesRecebidas
                .contains(outroUsuario.uid)) {
              Get.back();
              Get.snackbar('Que coincidência!',
                  '${outroUsuario.nome} acabou de te adicionar também',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: Duration(seconds: 5));
            } else {
              await _.adicionarUsuario(outroUsuario);
              Get.back();
            }
          },
        ),
      );
    }
  }
}
