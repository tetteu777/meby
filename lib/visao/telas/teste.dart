//import 'package:MeetBy/controle/controle.dart';
//import 'package:MeetBy/modelo/Usuario.dart';
//import 'package:MeetBy/util/CalculadoraDeIdade.dart';
//import 'package:flutter/material.dart';
//import 'package:get/get.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//
//class Teste extends StatelessWidget {
//  Usuario outroUsuario;
//  Controle _;
//
//  Teste(this.outroUsuario, this._);
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Stack(
//        children: [
//          Container(
//            width: 338.w,
//            height: 407.h,
//            margin: EdgeInsets.only(
//                top: 192.h, bottom: 297.h, left: 38.w, right: 38.w),
//            color: Colors.white,
//            child: Column(
//              children: [
//                Container(
//                  width: 340.w,
//                  color: Colors.white,
//                  padding: EdgeInsets.only(top: 33.h),
//                  child: Column(
//                    children: [
//                      _.usuarioById(_.uid).mostrarIdade
//                          ? Text(
//                        '${outroUsuario.nome}, ${CalculadoraDeIdade.obterIdade(outroUsuario.dataDeNascimento.toString())}',
//                        textAlign: TextAlign.center,
//                        style: TextStyle(
//                            fontSize: 29.sp, fontWeight: FontWeight.bold),
//                      )
//                          : Text(
//                        '${outroUsuario.nome}',
//                        textAlign: TextAlign.center,
//                        style: TextStyle(fontSize: 26),
//                      ),
//                      Text(
//                        '${outroUsuario.profissao}',
//                        textAlign: TextAlign.left,
//                        style: TextStyle(
//                            fontSize: 13.sp, color: Color(0xff4E4D4D)),
//                      ),
//                      SizedBox(
//                        height: 21.h,
//                      ),
//                      Container(
//                          width: 206.w,
//                          height: 48.h,
//                          margin: EdgeInsets.symmetric(horizontal: 40.w),
//                          child: Text(
//                            '${outroUsuario.bio ?? '...'}',
//                            style: TextStyle(
//                                color: Color(0xff676161), fontSize: 18.sp),
//                            textAlign: TextAlign.center,
//                          )),
//                      SizedBox(
//                        height: 15.h,
//                      ),
//                      Container(
//                        child: Opcoes(_, outroUsuario),
//                      ),
//                      SizedBox(
//                        height: 31.h,
//                      )
//                    ],
//                  ),
//                ),
//              ],
//            ),
//          ),
//          Container(
//            width: 154.w,
//            height: 154.w,
//            margin: EdgeInsets.only(
//                top: 113.h, bottom: 629.h, left: 130.w, right: 130.w),
//            decoration: new BoxDecoration(
//              color: const Color(0xff7c94b6),
//              image: new DecorationImage(
//                image: new NetworkImage(outroUsuario.imagemUrl),
//                fit: BoxFit.cover,
//              ),
//              borderRadius: new BorderRadius.all(new Radius.circular(77.w)),
//              border: new Border.all(
//                color: Colors.white,
//                width: 3.w,
//              ),
//              boxShadow: <BoxShadow>[
//                BoxShadow(
//                    color: Colors.black54,
//                    blurRadius: 15.w,
//                    offset: Offset(0.0, 0.75))
//              ],
//            ),
//          ),
//          Container(
//            margin: EdgeInsets.only(
//              top: 738.h,
//              bottom: 92.h,
//              left: 174.w,
//              right: 174.w
//            ),
//            child: GestureDetector(
//              child: Container(
//                width: 66.w,
//                height: 66.h,
//                decoration: BoxDecoration(
//                    shape: BoxShape.circle, color: Colors.white),
//                child: Icon(Icons.clear),
//              ),
//              onTap: () {
//                Get.back();
//              },
//            ),
//          )
//        ],
//      ),
//    );
//  }
//}
