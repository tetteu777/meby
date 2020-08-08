import 'package:meby/controle/controle.dart';
import 'package:meby/visao/telas/TelaBloqueados.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TelaPrivacidade extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacidade'),
        backgroundColor: Colors.black,
      ),
      body: GetBuilder<Controle>(
          init: Controle(),
          initState: (_) {},
          builder: (_) {
            return Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 17.31.w,
                    ),
                    Text(
                      'Não mostre a minha idade',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.sp,
                          color: Color(0xff676161)),
                    ),
                    SizedBox(
                      width: 60.w,
                    ),
                    Switch(
                      value: !_.usuarioById(_.uid).mostrarIdade,
                      onChanged: (mostrarIdadeSwitch) {
                        _
                            .usuarioById(_.uid)
                            .setMostrarIdade(!mostrarIdadeSwitch);
                        Controle.to.updateUsuario(_.uid, _.usuarioById(_.uid));
                      },
                    ),
                  ],
                ),
                FlatButton(
                  child: Text(
                    'Perfis bloqueados',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        color: Color(0xff676161)),
                  ),
                  onPressed: () {
                    Get.to(TelaBloqueados());
                  },
                ),
              ],
            );
          }),
    );
  }
}
