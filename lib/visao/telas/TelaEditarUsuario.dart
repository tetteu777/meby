import 'package:flutter/services.dart';
import 'package:meby/controle/controle.dart';
import 'package:meby/visao/telas/TelaMeuPerfil2.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastroFoto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TelaEditarUsuario extends StatelessWidget {
  static const String rota = '/telaEditarUsuario';

  Controle _ = Controle.to;

  TextEditingController nomeControle;
  TextEditingController profissaoControle;
  TextEditingController bioControle;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controle>(
        init: _,
        builder: (_) {
          nomeControle = TextEditingController(text: _.usuarioById(_.uid).nome);
          profissaoControle =
              TextEditingController(text: _.usuarioById(_.uid).profissao);
          bioControle = TextEditingController(text: _.usuarioById(_.uid).bio);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              iconTheme: IconThemeData(color: Colors.white),
              title: Text('Editar perfil'),
              actions: [
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () async {
                    if (nomeControle.text.length > 0) {
                      _.usuarioById(_.uid).setNome(nomeControle.text);
                    }
                    if (profissaoControle.text.length > 0) {
                      _.usuarioById(_.uid).setProfissao(profissaoControle.text);
                    }
                    //if (bioTextController.text.length > 0) {
                    _.usuarioById(_.uid).setBio(bioControle.text);
                    // }
                    Controle.to.updateUsuario(_.uid, _.usuarioById(_.uid));

                    Get.off(TelaMeuPerfil2());
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 216.h,
                      height: 216.h,
                      margin: EdgeInsets.only(top: 46.h, bottom: 20.h),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(_.usuarioById(_.uid).imagemUrl),
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        'Alterar foto',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff058BC6)),
                      ),
                      onPressed: () {
                        Get.to(TelaCadastroFoto());
                        //TODO: Navigator
//                      Navigator.pushNamed(context, TelaCadastroFoto.rota,
//                          arguments: _usuario);
                      },
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 35.w),
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Por favor, digite seu nome completo';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Nome',
                            ),
                            controller: nomeControle,
                          ),
                          TextFormField(
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Por favor, digite sua profissão';
                              }
                              return null;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30)
                            ],
                            decoration: InputDecoration(labelText: 'Profissão'),
                            controller: profissaoControle,
                            maxLengthEnforced: true,
                            //maxLength: 30,
                          ),
                          SizedBox(
                            height: 0.h,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(150)
                            ],
                            //maxLength: 150,
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Por favor, digite sua bio';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'Bio'),
                            controller: bioControle,
                          ),
                        ],
                      ),
                    ),

//            RaisedButton(
//              child: Text('Próximo'),
//              onPressed: () async {
////                _usuario.setNome(nomeTextController.text);
////
////                await usuarioProvider.updateUsuario(_usuario, _usuario.uid);
//                Navigator.pushNamed(context, TelaMeuPerfil.rota);
//              },
//            ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
