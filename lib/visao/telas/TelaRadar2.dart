import 'package:meby/controle/controle.dart';
import 'package:meby/modelo/Usuario.dart';
import 'package:meby/visao/telas/TelaMeuPerfil2.dart';
import 'package:meby/visao/widgets/PopUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'TelaContatos2.dart';

class TelaRadar2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controle>(
        init: Controle(),
        initState: (_) {
          Controle.to.firebase.getListaUIDUsuariosPerto(
              Controle.to.usuarioById(Controle.to.uid));
          Controle.to.ativarConectividadeListener();
          if (Controle.to.usuarioById(Controle.to.uid).sexoDoOutro == 'ambos') {
            Controle.to.ambos = true;
            Controle.to.feminino = false;
            Controle.to.masculino = false;
          } else if (Controle.to.usuarioById(Controle.to.uid).sexoDoOutro ==
              'feminino') {
            Controle.to.ambos = false;
            Controle.to.feminino = true;
            Controle.to.masculino = false;
          } else if (Controle.to.usuarioById(Controle.to.uid).sexoDoOutro ==
              'masculino') {
            Controle.to.ambos = false;
            Controle.to.feminino = false;
            Controle.to.masculino = true;
          }
        },
        builder: (_) {
          if (Controle.to.usuarioById(Controle.to.uid).tutorialBusca) {
            Controle.to.usuarioById(Controle.to.uid).setTutorialBusca(false);
            Future.delayed(Duration.zero, () {
              Get.dialog(PopUpTutorialRadar());
            });
          }
          _.usuariosPerto = Controle.to.todosUsuarios
              .where((element) =>
                  Controle.to.uidsPerto.contains(element.uid) &&
                  element.visivel &&
                  (element.sexo ==
                          Controle.to
                              .usuarioById(Controle.to.uid)
                              .sexoDoOutro ||
                      Controle.to.usuarioById(Controle.to.uid).sexoDoOutro ==
                          'ambos') &&
                  (!Controle.to
                      .usuarioById(Controle.to.uid)
                      .usuariosQueBloqueei
                      .contains(element.uid)) &&
                  (!Controle.to
                      .usuarioById(Controle.to.uid)
                      .usuariosQueTeBloquearam
                      .contains(element.uid)))
              .toList();
          _.usuariosPerto.sort((a, b) => a.nome.compareTo(b.nome));
          for (String s in _.uidsPerto) {
            print('perto => $s');
          }

          print('usuarios perto length ${_.usuariosPerto.length}');
          print('todos usuarios length ${_.todosUsuarios.length}');

          return Scaffold(
//            floatingActionButton: FloatingActionButton(
//              onPressed: () async {
////                //Get.dialog(PopUpTutorialRadar());
////                print(Controle.to.usuariosPerto.toString());
//
//                final result = await FlutterWebAuth.authenticate(
//                  url:
//                      "https://accounts.spotify.com/authorize?client_id=xxxxxxxxxxxxxxxxxxxxxxxxxxxxx&redirect_uri=tetteu777@outlook.com:/&scope=user-read-currently-playing&response_type=token&state=123",
//                  callbackUrlScheme: "tetteu777@outlook.com",
//                );
//
//// Extract token from resulting url
//                final token = Uri.parse(result);
//                String at = token.fragment;
//                at = "http://website/index.html?$at"; // Just for easy persing
//                var accesstoken = Uri.parse(at).queryParameters['access_token'];
//                print('token');
//                print(accesstoken);
//              },
//            ),
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text('Radar'),
              leading: IconButton(
                icon: ImageIcon(
                    AssetImage('assets/images/icones_azul_Agenda.png')),
                onPressed: () {
                  Get.off(TelaContatos2());
                },
              ),
            ),
            endDrawer: SafeArea(
              child: Drawer(
                child: Container(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Visibilidade',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                switchVisivel(_),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              width: double.infinity,
                              child: Text(
                                'Gênero',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      contruirEscolhaDeGenero(_),
                    ],
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      width: 414.w,
                      height: 83.h,
                      margin: EdgeInsets.only(top: 16.h),
                      child: Image.network(
                        'https://www.thiengo.com.br/img/post/normal/jth8tjfslfjg4n407o8no3vgt27854f0eac89f11571598553f57b0608c.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 19.w,
                            //offset: Offset(0, 1)
                          ),
                        ],
                      ),
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Container(
                              width: 77.w,
                              margin: EdgeInsets.only(left: 169.w, right: 95.w),
                              child: FittedBox(
                                child: statusRadar(_, _.usuarioById(_.uid)),
                              ),
                            ),
                            InkWell(
                                child: Container(
                                  width: 53.h,
                                  height: 53.h,
                                  margin:
                                      EdgeInsets.only(top: 8.h, bottom: 7.h),
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            _.usuarioById(_.uid).imagemUrl),
                                      ),
                                      _
                                              .usuarioById(_.uid)
                                              .solicitacoesRecebidas
                                              .isNotEmpty
                                          ? Container(
                                              width: 14.w,
                                              height: 14.w,
                                              margin:
                                                  EdgeInsets.only(left: 28.w),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xffF94A4A),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2.w)),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Get.to(TelaMeuPerfil2());
                                }),
                            //Text('${}'),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(child: conteudo(_)),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Text statusRadar(Controle _, Usuario usuario) {
    if (_.semInternet) {
      return Text(
        'Sem conexão',
        style: TextStyle(
            color: Color(0xff8E8E8E),
            fontSize: 16.sp,
            fontWeight: FontWeight.w500),
      );
    } else {
      if (usuario.visivel) {
        return Text(
          'Radar ativo',
          style: TextStyle(
              color: Color(0xff058BC6),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500),
        );
      } else {
        return Text(
          'Radar inativo',
          style: TextStyle(
              color: Color(0xff058BC6),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500),
        );
      }
    }
  }

  Widget conteudo(Controle _) {
    if (_.semInternet) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 250.h),
        child: Text(
          '----X----',
          style: TextStyle(fontSize: 30.sp),
        ),
      );
    } else {
      if (_.usuarioById(_.uid).visivel) {
        if (_.usuariosPerto.isNotEmpty) {
          return Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, i) {
                Usuario usuario = _.usuariosPerto[i];
                print('${usuario.nome}');
                print('uid ${usuario.uid}');

                return ListTile(
                    onTap: () {
                      if (_.usuarioById(_.uid).contatos.contains(usuario.uid)) {
                        //Get.to(TelaPerfilDoContato(usuario));
                      } else {
                        Get.dialog(PopUp(usuario, _));
                      }
                    },
                    title: Text(usuario.nome),
                    leading: Container(
                      width: 54.w,
                      height: 54.w,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(usuario.imagemUrl),
                      ),
                    ),
                    trailing: Container(
                      width: 146.w,
                      height: 58.h,
                      child: opcoes(_, usuario),
                    ));
              },
              itemCount: _.usuariosPerto.length,
            ),
          );
        } else {
          return Column(
            children: [
              SizedBox(
                height: 218.h,
              ),
              Container(
                width: 148.w,
                height: 124.h,
                child: Image.asset('assets/images/desert.png'),
              ),
              SizedBox(
                height: 17.h,
              ),
              Text(
                'Ninguém aqui',
                style: TextStyle(color: Color(0xff707070), fontSize: 20.sp),
              )
            ],
          );
        }
      } else {
        return Column(
          children: [
            SizedBox(
              height: 180.h,
            ),
            switchVisivel(_),
            SizedBox(
              height: 160.h,
            ),
            Container(
              padding: EdgeInsets.all(30.w),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xff8E8E8E), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(30.w)),
              ),
              child: Column(
                children: [
                  Text('Aviso',
                      style: TextStyle(
                          color: Color(0xff8E8E8E),
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Você está invisível.',
                    style: TextStyle(color: Color(0xff8E8E8E), fontSize: 13.sp),
                  ),
                  Text('Fique visível para que sua busca',
                      style:
                          TextStyle(color: Color(0xff8E8E8E), fontSize: 13.sp)),
                  Text('fique ativa novamente.',
                      style:
                          TextStyle(color: Color(0xff8E8E8E), fontSize: 13.sp)),
                ],
              ),
            )
          ],
        );
      }
    }
  }

  Widget opcoes(Controle _, Usuario outroUsuario) {
    if (_.usuarioById(_.uid).solicitacoesFeitas.contains(outroUsuario.uid)) {
      return Container(
        width: 81.w,
        height: 22.h,
        margin: EdgeInsets.symmetric(vertical: 12.5.h),
        child: RaisedButton(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.red)),
          child: Text(
            'Cancelar',
            style: TextStyle(color: Colors.red, fontSize: 14.sp),
          ),
          onPressed: () {
            _.cancelarSolicitacao(outroUsuario);
          },
        ),
      );
    } else if (_
        .usuarioById(_.uid)
        .solicitacoesRecebidas
        .contains(outroUsuario.uid)) {
      return Container(
        width: 81.w,
        height: 22.h,
        margin: EdgeInsets.symmetric(vertical: 12.5.h),
        child: RaisedButton(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Color(0xff058BC6))),
          child: Text(
            'Responder',
            style: TextStyle(color: Color(0xff058BC6), fontSize: 14.sp),
          ),
          onPressed: () {
            Get.dialog(PopUp(outroUsuario, _));
          },
        ),
      );
    } else if (_.usuarioById(_.uid).contatos.contains(outroUsuario.uid)) {
      return Container(
        child: Center(
          child: Text(
            'Meu contato',
            style: TextStyle(
                color: Color(0xff058BC6), fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60.w,
            height: 35.h,
            child: RaisedButton(
              elevation: 0,
              padding: EdgeInsets.all(0),
              color: Color(0xff058BC6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.w),
                  side: BorderSide(color: Color(0xff058BC6))),
              child: Container(
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
              onPressed: () async {
                await _.adicionarUsuario(outroUsuario);
              },
            ),
          ),
          SizedBox(
            width: 42.w,
          ),
          botaoSalvar(_, outroUsuario),
        ],
      );
    }
  }

  Widget botaoSalvar(Controle _, Usuario outroUsuario) {
    if (_.usuarioById(_.uid).solicitacoesFeitas.contains(outroUsuario.uid)) {
      return Container();
    } else if (_
        .usuarioById(_.uid)
        .solicitacoesRecebidas
        .contains(outroUsuario.uid)) {
      return Container();
    } else if (_.usuarioById(_.uid).contatos.contains(outroUsuario.uid)) {
      return Container();
    } else {
      if (_.usuarioById(_.uid).usuariosSalvos.contains(outroUsuario.uid)) {
        return InkWell(
          child: Container(
            width: 11.65.w * 1.8,
            height: 18.2.h * 1.8,
            child: FittedBox(
                child: Image.asset(
              'assets/images/salvar_on.png',
            )),
          ),
          onTap: () {
            _.removerUsuarioSalvo(outroUsuario);
          },
        );
      } else {
        return InkWell(
          child: Container(
            width: 11.65.w * 1.8,
            height: 18.2.h * 1.8,
            child: FittedBox(
                child: Image.asset(
              'assets/images/salvar_off.png',
            )),
          ),
          onTap: () {
            _.salvarUsuario(outroUsuario);
          },
        );
      }
    }
  }

  Switch switchVisivel(Controle _) {
    return Switch(
        activeColor: Color(0xff058BC6),
        value: _.usuarioById(_.uid).visivel,
        onChanged: (visivelSwitch) async {
          _.usuarioById(_.uid).setVisivel(visivelSwitch);
//            if (!estaVisivel) {
//              usuariosPerto.length = 0;
//            }

          await _.updateUsuario(_.uid, _.usuarioById(_.uid));
          if (_.usuarioById(_.uid).visivel) {
            _.iniciarGeolocator();
            if (_.usuarioById(_.uid).sexoDoOutro == 'nenhum' ||
                _.usuarioById(_.uid).sexoDoOutro == null) {
              _.usuarioById(_.uid).setSexoDoOutro('ambos');
              await _.updateUsuario(_.uid, _.usuarioById(_.uid));
              _.ambos = true;
              _.update();
            }
          } else {
            _.pararGeolocator();
          }
        });
  }

  Column contruirEscolhaDeGenero(Controle _) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
                activeColor: _.usuarioById(_.uid).visivel
                    ? Color(0xff058BC6)
                    : Color(0xff989898),
                value: _.feminino,
                onChanged: (value) async {
                  if (!_.feminino) {
                    _.ambos = false;
                    _.masculino = false;
                    _.feminino = true;
                    _.usuarioById(_.uid).setSexoDoOutro('feminino');
                  } else {
                    _.feminino = false;
                    _.usuarioById(_.uid).setSexoDoOutro('nenhum');
                    _.usuarioById(_.uid).setVisivel(false);
                  }

//                  if (_.masculino && _.feminino) {
//                    _.masculino = false;
//                    _.feminino = false;
//                    _.ambos = true;
//                    _.usuarioById(_.uid).setSexoDoOutro('ambos');
//                  }
                  _.update();
                  await _.updateUsuario(_.uid, _.usuarioById(_.uid));
                }),
            Text('Feminino'),
          ],
        ),
        Row(
          children: [
            Checkbox(
                activeColor: _.usuarioById(_.uid).visivel
                    ? Color(0xff058BC6)
                    : Color(0xff989898),
                value: _.masculino,
                onChanged: (value) async {
                  if (!_.masculino) {
                    _.ambos = false;
                    _.masculino = true;
                    _.feminino = false;
                    _.usuarioById(_.uid).setSexoDoOutro('masculino');
                  } else {
                    _.masculino = false;
                    _.usuarioById(_.uid).setSexoDoOutro('nenhum');
                    _.usuarioById(_.uid).setVisivel(false);
                  }

//                  if (_.masculino && _.feminino) {
//                    _.masculino = false;
//                    _.feminino = false;
//                    _.ambos = true;
//                    _.usuarioById(_.uid).setSexoDoOutro('ambos');
//                  }
                  _.update();
                  await _.updateUsuario(_.uid, _.usuarioById(_.uid));
                }),
            Text('Masculino'),
          ],
        ),
        Row(
          children: [
            Checkbox(
                activeColor: _.usuarioById(_.uid).visivel
                    ? Color(0xff058BC6)
                    : Color(0xff989898),
                value: _.ambos,
                onChanged: (value) async {
                  if (!_.ambos) {
                    _.ambos = true;
                    _.feminino = false;
                    _.masculino = false;
                    _.usuarioById(_.uid).setSexoDoOutro('ambos');
                  } else {
                    _.ambos = false;
                    _.usuarioById(_.uid).setSexoDoOutro('nenhum');
                    _.usuarioById(_.uid).setVisivel(false);
                  }

//                  if (_.masculino) {
//                    _.masculino = false;
//                  } else if (_.feminino) {
//                    _.feminino = false;
//                  }
                  _.update();
                  await _.updateUsuario(_.uid, _.usuarioById(_.uid));
                }),
            Text('Ambos'),
          ],
        )
      ],
    );
  }

  void construirRegrasDosCheckboxes(Controle _) {
    if (_.masculino && _.feminino) {
      _.feminino = false;
      _.ambos = false;
    }
    if (_.feminino) {
      _.masculino = false;
      _.ambos = false;
    }
    if (_.ambos) {
      _.masculino = false;
      _.feminino = false;
    }
    _.update();
  }

  Widget PopUpTutorialRadar() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: 296.w,
              height: 665.h,
              margin: EdgeInsets.only(
                  top: 50.h, left: 59.w, right: 59.w, bottom: 0.h),
              color: Colors.white,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 21.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      child: Text(
                        'Você está na área de busca, onde serão listados todos os usuários próximos, em um raio de 100m.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff4B4B4B),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(
                      thickness: 0.2,
                      color: Colors.black,
                    ),
                    Container(
                      width: 60.w,
                      height: 35.h,
                      child: RaisedButton(
                        elevation: 0,
                        padding: EdgeInsets.all(0),
                        color: Color(0xff058BC6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.w),
                            side: BorderSide(color: Color(0xff058BC6))),
                        child: Container(
                          child: Text(
                            'Add',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                          ),
                        ),
                        onPressed: () async {},
                      ),
                    ),
                    Container(
                      child: Text(
                        'Este é o botão de adição rápida. Clique na foto ou nome, caso queira visualizar uma prévia do perfil',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff4B4B4B),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Divider(
                      thickness: 0.2,
                      color: Colors.black,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'Meu contato',
                          style: TextStyle(
                              color: Color(0xff058BC6),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Indica que o perfil listado já faz parte dos seus contatos.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff4B4B4B),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Divider(
                      thickness: 0.2,
                      color: Colors.black,
                    ),
                    Container(
                      width: 81.w,
                      height: 22.h,
                      margin: EdgeInsets.symmetric(vertical: 12.5.h),
                      child: RaisedButton(
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        child: FittedBox(
                          child: Text(
                            'Cancelar',
                            style:
                                TextStyle(color: Colors.red, fontSize: 14.sp),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      child: Text(
                        'Cancelar solicitação enviada.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff4B4B4B),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Divider(
                      thickness: 0.2,
                      color: Colors.black,
                    ),
                    Container(
                      width: 11.65.w * 2.5,
                      height: 18.2.h * 2.5,
                      child: Icon(Icons.bookmark),
                    ),
                    Container(
                      child: Text(
                        'Salvar para add depois.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff4B4B4B),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Divider(
                      thickness: 0.2,
                      color: Colors.black,
                    ),
                    Container(
                      width: 81.w,
                      height: 22.h,
                      margin: EdgeInsets.symmetric(vertical: 12.5.h),
                      child: RaisedButton(
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xff058BC6))),
                        child: FittedBox(
                          child: Text(
                            'Responder',
                            style: TextStyle(
                                color: Color(0xff058BC6), fontSize: 14.sp),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      child: Text(
                          'Indica que o perfil listado já te enviou uma solicitação',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xff4B4B4B),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400)),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 174.w, right: 174.w, top: 755.h),
              child: GestureDetector(
                child: Container(
                  width: 66.w,
                  height: 66.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Icon(Icons.clear),
                ),
                onTap: () {
                  Get.back();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
