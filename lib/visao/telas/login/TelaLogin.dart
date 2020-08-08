import 'package:meby/controle/controle.dart';
import 'package:meby/visao/telas/login/TelaLoginEmail.dart';
import 'package:meby/visao/telas/TelaPoliticaPrivacidade.dart';
import 'package:meby/visao/telas/TelaSuporte.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastro.dart';
import 'package:meby/visao/widgets/Logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../TelaTermosDeUso.dart';

class TelaLogin extends StatelessWidget {
  void _select(Choice choice) {
    print(choice.title);
    if (choice.title == 'Termos de uso') {
      Get.to(TelaTermosDeUso());
    } else if (choice.title == 'Política de privacidade') {
      Get.to(TelaPoliticaPrivacidade());
    } else if (choice.title == 'Suporte') {
      Get.to(TelaSuporte());
    }
  }

  @override
  Widget build(BuildContext context) {
    print(Controle.to.toString());

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            PopupMenuButton<Choice>(
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Text(choice.title),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                  width: 189.5.w,
                  height: 220.46.h,
                  margin:
                      EdgeInsets.only(top: 50.8.h, left: 112.5.w, right: 112.w),
                  child: Logo()),
              Container(
                width: 300.w,
                height: 49.h,
                margin: EdgeInsets.only(top: 150.75.h, left: 57.w, right: 57.w),
                child: RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.w),
                    side: BorderSide(color: Colors.black54),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 20.18.w,
                        height: 20.18.h,
                        margin: EdgeInsets.only(
                            left: 19.56.w,
                            top: 14.65.h,
                            bottom: 14.18.h,
                            right: 24.26.w),
                        child: Image(
                          image: AssetImage('assets/images/facebook.png'),
                        ),
                      ),
                      Container(
                        width: 182.w,
                        margin: EdgeInsets.only(
                          top: 16.h,
                          bottom: 14.h,
                        ),
                        child: FittedBox(
                          child: Text(
                            'ENTRAR COM O FACEBOOK',
                            style: TextStyle(
                                color: Color(0xff989898), fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    if (!Controle.to.multipleClickFace) {
                      await facebookLogin();
                    }
                    Controle.to.multipleClickFace = true;
                    Future.delayed(Duration(seconds: 7), () {
                      Controle.to.multipleClickFace = false;
                    });
                  },
                ),
              ),
              Container(
                width: 300.w,
                height: 49.h,
                margin: EdgeInsets.only(top: 39.h, left: 57.w, right: 57.w),
                child: RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black54),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 21.w,
                        height: 21.h,
                        margin: EdgeInsets.only(
                            left: 20.w, top: 14.h, bottom: 14.h, right: 23.w),
                        child: Image(
                          image: AssetImage('assets/images/google.png'),
                        ),
                      ),
                      Container(
                        width: 175.w,
                        margin: EdgeInsets.only(top: 16.h, bottom: 14.h),
                        child: FittedBox(
                          child: Text(
                            'ENTRAR COM O GOOGLE',
                            style: TextStyle(
                                color: Color(0xff989898), fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    if (!Controle.to.multipleClickGoogle) {
                      await googleLogin();
                    }
                    Controle.to.multipleClickGoogle = true;
                    Future.delayed(Duration(seconds: 7), () {
                      Controle.to.multipleClickGoogle = false;
                    });
                  },
                ),
              ),
              Container(
                width: 300.w,
                height: 49.h,
                margin: EdgeInsets.only(top: 38.h, left: 57.w, right: 57.w),
                child: RaisedButton(
                  color: Color(0xff058BC6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Color(0xff058BC6)),
                  ),
                  child: Container(
                    width: 107.w,
                    margin: EdgeInsets.only(top: 10.h, bottom: 9.h),
                    child: FittedBox(
                      child: Text(
                        'Cadastrar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onPressed: () {
                    //TODO: Navigator
//                            Navigator.pushNamed(context, TelaCadastro.rota);

                    Get.to(TelaCadastro());
                  },
                ),
              ),
              Spacer(),
              Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Já tem uma conta?'),
                  FlatButton(
                    child: Text('Conecte-se'),
                    onPressed: () {
                      Get.to(TelaLoginEmail());
                    },
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Future<void> facebookLogin() async {
    final authCredential = await Controle.to.facebook.getAuthCredential();
    final authResult = await Controle.to.firebase
        .signInWithCredential(authCredential)
        .catchError((error) {
      print(error.toString());
    });

    if (authResult != null) {
      Controle.to.setUID(authResult.user.uid);
      Controle.to.prepararParaLogin(
          nome: authResult.user.displayName, email: authResult.user.email);
      Controle.to.getStorage.write('login', 'facebook');
    } else {
      Get.defaultDialog(title: 'Ops', middleText: 'Erro com o Facebook Login');
    }
  }

  void googleLogin() async {
    final authHelper = Controle.to.google.getAuthHelper();
    final firebaseUser = await authHelper.login().catchError((error) {
      print(error.toString());
    });
    if (firebaseUser != null) {
      Controle.to.setUID(firebaseUser.uid);

      Controle.to.prepararParaLogin(
          nome: firebaseUser.displayName, email: firebaseUser.email);
      Controle.to.getStorage.write('login', 'google');
    } else {

    }
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Termos de uso', icon: Icons.directions_boat),
  const Choice(title: 'Política de privacidade', icon: Icons.directions_bus),
  const Choice(title: 'Suporte', icon: Icons.directions_railway),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(choice.title),
          ],
        ),
      ),
    );
  }
}
