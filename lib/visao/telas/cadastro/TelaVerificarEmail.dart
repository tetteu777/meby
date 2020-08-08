import 'dart:async';

import 'package:meby/controle/controle.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastro.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastroNome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TelaVerificarEmail extends StatelessWidget {
  String email;

  Timer _timer;

  TelaVerificarEmail(this.email);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: GetBuilder<Controle>(
            init: Controle.to,
            initState: (_) {
              Future(() async {
                _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
                  await FirebaseAuth.instance.currentUser()
                    ..reload();
                  var user = await FirebaseAuth.instance.currentUser();
                  if (user.isEmailVerified) {
                    Controle.to.isUserEmailVerified = user.isEmailVerified;
                    Controle.to.update();
                    timer.cancel();
                  }
                });
              });
            },
            dispose: (_) {
              if (_timer != null) {
                _timer.cancel();
              }
            },
            builder: (_) {
              return SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 35.w),
                        child: Text(
                          'Enviamos um email para o endereço $email. Clique no link para ativar e completar o seu cadastro.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      _.isUserEmailVerified
                          ? RaisedButton(
                              color: Color(0xff058BC6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xff058BC6)),
                              ),
                              child: Text('Continuar',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                Get.off(TelaCadastroNome());
                              },
                            )
                          : Container(),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
