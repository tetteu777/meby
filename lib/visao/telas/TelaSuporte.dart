import 'package:meby/controle/controle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class TelaSuporte extends StatelessWidget {
  List<String> perguntas = List<String>();
  List<String> respostas = List<String>();

  @override
  Widget build(BuildContext context) {
    perguntas = [
      'Por que não consigo encontrar ninguém no radar?',
      'Qual é o raio de busca do radar?',
      'O perfil dos usuários listados no radar fica guardado?',
      'Um dos meus contatos sumiu, o que houve?',
      'Se eu desativar a visibilidade, ninguém irá conseguir me encontrar nas buscas?'
    ];

    respostas = [
      'Verifique a conexão e se o local está ativo, certifique-se também de que você não está com a visibilidade desativada no app',
      'O raio de busca é de 100 metros.',
      'Não, mas é possível salvar os perfis para adicionar depois, no ícone que fica ao lado do botão add.',
      'Se um dos seus contatos te excluir, ele também deixa de fazer parte dos seus contatos.',
      'Sim, ninguém irá encontrar seu perfil nas buscas, mas a sua busca fica inativa, até que ative a sua visibilidade novamente.'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Suporte'),
        backgroundColor: Colors.black,
      ),
      body: GetBuilder<Controle>(
          init: Controle.to,
          builder: (_) {
            return SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          child: Column(
                            children: <Widget>[
                              Text('Perguntas frequentes'),
                              SizedBox(
                                height: 8.h,
                              ),
                              _.telaSuporteEscolhida == 0
                                  ? linha()
                                  : Container(),
                            ],
                          ),
                          onPressed: () {
                            _.telaSuporteEscolhida = 0;
                            _.update();
                          },
                        ),
                        FlatButton(
                          child: Column(
                            children: <Widget>[
                              Text('Contato com o suporte'),
                              SizedBox(
                                height: 8.h,
                              ),
                              _.telaSuporteEscolhida == 1
                                  ? linha()
                                  : Container(),
                            ],
                          ),
                          onPressed: () {
                            _.telaSuporteEscolhida = 1;
                            _.update();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Expanded(child: Tela(_, context)),
                ],
              ),
            );
          }),
    );
  }

  Container linha() {
    return Container(
      width: 140.w,
      height: 5.h,
      color: Color(0xff058BC6),
    );
  }

  Widget Tela(Controle _, BuildContext context) {
    if (_.telaSuporteEscolhida == 0) {
      return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 30.w),
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return perguntaResposta(
                _.mostrar[index], perguntas[index], respostas[index], _, index);
          },
          itemCount: perguntas.length,
          shrinkWrap: true,
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 30.w),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 210.h),
                width: Get.width,
                child: Text(
                  'Envie suas sugestões e comentários para deixar o meby ainda\nmelhor!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff4E4D4D),
                      fontSize: 21.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 210.h,
              ),
              SizedBox(
                width: 368.w,
                height: 72.h,
                child: RaisedButton(
                  color: Color(0xff058BC6),
                  child: Text(
                    'Entrar em contato',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 21.sp),
                  ),
                  onPressed: () {
                    popUp(context, _);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void popUp(BuildContext context, Controle _) {
    Widget problema = FlatButton(
      child: Text("Problema",
          style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 22.sp)),
      onPressed: () async {
        final Email email = Email(
          body: 'O que aconteceu?',
          subject: 'Problema',
          recipients: ['contato@meby.app'],
          isHTML: false,
        );

        await FlutterEmailSender.send(email);
      },
    );
    Widget sugestoes = FlatButton(
      child: Text("Sugestões",
          style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 22.sp)),
      onPressed: () async {
        final Email email = Email(
          body: 'Conte-me mais. Estamos interessados em ouvir você',
          subject: 'Sugestão',
          recipients: ['contato@meby.app'],
          isHTML: false,
        );

        await FlutterEmailSender.send(email);
      },
    );
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      content: Container(
        width: Get.width,
        height: 300.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            problema,
            sugestoes,
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

  Container perguntaResposta(
      bool mostrar, String pergunta, String resposta, Controle _, int index) {
    print(mostrar);
    return Container(
      width: Get.width,
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              _.mostrar[index] = !_.mostrar[index];
              _.update();
            },
            child: Container(
              width: Get.width,
              child: Text(
                pergunta,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 24.sp,
                    color: Color(0xff058BC6),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          mostrar
              ? Container(
                  width: Get.width,
                  child: Text(
                    resposta,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20.sp, color: Color(0xff676161)),
                  ),
                )
              : Container(),
          SizedBox(
            height: 34.h,
          )
        ],
      ),
    );
  }
}
