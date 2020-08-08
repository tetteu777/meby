import 'package:meby/controle/controle.dart';
import 'package:meby/modelo/Usuario.dart';
import 'package:meby/visao/telas/TelaMeuPerfil2.dart';
import 'package:meby/visao/telas/TelaRadar2.dart';
import 'package:meby/visao/telas/TelaSuporte.dart';
import 'package:meby/visao/widgets/PopUpCompartilhar.dart';
import 'package:meby/visao/widgets/PopUpDeletar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/target_position.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'TelaPerfilDoContato.dart';

class TelaContatos2 extends StatelessWidget {
  List<TargetFocus> targets = List();
  GlobalKey keyButton = GlobalKey();
  TextEditingController pesquisar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Contatos'),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  child: FlatButton(
                    child: Text('Convidar um amigo'),
                    onPressed: () {
                      Controle.to
                          .convidar(Controle.to.usuarioById(Controle.to.uid));
                    },
                  ),
                ),
                PopupMenuItem(
                  child: FlatButton(
                    child: Text('Suporte'),
                    onPressed: () {
                      Get.to(TelaSuporte());
                    },
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: GetBuilder<Controle>(
          init: Controle.to,
          initState: (_) {
            Controle.to.obterMeusContatos();
            if (Controle.to.usuarioById(Controle.to.uid).visivel) {
              if (Controle.to.positionStream == null) {
                Controle.to.iniciarGeolocator();
              }
            }

            //FocusScope.of(context).unfocus();

            targets.add(TargetFocus(
                identify: "Target 1",
//                targetPosition:
//                    TargetPosition(Size(Get.width, 54.h), Offset(0, 287.h)),
                keyTarget: keyButton,
                shape: ShapeLightFocus.RRect,
                contents: [
                  ContentTarget(
                      align: AlignContent.bottom,
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Este é o seu novo contato!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20.0.sp),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                "Arraste para direita para compartilhar ou para esquerda se quiser excluir o contato.\n\nVocê também pode facilmente adicioná-lo à sua agenda do celular apertando e segurando o contato.",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ))
                ]));

            if (Controle.to.usuarioById(Controle.to.uid).primeiroContato &&
                Controle.to.usuarioById(Controle.to.uid).contatos.length > 0) {
              Controle.to
                  .usuarioById(Controle.to.uid)
                  .setPrimeiroContato(false);
              Controle.to.updateUsuario(
                  Controle.to.uid, Controle.to.usuarioById(Controle.to.uid));
              Future.delayed(Duration(seconds: 2), () {
                showTutorial(context);
              });
            }
          },
          builder: (_) {
            if (!_.pesquisarOn) {
              _.contatos = _.todosUsuarios
                  .where((usuario) =>
                      _.usuarioById(_.uid).contatos.contains(usuario.uid))
                  .toList();
            }

            _.contatos.sort((a, b) => a.nome.compareTo(b.nome));
            print(_.contatos.length);

            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 36.h,
                    ),
                    Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15.w,
                          ),
                          Container(
                            width: 292.w,
                            height: 75.h,
                            child: Material(
                              elevation: 20.0,
                              shadowColor: Colors.black.withOpacity(0.6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.w)),
                              child: TextField(
                                controller: pesquisar,
                                onChanged: (String text) {
                                  _.contatos = _.todosUsuarios
                                      .where((u) => _
                                          .usuarioById(_.uid)
                                          .contatos
                                          .contains(u.uid))
                                      .toList();
                                  if (text.length > 0) {
                                    _.textoPesquisa = text;
                                    _.pesquisarOn = true;
                                    _.contatos = _.contatos
                                        .where((usuario) => usuario.nome
                                            .toLowerCase()
                                            .contains(text.toLowerCase()))
                                        .toList();
                                    print('contaos ${_.contatos.length}');
                                  } else {
                                    _.textoPesquisa = '';
                                    _.pesquisarOn = false;
                                    _.contatos = _.todosUsuarios
                                        .where((u) => _
                                            .usuarioById(_.uid)
                                            .contatos
                                            .contains(u.uid))
                                        .toList();
                                    print('contaos ${_.contatos.length}');
                                  }
                                  _.update();
                                },
                                decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    suffixIcon: _.pesquisarOn
                                        ? InkWell(
                                            onTap: () {
                                              pesquisar.text = '';
                                              _.textoPesquisa = '';
                                              _.pesquisarOn = false;
                                              _.contatos = _.todosUsuarios
                                                  .where((u) => _
                                                      .usuarioById(_.uid)
                                                      .contatos
                                                      .contains(u.uid))
                                                  .toList();
                                              _.update();
                                            },
                                            child: Icon(
                                              Icons.clear,
                                              color: Colors.grey,
                                            ),
                                          )
                                        : SizedBox(
                                            width: 0,
                                            height: 0,
                                            child: Container()),
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.w),
                                      ),
                                    ),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0.w),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 0)),
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    prefixIcon: Icon(Icons.search),
                                    hintText: 'Pesquisar',
                                    hintStyle: TextStyle(fontSize: 16.sp)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 32.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(TelaMeuPerfil2());
                            },
                            child: Container(
                              width: 60.w,
                              height: 60.w,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 60.w,
                                    height: 60.w,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(_
                                          .usuarioById(Controle.to.uid)
                                          .imagemUrl),
                                    ),
                                  ),
                                  _
                                          .usuarioById(_.uid)
                                          .solicitacoesRecebidas
                                          .isNotEmpty
                                      ? Container(
                                          width: 20.w,
                                          height: 20.w,
                                          margin: EdgeInsets.only(left: 43.w),
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
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 36.h,
                    ),
                    listaDeContatos(_, context)
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff058BC6),
        child: ImageIcon(
          AssetImage('assets/images/iconepesquisa.png'),
          size: 50,
        ),
        onPressed: () {
          Get.to(TelaRadar2());
          //showTutorial(context);
        },
      ),
    );
  }

  bool teste(Controle _, int i) {
    if (i == 0) {
      return true;
    } else if (_.contatos[i - 1].nome.substring(0, 1) !=
        _.contatos[i].nome.substring(0, 1)) {
      return true;
    } else {
      return false;
    }
  }

  Container listaDeContatos(Controle _, BuildContext context) {
    if (_.usuarioById(_.uid).contatos.isEmpty) {
      return Container(
        child: Column(
          children: [
            Container(
              color: Color(0xffF0ECEC),
              width: Get.width,
              height: 24.h,
              child: Container(
                margin: EdgeInsets.only(left: 30.w),
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sem contatos',
                    style: TextStyle(
                        color: Color(0xffA9A7A7),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              child: ListTile(
                onTap: () {
                  _.convidar(_.usuarioById(_.uid));
                },
                title: Text(
                  'Convidar amigos',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff676161),
                  ),
                ),
                leading: Container(
                  width: 54.w,
                  height: 54.w,
                  child: CircleAvatar(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xff058BC6),
                    child: Container(
                      padding: EdgeInsets.all(11.w),
                      child: Image.asset(
                        'assets/images/compartilhar.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      if (_.contatos.length == 0) {
        return Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50.h,
              ),
              Text(
                "Sem resultado para '${_.textoPesquisa}'",
                style: TextStyle(
                    color: Color(0xff676161),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      } else {
        return Container(
          child: Column(
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (ctx, i) {
                  return Column(
                    children: [
                      teste(_, i)
                          ? Container(
                              color: Color(0xffF0ECEC),
                              width: Get.width,
                              height: 24.h,
                              margin: EdgeInsets.only(bottom: 10.h),
                              child: Container(
                                  margin: EdgeInsets.only(left: 30.w),
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _.contatos[i].nome
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Color(0xffA9A7A7),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            )
                          : Container(),
                      Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        actions: [
                          IconSlideAction(
                            caption: 'Compartilhar',
                            color: Color(0xff058BC6),
                            icon: Icons.share,
                            onTap: () {
                              Get.dialog(PopUpCompartilhar(
                                _.contatos[i],
                                _,
                              ));

                              //_.compartilhar(_.contatos[i]);
                            },
                          ),
                        ],
                        secondaryActions: [
                          IconSlideAction(
                            caption: 'Deletar',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {
                              Get.dialog(PopUpDeletar(
                                _.contatos[i],
                                _,
                              ));
                            },
                          ),
                        ],
                        child: ListTile(
                          key: keyButton,
                          onTap: () {
                            Get.to(TelaPerfilDoContato(_.contatos[i]));
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          },
                          onLongPress: () async {
                            print('long press');
                            if (await Permission.contacts.request().isGranted ==
                                false) {
                              await Permission.contacts.request();
                            }

                            await ContactsService.addContact(Contact(
                                givenName: _.contatos[i].nome,
                                familyName: '',
                                phones: [
                                  Item(
                                      label: 'mobile',
                                      value: _.contatos[i].whatsapp ??
                                          '48999999999')
                                ]));

                            Get.snackbar('Pronto',
                                '${_.contatos[i].nome} foi adicionado à sua agenda do celular',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Color(0xff058BC6),
                                colorText: Colors.white);
                          },
                          title: Text(
                            _.contatos[i].nome,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff676161),
                            ),
                          ),
                          leading: Container(
                            width: 54.w,
                            height: 54.w,
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(_.contatos[i].imagemUrl),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: _.contatos.length,
              ),
              Container(
                child: ListTile(
                  onTap: () {
                    _.convidar(_.usuarioById(_.uid));
                  },
                  title: Text(
                    'Convidar amigos',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff676161),
                    ),
                  ),
                  leading: Container(
                    width: 54.w,
                    height: 54.w,
                    child: CircleAvatar(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xff058BC6),
                      child: Container(
                        padding: EdgeInsets.all(11.w),
                        child: Image.asset(
                          'assets/images/compartilhar.png',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }
    }
  }

  void popUpExcluir(BuildContext context, Usuario usuario, Controle _) {
    Widget cancelaButton = FlatButton(
      child: Text("Não",
          style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 20)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continuaButton = FlatButton(
      child: Text("Sim",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20)),
      onPressed: () async {
        await _.removerContato(usuario);

        Get.back();
      },
    );
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Deseja realmente excluir ${usuario.nome}?",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black54),
      ),
      content: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            cancelaButton,
            continuaButton,
          ],
        ),
      ),
    );
    //exibe o diálogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showTutorial(BuildContext context) {
    TutorialCoachMark(context,
        targets: targets,
        // List<TargetFocus>
        colorShadow: Color(0xff058BC6),
        // DEFAULT Colors.black
        // alignSkip: Alignment.bottomRight,
        textSkip: "Entendi",
        textStyleSkip: TextStyle(
            fontSize: 26.sp, fontWeight: FontWeight.bold, color: Colors.white),
        // paddingFocus: 10,
        opacityShadow: 0.8, finish: () {
      print("finish");
    }, clickTarget: (target) {
      print(target);
    }, clickSkip: () {
      print("skip");
    })
      ..show();
  }
}
