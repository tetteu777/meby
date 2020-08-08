import 'package:meby/controle/controle.dart';
import 'package:meby/visao/telas/EsqueciASenha.dart';
import 'package:meby/visao/telas/login/TelaLogin.dart';
import 'package:meby/visao/widgets/Logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TelaLoginEmail extends StatelessWidget {
  static const String rota = '/telaLoginEmail';

  //TODO: passar para controle
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.off(TelaLogin()),
        ),
      ),
      body: GetBuilder<Controle>(
          init: Controle.to,
          builder: (_) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 40.h,
                          ),
                          Container(
                            width: 189.5.w,
                            height: 220.46.h,
                            child: Logo(),
                          ),
                          SizedBox(
                            height: 80.h,
                          ),
                          TextFormField(
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Por favor, digite seu email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'Email'),
                            controller: emailTextController,
                          ),
                          TextFormField(
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Por favor, digite sua senha';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'Senha'),
                            controller: passwordTextController,
                            obscureText: true,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: FlatButton(
                              child: Text('Esqueceu a senha?'),
                              onPressed: () {
                                Get.to(EsqueciASenha());
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            width: double.infinity,
                            child: RaisedButton(
                              color: Color(0xff058BC6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xff058BC6)),
                              ),
                              child: Text(
                                _.botaoLoadingLogin,
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                if (emailTextController.text.isEmpty ||
                                    passwordTextController.text.isEmpty) {
                                  Get.defaultDialog(
                                      title: 'Erro',
                                      middleText: 'Preencha todos os campos');
                                } else {
                                  _.botaoLoadingLogin = 'Carregando...';
                                  _.update();
                                  emailLogin();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void emailLogin() async {
    final firebaseAuth = await Controle.to.firebase.getAuth();
    final authResult = await firebaseAuth
        .signInWithEmailAndPassword(
      email: emailTextController.text,
      password: passwordTextController.text,
    )
        .catchError((error) {
      Controle.to.botaoLoadingLogin = 'Entrar';
      Controle.to.update();
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          Get.defaultDialog(
              title: 'Erro',
              middleText: "O email informado não parece ser um email!");
          break;
        case "ERROR_WRONG_PASSWORD":
          Get.defaultDialog(title: 'Erro', middleText: "Senha errada!");
          break;
        case "ERROR_USER_NOT_FOUND":
          Get.defaultDialog(title: 'Erro', middleText: "O usuário não existe.");
          break;
        default:
          Get.defaultDialog(
              title: 'Erro', middleText: "Um erro desconhecido ocorreu.");
          break;
      }
    });

    final firebaseUser = authResult.user;

    Controle.to.botaoLoadingLogin = 'Entrar';
    Controle.to.update();
    if (firebaseUser != null) {
      Controle.to.setUID(firebaseUser.uid);
      await Controle.to.prepararParaLoginEmail(firebaseUser.email);
      Controle.to.getStorage.write('login', 'email');
    } else {
      Get.defaultDialog(title: 'Erro', middleText: 'Login ou senha incorretos');
    }
  }
}
