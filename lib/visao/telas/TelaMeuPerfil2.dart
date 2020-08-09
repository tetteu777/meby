import 'package:flutter_svg/svg.dart';
import 'package:meby/controle/controle.dart';
import 'package:meby/modelo/Usuario.dart';
import 'package:meby/util/CalculadoraDeIdade.dart';
import 'package:meby/visao/telas/TelaContas.dart';
import 'package:meby/visao/telas/TelaEditarUsuario.dart';
import 'package:meby/visao/telas/TelaPerfilDoContato.dart';
import 'package:meby/visao/telas/TelaPrivacidade.dart';
import 'package:meby/visao/telas/TelaRadar2.dart';
import 'package:meby/visao/telas/welcomeBack/WelcomeEmail.dart';
import 'package:meby/visao/telas/welcomeBack/WelcomeFacebook.dart';
import 'package:meby/visao/telas/welcomeBack/WelcomeGoogle.dart';
import 'package:meby/visao/widgets/PopUp.dart';
import 'package:meby/visao/widgets/PopUpCompartilharMeuPerfil.dart';
import 'package:meby/visao/widgets/PopUpDesconectar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'TelaContatos2.dart';

class TelaMeuPerfil2 extends StatelessWidget {
  bool fromShare = false;

  PageController _controller = PageController(
    initialPage: 0,
  );

  TelaMeuPerfil2({this.fromShare});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: ImageIcon(AssetImage('assets/images/icones_azul_Agenda.png')),
          onPressed: () {
            Get.off(TelaContatos2());
          },
        ),
      ),
      endDrawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                child: Text(
                  Controle.to.usuarioById(Controle.to.uid).nome,
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Divider(
                    thickness: 2,
                  )),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(top: 20.h),
                  padding: EdgeInsets.all(10.w),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 23.w,
                      ),
                      Icon(Icons.edit),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Editar Perfil',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xff707070),
                            fontSize: 18.sp),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Get.to(TelaEditarUsuario());
                },
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(top: 20.h),
                  padding: EdgeInsets.all(10.w),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Icon(Icons.security),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Privacidade',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xff707070),
                            fontSize: 18.sp),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Get.to(TelaPrivacidade());
                },
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(top: 20.h),
                  padding: EdgeInsets.all(10.w),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Container(
//                        width: 18.w,
//                        height: 18.w,
                        child: Icon(Icons.account_circle),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Conta',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xff707070),
                            fontSize: 18.sp),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  TODO:
                  Get.to(TelaContas());
                },
              ),
              GestureDetector(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    padding: EdgeInsets.all(10.w),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        Icon(Icons.clear),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Desconectar',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color(0xff707070),
                              fontSize: 18.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  Get.dialog(PopUpDesconectar());
                },
              ),
            ],
          ),
        ),
      ),
      body: GetBuilder<Controle>(
          initState: (_) {
            Controle.to.selectedIndex = 0;
            Controle.to.solicitacoesIndex = 0;
            if (fromShare ?? false) {
              Controle.to.selectedIndex = 1;
              Future.delayed(Duration(seconds: 1), () {
                _controller.animateToPage(1,
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
              });
            }
          },
          init: Controle.to,
          builder: (_) {
            return PageView(
              onPageChanged: (num) {
                _.selectedIndex = num;
                _.update();
              },
              controller: _controller,
              children: <Widget>[
                Resumo(_),
                Solicitacoes(_),
              ],
            );

//            if (_.selectedIndex == 0) {
//              return Resumo(_);
//            } else {
//              return Solicitacoes(_);
//            }
          }),
      bottomNavigationBar: GetBuilder<Controle>(
          init: Controle.to,
          builder: (_) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    width: 153.w,
                    height: 70.h,
                    child: Container(
                      margin: EdgeInsets.only(top: 10.h),
                      width: 153.w,
                      height: 40.h,
                      child: Column(
                        children: [
                          Container(
                            height: 10.h,
                          ),
                          Container(
                            width: 40.w,
                            height: 40.h,
                            child: SvgPicture.asset(
                                'assets/images/icon_meu_perfil_cinza.svg')
                          ),
                          Container(
                            height: 5.h,
                          ),
                          Container(
                            width: 153.w,
                            height: 5.h,
                          )
                        ],
                      ),
                    ),
                  ),
                  activeIcon: Container(
                    width: 153.w,
                    height: 70.h,
                    child: Container(
                      margin: EdgeInsets.only(top: 10.h),
                      width: 153.w,
                      height: 40.h,
                      child: Column(
                        children: [
                          Container(
                            height: 10.h,
                          ),
                          Container(
                            width: 40.w,
                            height: 40.h,
                            child: SvgPicture.asset(
                                'assets/images/icon meu perfil azul.svg',  color: Color(0xff058BC6)),
                          ),
                          Container(
                            height: 5.h,
                          ),
                          Container(
                            width: 153.w,
                            height: 5.h,
                            color: Color(0xff058BC6),
                          )
                        ],
                      ),
                    ),
                  ),
                  title: Container(),
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 153.w,
                    height: 70.h,
                    child: Stack(
                      children: [
                        Container(
                          width: 153.w,
                          height: 70.h,
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 20.h),
                                width: 153.w,
                                height: 40.h,
                                child: Container(
                                  width: 20.w,
                                  height: 20.h,
                                  child: ImageIcon(AssetImage(
                                      'assets/images/solicitacoes_azul.png')),
                                ),
                              ),
                              _
                                      .usuarioById(_.uid)
                                      .solicitacoesRecebidas
                                      .isNotEmpty
                                  ? Container(
                                      width: 153.w,
                                      child: Container(
                                        width: 20.w,
                                        height: 20.w,
                                        margin: EdgeInsets.only(left: 20.w),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffEB262D),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 0,
                                      height: 0,
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  activeIcon: Container(
                    width: 153.w,
                    height: 70.h,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20.h),
                          width: 153.w,
                          height: 40.h,
                          child: Container(
                            width: 20.w,
                            height: 20.h,
                            child: ImageIcon(AssetImage(
                                'assets/images/solicitacoes_azul.png')),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              width: 153.w,
                              height: 65.h,
                              color: Colors.transparent,
                            ),
                            Container(
                              width: 153.w,
                              height: 5.h,
                              color: Color(0xff058BC6),
                            ),
                          ],
                        ),
                        _.usuarioById(_.uid).solicitacoesRecebidas.isNotEmpty
                            ? Container(
                                width: 153.w,
                                child: Container(
                                  width: 20.w,
                                  height: 20.w,
                                  margin: EdgeInsets.only(left: 20.w),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffEB262D),
                                  ),
                                ),
                              )
                            : Container(
                                width: 0,
                                height: 0,
                              ),
                      ],
                    ),
                  ),
                  title: Container(),
                ),
              ],
              currentIndex: _.selectedIndex,
              selectedItemColor: Color(0xff058BC6),
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: TextStyle(color: Colors.grey),
              onTap: (value) {
                _onItemTapped(value, _);
              },
            );
          }),
    );
  }

  void _onItemTapped(int value, Controle _) {
    _.selectedIndex = value;
    _controller.animateToPage(value,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    if (_.selectedIndex == 1) {
      _.solicitacoesIndex = 0;
    }
    _.update();
  }

  Widget Resumo(Controle _) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 176.h,
            height: 176.h,
            margin: EdgeInsets.only(top: 46.h),
            child: CircleAvatar(
              backgroundImage: NetworkImage(_.usuarioById(_.uid).imagemUrl),
            ),
          ),
          Container(
            width: 190.w,
            height: 41.h,
            margin: EdgeInsets.only(top: 39.h, left: 112.w, right: 112.w),
            child: FittedBox(
              alignment: Alignment.center,
              child: Text(
                '${_.usuarioById(_.uid).nome}, ${CalculadoraDeIdade.obterIdade(_.usuarioById(_.uid).dataDeNascimento.toString())}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 31.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: Get.width,
            height: 41.h,
            child: Container(
              child: FittedBox(
                fit: BoxFit.none,
                alignment: Alignment.center,
                child: Text(
                  ' ${_.usuarioById(_.uid).profissao}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4E4D4D)),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.defaultDialog(
                title: 'Bio',
                middleText: '${_.usuarioById(_.uid).bio}',
              );
            },
            child: Container(
              width: 278.w,
              height: 82.h,
              margin: EdgeInsets.only(
                  top: 20.h, left: 68.w, right: 68.w, bottom: 20.h),
              child: Text(
                _.usuarioById(_.uid).bio,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Color(0xff707070),
                ),
              ),
            ),
          ),
          Container(
            width: 180.w,
            height: 35.h,
            margin: EdgeInsets.only(),
            child: RaisedButton(
              elevation: 0,
              color: Color(0xff058BC6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.w),
                  side: BorderSide(color: Color(0xff058BC6))),
              child: Text(
                'Ver como visitante',
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
              ),
              onPressed: () {
                Get.to(TelaPerfilDoContato(_.usuarioById(_.uid)));
              },
            ),
          ),
          Container(
            width: 165.44.w,
            height: 63.44.h,
            margin: EdgeInsets.only(top: 50.h, left: 124.w, right: 124.56.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    color: Colors.white,
                    width: 63.44.h,
                    height: 63.44.h,
                    child: SvgPicture.asset('assets/images/icone_Pesquisa.svg'),
                  ),
                  onTap: () {
                    Get.off(TelaRadar2());
                  },
                ),
                SizedBox(
                  width: 38.65.w,
                ),
                Container(
                  width: 63.44.h,
                  height: 63.44.h,
                  decoration: BoxDecoration(
                      color: Color(0xff058BC6),
                      borderRadius: BorderRadius.all(Radius.circular(60.w))),
                  child: IconButton(
                    icon: Container(
                      width: 30.71.w,
                      height: 36.33.h,
                      child: SvgPicture.asset('assets/images/compartilhar.svg', color: Colors.white)),
                    onPressed: () {
                      Get.dialog(
                          PopUpCompartilharMeuPerfil(_.usuarioById(_.uid), _));
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget Solicitacoes(Controle _) {
    return Column(
      children: [
        feitasRecebidasSalvos(_),
        lista(_),
      ],
    );
  }

  Container lista(Controle _) {
    List<Usuario> usuarios = List<Usuario>();
    if (_.solicitacoesIndex == 0) {
      usuarios = _.todosUsuarios
          .where(
              (u) => _.usuarioById(_.uid).solicitacoesRecebidas.contains(u.uid))
          .toList();
    } else if (_.solicitacoesIndex == 1) {
      usuarios = _.todosUsuarios
          .where((u) => _.usuarioById(_.uid).solicitacoesFeitas.contains(u.uid))
          .toList();
    } else if (_.solicitacoesIndex == 2) {
      usuarios = _.todosUsuarios
          .where((u) =>
              _.usuarioById(_.uid).usuariosSalvos.contains(u.uid) &&
              !_.usuarioById(_.uid).solicitacoesFeitas.contains(u.uid) &&
              !_.usuarioById(_.uid).contatos.contains(u.uid) &&
              !_.usuarioById(_.uid).solicitacoesRecebidas.contains(u.uid))
          .toList();
    }

    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (ctx, i) {
          return Container(
            width: Get.width,
            height: 55.h,
            child: ListTile(
              onTap: () {
                Get.dialog(PopUp(usuarios[i], _));
              },
              leading: Container(
                width: 55.h,
                height: 55.h,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(usuarios[i].imagemUrl),
                ),
              ),
              title: Text(
                usuarios[i].nome,
                style: TextStyle(
                    color: Color(0xff676161),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              ),
              trailing: Container(
                width: 146.w,
                height: double.infinity,
                child: opcoes(_, usuarios[i]),
              ),
            ),
          );
        },
        itemCount: usuarios.length,
      ),
    );
  }

  Container feitasRecebidasSalvos(Controle _) {
    return Container(
      width: Get.width,
      height: 58.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            children: [
              botao(_, 0, 'Recebidas'),
              _.usuarioById(_.uid).solicitacoesRecebidas.isNotEmpty
                  ? Container(
                      width: 14.w,
                      height: 14.w,
                      margin: EdgeInsets.only(left: 100.w),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffF94A4A),
                          border: Border.all(color: Colors.white, width: 2.w)),
                    )
                  : Container(
                      width: 0,
                      height: 0,
                    ),
            ],
          ),
          botao(_, 1, 'Feitas'),
          botao(_, 2, 'Salvos'),
        ],
      ),
    );
  }

  Container botao(Controle _, int opcao, String textoDoBotao) {
    if (_.solicitacoesIndex == opcao) {
      return Container(
        width: 110.w,
        height: 31.h,
        child: RaisedButton(
          elevation: 0,
          padding: EdgeInsets.all(0),
          color: Color(0xff058BC6),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Color(0xff058BC6))),
          child: Text(
            textoDoBotao,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            _.solicitacoesIndex = opcao;
            _.update();
          },
        ),
      );
    } else {
      return Container(
        width: 110.w,
        height: 31.h,
        child: RaisedButton(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.white)),
          child: FittedBox(
            child: Text(
              textoDoBotao,
              style: TextStyle(color: Colors.black54, fontSize: 15.sp),
            ),
          ),
          onPressed: () {
            _.solicitacoesIndex = opcao;
            _.update();
          },
        ),
      );
    }
  }

  Widget opcoes(Controle _, Usuario usuario) {
    if (_.solicitacoesIndex == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Container(
              width: 34.w,
              height: 34.h,
              margin: EdgeInsets.only(right: 45.5.w),
              child: Image.asset('assets/images/aceitar.png'),
            ),
            onTap: () {
              _.aceitarSolicitacao(usuario);
            },
          ),
          InkWell(
            child: Container(
              width: 34.w,
              height: 34.h,
              margin: EdgeInsets.only(),
              child: Image.asset('assets/images/recusar.png'),
            ),
            onTap: () {
              _.rejeitarSolicitacao(usuario);
            },
          )
        ],
      );
    } else if (_.solicitacoesIndex == 1) {
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
            _.cancelarSolicitacao(usuario);
          },
        ),
      );
    } else if (_.solicitacoesIndex == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60.w,
            height: 28.h,
            child: RaisedButton(
              elevation: 0,
              padding: EdgeInsets.all(0),
              color: Color(0xff058BC6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Color(0xff058BC6))),
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _.adicionarUsuario(usuario);
              },
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          InkWell(
            child: Container(
              width: 28.w,
              height: 28.h,
              margin: EdgeInsets.only(),
              child: Icon(
                Icons.clear,
                color: Colors.grey,
                size: 21.w,
              ),
            ),
            onTap: () {
              _.removerUsuarioSalvo(usuario);
            },
          )
        ],
      );
    }
  }
}
