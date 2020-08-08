import 'package:meby/controle/controle.dart';
import 'package:meby/visao/telas/TelaContatos2.dart';
import 'package:meby/visao/telas/TelaQuerFicarVisivel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:expandable/expandable.dart';

class TelaCadastroRedesSociais extends StatelessWidget {
  static const String rota = '/telaCadastroRedesSociais';

  String _tiktok = 'k';

  var maskFormatter = new MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<Controle>(
            init: Controle(),
            initState: (_) {
//            Controle.to.emailTextController = TextEditingController(
//                text: Controle.to.usuarioById(Controle.to.uid).email ?? '');
            },
            builder: (_) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            width: (130.w / 7) * 7,
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
                        height: 40.h,
                      ),

                      contruirVinculadorRedeSocial(
                          _.whatsapp,
                          'assets/images/whatsapp.png',
                          'https://api.whatsapp.com/send?phone=55$_.whatsapp',
                          _.whatsappTextController,
                          'Whatsapp',
                          'Vincular\nWhatsApp',
                          _,
                          context,
                          inputFormatter: maskFormatter),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        thickness: 3,
                      ),
                      contruirVinculadorRedeSocial(
                          _.email,
                          'assets/images/email.png',
                          '',
                          _.emailTextController,
                          'Email',
                          'Vincular\nEmail',
                          _,
                          context),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        thickness: 3,
                      ),
                      ExpandablePanel(
                        header: Card(
                          child: Container(
                            height: 50.h,
                            alignment: Alignment.center,
                            child: Text(
                              'Redes sociais',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                          ),
                        ),
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        iconPlacement: ExpandablePanelIconPlacement.right,
                        collapsed: Container(),
                        expanded: Column(
                          children: [
                            contruirVinculadorRedeSocial(
                                _.instagram,
                                'assets/images/instagram.png',
                                'https://www.instagram.com/$_.instagram/',
                                _.instagramTextController,
                                'Instagram',
                                'Vincular\nInstagram',
                                _,
                                context),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 3,
                            ),
                            contruirVinculadorRedeSocial(
                                _.fb,
                                'assets/images/facebook.png',
                                '$_.fb',
                                _.facebookTextController,
                                'Facebook',
                                'Vincular\nFacebook',
                                _,
                                context),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 3,
                            ),
                            contruirVinculadorRedeSocial(
                                _.twitter,
                                'assets/images/twitter.png',
                                'https://twitter.com/$_.twitter',
                                _.twitterTextController,
                                'Twitter',
                                'Vincular\nTwitter',
                                _,
                                context),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 3,
                            ),
                            contruirVinculadorRedeSocial(
                                _.linkedin,
                                'assets/images/linkedin.png',
                                '',
                                _.linkedinTextController,
                                'Linkedin',
                                'Vincular\nLinkedin',
                                _,
                                context),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 3,
                            ),
                            contruirVinculadorRedeSocial(
                                _.youtube,
                                'assets/images/youtube.png',
                                'https://www.youtube.com/user/$_.youtube',
                                _.youtubeTextController,
                                'Canal',
                                'Vincular\nYouTube',
                                _,
                                context),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 3,
                            ),
                            contruirVinculadorRedeSocial(
                                _.spotify,
                                'assets/images/spotify.png',
                                'https://open.spotify.com/user/$_.spotify',
                                _.spotifyTextController,
                                'Spotify',
                                'Vincular\nSpotify',
                                _,
                                context),
                          ],
                        ),
                      ),
//              contruirVinculadorRedeSocial(
//                  _tiktok,
//                  'assets/images/spotify.png',
//                  'https://open.spotify.com/user/$_tiktok',
//                  tiktokTextController,
//                  'Digite seu usuário',
//                  'Vincular\nTikTok'),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        width: 328.w,
                        height: 56.h,
                        child: RaisedButton(
                            color: Color(0xff058BC6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Color(0xff058BC6)),
                            ),
                            child: Text(
                              'Concluir',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.sp),
                            ),
                            onPressed: () {
                              if (Controle.to.whatsappTextController.text.isNotEmpty) {
                                Get.off(TelaQuerFicarVisivel());
                              } else {
                                Get.defaultDialog(
                                    title: 'Ops',
                                    middleText: 'Preencha seu whatsapp');
                              }
                            }),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Container contruirVinculadorRedeSocial(
      String redeSocial,
      String caminhoDoIcone,
      String url,
      TextEditingController controller,
      String labelText,
      String textoDoBotao,
      Controle _,
      BuildContext context,
      {MaskTextInputFormatter inputFormatter}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Stack(
        children: [
          Container(
            width: Get.width,
            height: 64.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                redeSocial != 'e'
                    ? Image(
                        image: AssetImage(caminhoDoIcone),
                        width: 30,
                        height: 30,
                      )
                    : Icon(Icons.mail_outline),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Text(
                    redeSocial.length > 1 || controller.text.isNotEmpty
                        ? controller.text
                        : labelText,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: FlatButton(
              color: Colors.white,
              child: Text(
                redeSocial.length > 1 || controller.text.isNotEmpty
                    ? 'Editar'
                    : 'Adicionar',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xff058BC6), fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                abrirPopUp(controller, caminhoDoIcone, labelText, redeSocial, _,
                    context,
                    inputFormatter: inputFormatter);
              },
            ),
          )
        ],
      ),
    );
  }

  void abrirPopUp(TextEditingController controller, String caminhoDoIcone,
      String labelText, String redeSocial, Controle _, BuildContext context,
      {MaskTextInputFormatter inputFormatter}) {
    Get.dialog(Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: 338.w,
        margin: EdgeInsets.only(top: 30.h, left: 38.w, right: 38.w),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(caminhoDoIcone),
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    width: 11.w,
                  ),
                  Text(
                    labelText,
                    style: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4F4F50)),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 27.w),
                child: TextField(
                  controller: controller,
                  inputFormatters:
                      inputFormatter == null ? [] : [inputFormatter],
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              RaisedButton(
                color: Color(0xff058BC6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Color(0xff058BC6)),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
                onPressed: () {
                  if (redeSocial == 'i') {
                    _.instagram = controller.text;
                    Controle.to
                        .usuarioById(Controle.to.uid)
                        .setInstagram(controller.text);
                  } else if (redeSocial == 'f') {
                    _.fb = controller.text;
                    Controle.to
                        .usuarioById(Controle.to.uid)
                        .setFacebook(controller.text);
                  } else if (redeSocial == 'e') {
                    _.email = controller.text;
                    Controle.to
                        .usuarioById(Controle.to.uid)
                        .setEmail(controller.text);
                  } else if (redeSocial == 'w') {
                    _.whatsapp = inputFormatter.getUnmaskedText();
                    Controle.to
                        .usuarioById(Controle.to.uid)
                        .setWhatsapp(inputFormatter.getUnmaskedText());
                  } else if (redeSocial == 't') {
                    _.twitter = controller.text;
                    Controle.to
                        .usuarioById(Controle.to.uid)
                        .setTwitter(controller.text);
                  } else if (redeSocial == 'l') {
                    _.linkedin = controller.text;
                    Controle.to
                        .usuarioById(Controle.to.uid)
                        .setLinkedin(controller.text);
                  } else if (redeSocial == 'y') {
                    _.youtube = controller.text;
                    Controle.to
                        .usuarioById(Controle.to.uid)
                        .setYoutube(controller.text);
                  } else if (redeSocial == 's') {
                    _.spotify = controller.text;
                    Controle.to
                        .usuarioById(Controle.to.uid)
                        .setYoutube(controller.text);
                  }
                  _.update();
                  Controle.to.updateUsuario(Controle.to.uid,
                      Controle.to.usuarioById(Controle.to.uid));
                  Get.back();
                },
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
