import 'package:meby/controle/controle.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastroNome.dart';
import 'package:meby/visao/telas/cadastro/TelaVerificarEmail.dart';
import 'package:meby/visao/widgets/Logo.dart';
import 'package:flutter/material.dart';
import 'package:meby/modelo/Usuario.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TelaCadastro extends StatelessWidget {
  static const String rota = '/telaCadastro';

  //TODO: passar para controle
  final emailTextController = TextEditingController();
  final senhaTextController = TextEditingController();
  final senhaConfirmacaoTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GetBuilder<Controle>(
          init: Controle.to,
          builder: (_) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(Get.context).padding.bottom),
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70.h,
                      ),
                      Container(
                        width: 189.5.w,
                        height: 220.46.h,
                        child: Logo(),
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      TextFormField(
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Por favor, digite seu email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Endereço de e-mail',
                          hintStyle: TextStyle(
                              color: Color(0xffBEBEBE),
                              fontWeight: FontWeight.bold),
                        ),
                        controller: emailTextController,
                      ),
                      TextFormField(
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Por favor, digite sua senha';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          helperText: 'Mínimo 6, máximo 30 simbolos',
                          helperStyle: TextStyle(),
                          contentPadding: EdgeInsets.all(0),
                          hintText: 'Senha',
                          hintStyle: TextStyle(
                            color: Color(0xffBEBEBE),
                            fontWeight: FontWeight.bold,
                          ),
                          suffix: FlatButton(
                            child: Text(_.esconderSenhaCadastro
                                ? 'Mostrar'
                                : 'Esconder'),
                            onPressed: () {
                              _.esconderSenhaCadastro =
                                  !_.esconderSenhaCadastro;
                              _.update();
                            },
                          ),
                        ),
                        controller: senhaTextController,
                        obscureText: _.esconderSenhaCadastro,
                      ),
                      TextFormField(
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Por favor, digite sua senha';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          hintText: 'Repetir senha',
                          hintStyle: TextStyle(
                            color: Color(0xffBEBEBE),
                            fontWeight: FontWeight.bold,
                          ),
                          suffix: FlatButton(
                            child: Text(_.esconderConfSenhaCadastro
                                ? 'Mostrar'
                                : 'Esconder'),
                            onPressed: () {
                              _.esconderConfSenhaCadastro =
                                  !_.esconderConfSenhaCadastro;
                              _.update();
                            },
                          ),
                        ),
                        controller: senhaConfirmacaoTextController,
                        obscureText: _.esconderConfSenhaCadastro,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                        width: 278.w,
                        height: 56.h,
                        child: RaisedButton(
                          color: Color(0xff058BC6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xff058BC6)),
                          ),
                          child: Text(
                            _.botaoLoadingCadastro,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            _.botaoLoadingCadastro = 'Carregando...';
                            _.update();

                            if (senhaTextController.text !=
                                senhaConfirmacaoTextController.text) {
                              _.botaoLoadingCadastro = 'Continuar';
                              _.update();
                              Get.defaultDialog(
                                  title: 'Ops',
                                  middleText: 'Senhas diferentes');
                            } else if (emailTextController.text.isEmpty ||
                                senhaTextController.text.isEmpty ||
                                senhaConfirmacaoTextController.text.isEmpty) {
                              _.botaoLoadingCadastro = 'Continuar';
                              _.update();
                              Get.defaultDialog(
                                  title: 'Ops',
                                  middleText: 'Preencha todos os campos');
                            } else {
                              await cadastrarEmail();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

//  Future cadastrarNovoUsuario(
//      UsuarioCRUD usuarioProvider, FirebaseUser user) async {
//    await usuarioProvider.addUsuario(Usuario(
//      uid: user.uid,
//    ));
//  }

  void cadastrarEmail() async {
    final auth = await Controle.to.firebase.getAuth();
    final authResult = await auth
        .createUserWithEmailAndPassword(
      email: emailTextController.text,
      password: senhaConfirmacaoTextController.text,
    )
        .catchError((error) {
      switch (error.code) {
        case "ERROR_WEAK_PASSWORD":
          Get.defaultDialog(title: 'Erro', middleText: "Senha fraca!");
          break;
        case "ERROR_INVALID_EMAIL":
          Get.defaultDialog(
              title: 'Erro',
              middleText: "O email informado não parece ser um email!");
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          Get.defaultDialog(
              title: 'Erro',
              middleText: "O email já está sendo usado por outro usuário.");
          break;
        default:
          Get.defaultDialog(
              title: 'Erro', middleText: "Um erro desconhecido ocorreu.");
          break;
      }
    });
    final user = authResult.user;

    if (user != null) {
      Controle.to.setUID(user.uid);
      Controle.to.botaoLoadingCadastro = 'Continuar';
      Controle.to.update();
      if (Controle.to.usuarioById(Controle.to.uid) == null) {
        await cadastrarNovoUsuario();
        await user.sendEmailVerification();
        Controle.to.emailTextController.text = emailTextController.text;

        Get.off(TelaVerificarEmail(emailTextController.text));
      } else {
        print('usuario ja existe');
      }
    } else {
      print('cadastro falhou');
    }
  }

  Future cadastrarNovoUsuario() async {
    final fcmToken = await Controle.to.firebase.getToken();

    await Controle.to.criarUsuario(
        Controle.to.uid,
        Usuario(
                uid: Controle.to.uid,
                fcmToken: fcmToken,
                tutorialBusca: true,
                primeiroContato: true,
                cadastro: true)
            .toMap());
    //TODO: mudar nome do método
    await Controle.to.obterMeuUsuario();
  }
}
