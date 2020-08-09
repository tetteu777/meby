import 'package:flutter_svg/flutter_svg.dart';
import 'package:meby/controle/controle.dart';
import 'package:meby/modelo/Usuario.dart';
import 'package:meby/visao/widgets/Logo.dart';
import 'package:meby/visao/widgets/PopUpExcluirConta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TelaContas extends StatelessWidget {
  var maskFormatter = new MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    Usuario eu = Controle.to.usuarioById(Controle.to.uid);
    TextEditingController whatsapp =
        TextEditingController(text: eu.whatsapp ?? 'Whatsapp');
    TextEditingController email =
        TextEditingController(text: eu.email ?? 'Email');
    TextEditingController instagram =
        TextEditingController(text: eu.instagram ?? 'Instagram');
    TextEditingController facebook =
        TextEditingController(text: eu.facebook ?? 'Facebook');
    TextEditingController twitter =
        TextEditingController(text: eu.twitter ?? 'Twitter');
    TextEditingController linkedin =
        TextEditingController(text: eu.linkedin ?? 'Linkedin');
    TextEditingController youtube =
        TextEditingController(text: eu.youtube ?? 'Youtube');
    TextEditingController spotify =
        TextEditingController(text: eu.spotify ?? 'Spotify');
    whatsapp.value = maskFormatter.updateMask('(##) #####-####');

    return Scaffold(
      appBar: AppBar(
        title: Text('Contas'),
        backgroundColor: Colors.black,
      ),
      body: GetBuilder<Controle>(
          init: Controle.to,
          builder: (_) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 35.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: TextField(
                        inputFormatters: [maskFormatter],
                        controller: whatsapp,
                        decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(right: 8.w),
                              child: ImageIcon(
                                AssetImage('assets/images/whatsapp.png'),
                                color: Color(0xff058BC6),
                              ),
                            ),
                            hintText: eu.whatsapp ?? 'Whatsapp',
                            suffix: FlatButton(
                              child: Text(
                                  eu.whatsapp != null ? 'Editar' : 'Adicionar'),
                              onPressed: () {
                                _.usuarioById(_.uid).setWhatsapp(
                                    maskFormatter.getUnmaskedText());
                                _.updateUsuario(_.uid, _.usuarioById(_.uid));
                              },
                            ),
                            prefixIconConstraints:
                                BoxConstraints.tight(Size.square(29.75.w))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: TextField(
                        controller: email,
                        decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(right: 8.w),
                              child: Icon(
                                Icons.mail_outline,
                                color: Color(0xff058BC6),
                              ),
                            ),
                            hintText: eu.email ?? 'Email',
                            suffix: FlatButton(
                              child: Text(
                                  eu.email != null ? 'Editar' : 'Adicionar'),
                              onPressed: () {
                                _.usuarioById(_.uid).setEmail(email.text);
                                _.updateUsuario(_.uid, _.usuarioById(_.uid));
                                Get.defaultDialog(
                                  title: 'Pronto!',
                                  middleText: 'Atualizamos seus dados',
                                  confirm: FlatButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                );
                              },
                            ),
                            prefixIconConstraints:
                                BoxConstraints.tight(Size.square(29.75.w))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: TextField(
                        controller: instagram,
                        decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(right: 8.w),
                              child: ImageIcon(
                                AssetImage('assets/images/instagram.png'),
                                color: Color(0xff058BC6),
                              ),
                            ),
                            hintText: eu.instagram ?? 'Usuário do Instagram',
                            suffix: FlatButton(
                              child: Text(eu.instagram != null
                                  ? 'Editar'
                                  : 'Adicionar'),
                              onPressed: () {
                                _
                                    .usuarioById(_.uid)
                                    .setInstagram(instagram.text);
                                _.updateUsuario(_.uid, _.usuarioById(_.uid));
                                Get.defaultDialog(
                                  title: 'Pronto!',
                                  middleText: 'Atualizamos seus dados',
                                  confirm: FlatButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                );
                              },
                            ),
                            prefixIconConstraints:
                                BoxConstraints.tight(Size.square(29.75.w))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: TextField(
                        controller: facebook,
                        decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(right: 8.w),
                              child: ImageIcon(
                                AssetImage('assets/images/facebook.png'),
                                color: Color(0xff058BC6),
                              ),
                            ),
                            hintText: eu.facebook ?? 'Link do perfil',
                            suffix: FlatButton(
                              child: Text(
                                  eu.facebook != null ? 'Editar' : 'Adicionar'),
                              onPressed: () {
                                _.usuarioById(_.uid).setFacebook(facebook.text);
                                _.updateUsuario(_.uid, _.usuarioById(_.uid));
                                Get.defaultDialog(
                                  title: 'Pronto!',
                                  middleText: 'Atualizamos seus dados',
                                  confirm: FlatButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                );
                              },
                            ),
                            prefixIconConstraints:
                                BoxConstraints.tight(Size.square(29.75.w))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: TextField(
                        controller: twitter,
                        decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(right: 8.w),
                              child: ImageIcon(
                                AssetImage('assets/images/twitter.png'),
                                color: Color(0xff058BC6),
                              ),
                            ),
                            hintText: eu.twitter ?? 'Usuário do Twitter',
                            suffix: FlatButton(
                              child: Text(
                                  eu.twitter != null ? 'Editar' : 'Adicionar'),
                              onPressed: () {
                                _.usuarioById(_.uid).setTwitter(twitter.text);
                                _.updateUsuario(_.uid, _.usuarioById(_.uid));
                                Get.defaultDialog(
                                  title: 'Pronto!',
                                  middleText: 'Atualizamos seus dados',
                                  confirm: FlatButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                );
                              },
                            ),
                            prefixIconConstraints:
                                BoxConstraints.tight(Size.square(29.75.w))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: TextField(
                        controller: linkedin,
                        decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(right: 8.w),
                              child: ImageIcon(
                                AssetImage('assets/images/linkedin.png'),
                                color: Color(0xff058BC6),
                              ),
                            ),
                            hintText: eu.linkedin ?? 'Linkedin',
                            suffix: FlatButton(
                              child: Text(
                                  eu.linkedin != null ? 'Editar' : 'Adicionar'),
                              onPressed: () {
                                _.usuarioById(_.uid).setLinkedin(linkedin.text);
                                _.updateUsuario(_.uid, _.usuarioById(_.uid));
                                Get.defaultDialog(
                                  title: 'Pronto!',
                                  middleText: 'Atualizamos seus dados',
                                  confirm: FlatButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                );
                              },
                            ),
                            prefixIconConstraints:
                                BoxConstraints.tight(Size.square(29.75.w))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: TextField(
                        controller: youtube,
                        decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(right: 8.w),
                              child: ImageIcon(
                                AssetImage('assets/images/youtube.png'),
                                color: Color(0xff058BC6),
                              ),
                            ),
                            hintText: eu.youtube ?? 'Youtube',
                            suffix: FlatButton(
                              child: Text(
                                  eu.youtube != null ? 'Editar' : 'Adicionar'),
                              onPressed: () {
                                _.usuarioById(_.uid).setYoutube(youtube.text);
                                _.updateUsuario(_.uid, _.usuarioById(_.uid));
                                Get.defaultDialog(
                                  title: 'Pronto!',
                                  middleText: 'Atualizamos seus dados',
                                  confirm: FlatButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                );
                              },
                            ),
                            prefixIconConstraints:
                                BoxConstraints.tight(Size.square(29.75.w))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: TextField(
                        controller: spotify,
                        decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(right: 8.w),
                              child: ImageIcon(
                                AssetImage('assets/images/spotify.png'),
                                color: Color(0xff058BC6),
                              ),
                            ),
                            hintText: eu.spotify ?? 'Spotify',
                            suffix: FlatButton(
                              child: Text(
                                  eu.spotify != null ? 'Editar' : 'Adicionar'),
                              onPressed: () {
                                _.usuarioById(_.uid).setSpotify(spotify.text);
                                _.updateUsuario(_.uid, _.usuarioById(_.uid));
                              },
                            ),
                            prefixIconConstraints:
                                BoxConstraints.tight(Size.square(29.75.w))),
                      ),
                    ),
                    SizedBox(height: 50.h),
                    Container(
                        width: 109.77.w,
                        height: 31.77.h,
                        child: SvgPicture.asset('assets/images/logo_conta_cinza.svg', color: Color(0xff989898),)),
                    SizedBox(height: 50.h),

                    Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Container(
                      width: Get.width,
                      alignment: Alignment.centerLeft,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Redefinir senha',
                          style: TextStyle(
                              color: Color(0xff058BC6), fontSize: 18.sp),
                        ),
                        onPressed: () async {
                          await _.resetarSenha(_.usuarioById(_.uid));
                          Get.defaultDialog(
                              title: 'E-mail enviado',
                              middleText:
                                  'Um e-mail foi enviado para ${_.usuarioById(_.uid).email} contendo um link para redefinir sua senha.',
                              confirm: FlatButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Get.back();
                                },
                              ));
                        },
                      ),
                    ),
                    Container(
                      width: Get.width,
                      alignment: Alignment.centerLeft,
                      child: FlatButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Deletar minha conta',
                          style: TextStyle(
                              color: Color(0xff4E4D4D),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          Get.dialog(PopUpExcluirConta());
                        },
                      ),
                    ),
                    Container(
                        width: Get.width,
                        child: Text(
                          'Todos os dados do seu perfil serão excluídos permanentemente.',
                          style: TextStyle(fontSize: 11.sp),
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
