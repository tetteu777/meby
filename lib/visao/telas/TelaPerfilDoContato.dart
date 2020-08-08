import 'package:meby/controle/controle.dart';
import 'package:meby/util/CalculadoraDeIdade.dart';
import 'package:meby/visao/telas/TelaContatos2.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:meby/modelo/Usuario.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TelaPerfilDoContato extends StatelessWidget {
  static const rota = '/telaPerfilDoContato';
  Usuario outroUsuario;

  TelaPerfilDoContato(this.outroUsuario);

  Controle _ = Controle.to;

  void controlarClick(String click, Usuario outroUsuario) {
    switch (click) {
      case 'Compartilhar Perfil':
        _.compartilhar(outroUsuario);
        break;
      case 'Bloquear contato':
        if (_.usuarioById(_.uid).uid != outroUsuario.uid) {
          _.bloquearUsuario(outroUsuario);
        } else {
          _showDialog(Get.context, 'Modo visitante',
              'Opção bloquear desabilitada no modo visitante');
        }
        break;

      case 'Deletar Contato':
        if (_.usuarioById(_.uid).uid != outroUsuario.uid) {
          popUpExcluir(Get.context);
        } else {
          _showDialog(Get.context, 'Modo visitante',
              'Opção deletar desabilitada no modo visitante');
        }
        break;
      default:
    }
  }

  void _showDialog(BuildContext context, String titulo, String conteudo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text(titulo),
          content: new Text(conteudo),
          actions: <Widget>[
            // define os botões na base do dialogo
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void compartilhar(BuildContext context, Usuario contato) {
    final String text = 'Confira o perfil de: ${contato.nome}';

    createLink(contato.uid)
        .then((url) => Share.share('$text\n\n$url', subject: text));
  }

  Future<String> createLink(String id) async {
    final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
      uriPrefix: 'https://meetby.page.link',
      link: Uri.parse('http://matheusneumann.surge.sh/usuario?id=$id'),
      androidParameters: AndroidParameters(packageName: 'com.me.by'),
    );

    final Uri dynamicUrl = await dynamicLinkParameters.buildUrl();
    return dynamicUrl.toString();
  }

  void popUpExcluir(BuildContext context) {
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
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 20)),
      onPressed: () {
        _.removerContato(outroUsuario);
        Get.off(TelaContatos2());
      },
    );
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Deseja realmente excluir ${outroUsuario.nome}?",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        actions: [
          outroUsuario.uid != Controle.to.uid
              ? PopupMenuButton(
                  onSelected: (click) => controlarClick(click, outroUsuario),
                  itemBuilder: (BuildContext context) {
                    return {
                      'Compartilhar Perfil',
//                  'Bloquear contato',
                      'Deletar Contato'
                    }.map((String escolha) {
                      return PopupMenuItem(
                        value: escolha,
                        child: Text(escolha),
                      );
                    }).toList();
                  })
              : Container()
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ClipRRect(
                child: Container(
                  width: Get.width,
                  margin: EdgeInsets.only(bottom: 15.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.26),
                        blurRadius: 15.h,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.dialog(
                              Scaffold(
                                backgroundColor: Colors.transparent,
                                body: InkWell(
                                  child: InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                        width: Get.width,
                                        height: Get.height,
                                        color: Colors.transparent,
                                        child: Container(
                                          width: 300.w,
                                          height: 360.h,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 57.w,
                                              vertical: 260.h),
                                          child: Image.network(
                                            outroUsuario.imagemUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                              barrierDismissible: false);
                        },
                        child: Container(
                          width: 176.h,
                          height: 176.h,
                          margin: EdgeInsets.only(top: 46.h),
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(outroUsuario.imagemUrl),
                          ),
                        ),
                      ),
                      Container(
                        width: Get.width,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 16.h,
                            ),
                            outroUsuario.mostrarIdade
                                ? Container(
                                    child: Text(
                                      '${outroUsuario.nome}, ${CalculadoraDeIdade.obterIdade(outroUsuario.dataDeNascimento.toString())}',
                                      style: TextStyle(
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : Container(
                                    child: Text(
                                      '${outroUsuario.nome}',
                                      style: TextStyle(
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              '${outroUsuario.profissao}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff4E4D4D),
                                  fontSize: 14.sp),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            InkWell(
                              onTap: () {
                                Get.defaultDialog(
                                  title: 'Bio',
                                  middleText: '${outroUsuario.bio}',
                                );
                              },
                              child: Container(
                                width: 278.w,
                                margin: EdgeInsets.only(
                                    top: 7.h,
                                    left: 68.w,
                                    right: 68.w,
                                    bottom: 7.h),
                                child: Text(
                                  outroUsuario.bio,
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
                            SizedBox(
                              height: 15.h,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    outroUsuario.instagram != null
                        ? InkWell(
                            onTap: () {
                              print(
                                  'https://www.instagram.com/${outroUsuario.instagram}/');
                              abrirLink(
                                  'https://www.instagram.com/${outroUsuario.instagram}/');
                            },
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/instagram.png'),
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(outroUsuario.instagram)
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    outroUsuario.facebook != null
                        ? InkWell(
                            onTap: () {
                              abrirLink('https://www.facebook.com/$_.fb/');
                            },
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/facebook.png'),
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(outroUsuario.facebook)
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    outroUsuario.email != null
                        ? InkWell(
                            onTap: () {
                              abrirLink('');
                            },
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.mail_outline,
                                      color: Color(0xff058BC6),
                                    ),
                                    Text(outroUsuario.email)
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    outroUsuario.whatsapp != null
                        ? InkWell(
                            onTap: () {
                              abrirLink(
                                  'https://api.whatsapp.com/send?phone=55${outroUsuario.whatsapp}');
                            },
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/whatsapp.png'),
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(outroUsuario.whatsapp)
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    outroUsuario.twitter != null
                        ? InkWell(
                            onTap: () {
                              abrirLink(
                                  'https://twitter.com/${outroUsuario.twitter}');
                            },
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/twitter.png'),
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(outroUsuario.twitter)
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    outroUsuario.linkedin != null
                        ? InkWell(
                            onTap: () {
                              abrirLink('');
                            },
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/linkedin.png'),
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(outroUsuario.linkedin)
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    outroUsuario.youtube != null
                        ? InkWell(
                            onTap: () {
                              abrirLink(
                                  'https://www.youtube.com/user/${outroUsuario.youtube}');
                            },
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/youtube.png'),
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(outroUsuario.youtube)
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    outroUsuario.spotify != null
                        ? InkWell(
                            onTap: () {
                              abrirLink(
                                  'https://open.spotify.com/user/${outroUsuario.spotify}');
                            },
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/spotify.png'),
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(outroUsuario.spotify)
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void abrirLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
