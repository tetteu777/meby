//import 'dart:async';
//
//import 'package:MeetBy/controle/controle.dart';
//import 'package:MeetBy/util/CalculadoraDeIdade.dart';
//import 'package:flutter/material.dart';
//import 'package:MeetBy/modelo/Usuario.dart';
//
//import 'TelaContatos.dart';
//import 'TelaPerfilDoContato.dart';
//
//class TelaMeuPerfil extends StatelessWidget {
//  static const String rota = '/telaMeuPerfil';
//
//  String abaEscolhida = 'Recebidas';
//
//  int _selectedIndexBottomNavBar = 0;
//  List<Widget> _subTelas = List<Widget>();
//
//  bool popUpOn = false;
//
//  Widget popUp;
//
//  Usuario _usuarioPopUp;
//
//
//  @override
//  Widget build(BuildContext context) {
//    double largura = MediaQuery.of(context).size.width;
//    double altura = MediaQuery.of(context).size.height;
//
//    Widget tela1 = Container(
//      child: Column(
//        children: [
//          Container(
//            width: double.infinity,
//            height: altura * 0.37,
//            child: Image.network(
//              Controle.to.usuario.imagemUrl,
//              fit: BoxFit.cover,
//            ),
//          ),
//          Container(
//              margin: EdgeInsets.all(10),
//              child: Text(
//                Controle.to.usuario.nome,
//                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//              )),
//          Container(
//              margin: EdgeInsets.only(bottom: 10),
//              child: Text(
//                '${CalculadoraDeIdade.obterIdade(Controle.to.usuario.dataDeNascimento)}, ${Controle.to.usuario.profissao}',
//                style: TextStyle(
//                    fontWeight: FontWeight.bold, color: Colors.black54),
//              )),
//          Container(
//            margin: EdgeInsets.only(bottom: 10),
//            child: Text(
//              Controle.to.usuario.bio,
//              style:
//                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
//            ),
//          ),
//          Container(
//            child: RaisedButton(
//              color: Color(0xff058BC6),
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(18.0),
//                  side: BorderSide(color: Color(0xff058BC6))),
//              child: Text(
//                'Ver como visitante',
//                style: TextStyle(color: Colors.white),
//              ),
//              onPressed: () {
////                TODO: Navigator.pushReplacementNamed(
////                    context, TelaPerfilDoContato.rota,
////                    arguments: [esteUsuario, esteUsuario]);
//              },
//            ),
//          ),
//          altura < 600
//              ? Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: [
//                    Container(
//                      margin: EdgeInsets.symmetric(vertical: 10),
//                      child: IconButton(
//                        icon: ImageIcon(
//                          AssetImage('assets/images/compartilhar.png'),
//                          color: Color(0xff058BC6),
//                          size: 30,
//                        ),
//                        onPressed: () {},
//                      ),
//                    ),
//                    SizedBox(
//                      width: 20,
//                    ),
//                    GestureDetector(
//                      child: Container(
//                        width: 50,
//                        height: 50,
//                        child: Image(
//                          image: AssetImage('assets/images/icone_pesquisa.png'),
//                        ),
//                      ),
//                      onTap: () {
////                        TODO: Navigator.pushNamed(context, TelaRadar.rota,
////                            arguments: esteUsuario);
//                      },
//                    ),
//                  ],
//                )
//              : Column(
//                  children: [
//                    Container(
//                      margin: EdgeInsets.symmetric(vertical: 10),
//                      child: IconButton(
//                        icon: ImageIcon(
//                          AssetImage('assets/images/compartilhar.png'),
//                          color: Color(0xff058BC6),
//                          size: 30,
//                        ),
//                        onPressed: () {},
//                      ),
//                    ),
//                    GestureDetector(
//                      child: Container(
//                        width: 50,
//                        height: 50,
//                        child: Image(
//                          image: AssetImage('assets/images/icone_pesquisa.png'),
//                        ),
//                      ),
//                      onTap: () {
////                        TODO: Navigator.pushNamed(context, TelaRadar.rota,
////                            arguments: esteUsuario);
//                      },
//                    ),
//                  ],
//                )
//        ],
//      ),
//    );
//
//    Widget tela2 = Column(
//      children: [
//        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: [
//            abaEscolhida == 'Recebidas'
//                ? RaisedButton(
//                    color: Color(0xff058BC6),
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(18.0),
//                        side: BorderSide(color: Color(0xff058BC6))),
//                    child: Text(
//                      'Recebidas',
//                      style: TextStyle(color: Colors.white),
//                    ),
//                    onPressed: () {
////                      TODO: setState(() {
////                        selecionarAba(solicitacoesRecebidas, 'Recebidas');
////                      });
//                    },
//                  )
//                : RaisedButton(
//                    color: Colors.white,
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(18.0),
//                        side: BorderSide(color: Colors.white)),
//                    child: Text(
//                      'Recebidas',
//                      style: TextStyle(color: Colors.black54),
//                    ),
//                    onPressed: () {
////                      TODO: setState(() {
////                        selecionarAba(solicitacoesRecebidas, 'Recebidas');
////                      });
//                    },
//                  ),
//            abaEscolhida == 'Feitas'
//                ? RaisedButton(
//                    color: Color(0xff058BC6),
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(18.0),
//                        side: BorderSide(color: Color(0xff058BC6))),
//                    child: Text(
//                      'Feitas',
//                      style: TextStyle(color: Colors.white),
//                    ),
//                    onPressed: () {
////                      TODO: setState(() {
////                        selecionarAba(solicitacoesFeitas, 'Feitas');
////                      });
//                    },
//                  )
//                : RaisedButton(
//                    color: Colors.white,
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(18.0),
//                        side: BorderSide(color: Colors.white)),
//                    child: Text(
//                      'Feitas',
//                      style: TextStyle(color: Colors.black54),
//                    ),
//                    onPressed: () {
////                      TODO: setState(() {
////                        selecionarAba(solicitacoesFeitas, 'Feitas');
////                      });
//                    },
//                  ),
//            abaEscolhida == 'Salvos'
//                ? RaisedButton(
//                    color: Color(0xff058BC6),
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(18.0),
//                        side: BorderSide(color: Color(0xff058BC6))),
//                    child: Text(
//                      'Salvos',
//                      style: TextStyle(color: Colors.white),
//                    ),
//                    onPressed: () {
////                      TODO: setState(() {
////                        selecionarAba(solicitacoesFeitas, 'Salvos');
////                      });
//                    },
//                  )
//                : RaisedButton(
//                    color: Colors.white,
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(18.0),
//                        side: BorderSide(color: Colors.white)),
//                    child: Text(
//                      'Salvos',
//                      style: TextStyle(color: Colors.black54),
//                    ),
//                    onPressed: () {
////                      TODO: setState(() {
////                        selecionarAba(usuariosSalvos, 'Salvos');
////                      });
//                    },
//                  ),
//          ],
//        ),
//        StreamBuilder(
//            stream: usuarioProvider.getUsuarioAsStream(esteUsuario.uid),
//            builder: (context, snapshot) {
//              if (snapshot.hasError) {
//              } else {
//                switch (snapshot.connectionState) {
//                  case ConnectionState.none:
//                    return Center(
//                      child: CircularProgressIndicator(),
//                    );
//                    break;
//                  case ConnectionState.waiting:
//                    return Center(
//                      child: CircularProgressIndicator(),
//                    );
//                    break;
//                  case ConnectionState.done:
//                    return Center(
//                      child: CircularProgressIndicator(),
//                    );
//                    break;
//                  case ConnectionState.active:
//                    esteUsuario = Usuario.fromMap(snapshot.data.data);
//
//                    return StreamBuilder(
//                        stream: stream,
//                        builder: (context, snapshot) {
//                          if (snapshot.hasError) {
//                            return Center(
//                              child: Text('Erro'),
//                            );
//                          } else {
//                            print('fwefewewfwefew ${snapshot.data}');
//                            return definirListaDaAba(
//                                usuarioProvider,
//                                largura,
//                                altura,
//                                snapshot.data ?? listaDeUsuarios,
//                                esteUsuario);
//                          }
//                        });
//
//                    break;
//                  default:
//                }
//              }
//            }),
//      ],
//    );
//    _subTelas = [tela1, tela2];
//
//    return WillPopScope(
//      onWillPop: () async {
//        return false;
//      },
//      child: Stack(
//        children: [
//          Scaffold(
//            appBar: AppBar(
//              elevation: 0,
//              iconTheme: IconThemeData(color: Colors.black),
//              backgroundColor: Colors.white,
//              leading: IconButton(
//                icon: ImageIcon(
//                    AssetImage('assets/images/icones_azul_Agenda.png')),
//                onPressed: () {
//                  Navigator.pushNamed(context, TelaContatos.rota);
//                },
//              ),
//            ),
//            endDrawer: SafeArea(
//              child: Drawer(
//                child: Column(
//                  children: [
//                    Container(
//                      padding: EdgeInsets.all(10),
//                      child: Text(
//                        Controle.to.usuario.nome,
//                        style: TextStyle(fontSize: 30),
//                      ),
//                    ),
//                    GestureDetector(
//                      child: Container(
//                        margin: EdgeInsets.only(top: 20),
//                        padding: EdgeInsets.all(10),
//                        child: Row(
//                          children: [
//                            ImageIcon(AssetImage(
//                                'assets/images/icones_azul_Editar.png')),
//                            SizedBox(
//                              width: 10,
//                            ),
//                            Text(
//                              'Editar Perfil',
//                              style: TextStyle(
//                                  fontWeight: FontWeight.bold,
//                                  color: Colors.black54),
//                            ),
//                          ],
//                        ),
//                      ),
//                      onTap: () {
//                        Navigator.pushNamed(context, TelaEditarUsuario.rota,
//                            arguments: esteUsuario);
//                      },
//                    ),
//                    GestureDetector(
//                      child: Container(
//                        margin: EdgeInsets.only(top: 20),
//                        padding: EdgeInsets.all(10),
//                        child: Row(
//                          children: [
//                            ImageIcon(AssetImage(
//                                'assets/images/icones_azul_Seguranca.png')),
//                            SizedBox(
//                              width: 10,
//                            ),
//                            Text(
//                              'Privacidade',
//                              style: TextStyle(
//                                  fontWeight: FontWeight.bold,
//                                  color: Colors.black54),
//                            ),
//                          ],
//                        ),
//                      ),
//                      onTap: () {
//                        Navigator.pushNamed(context, TelaPrivacidade.rota,
//                            arguments: esteUsuario);
//                      },
//                    ),
//                    GestureDetector(
//                      child: Container(
//                        margin: EdgeInsets.only(top: 20),
//                        padding: EdgeInsets.all(10),
//                        child: Row(
//                          children: [
//                            Icon(Icons.ac_unit),
//                            SizedBox(
//                              width: 10,
//                            ),
//                            Text(
//                              'Conta',
//                              style: TextStyle(
//                                  fontWeight: FontWeight.bold,
//                                  color: Colors.black54),
//                            ),
//                          ],
//                        ),
//                      ),
//                      onTap: () {
//                        Navigator.pushNamed(context, TelaContas.rota,
//                            arguments: esteUsuario);
//                      },
//                    ),
//                    GestureDetector(
//                      child: Align(
//                        alignment: Alignment.bottomLeft,
//                        child: Container(
//                          margin: EdgeInsets.only(top: 20, bottom: 20),
//                          padding: EdgeInsets.all(10),
//                          child: Row(
//                            children: [
//                              ImageIcon(AssetImage(
//                                  'assets/images/icones_azul_Sair da conta.png')),
//                              SizedBox(
//                                width: 10,
//                              ),
//                              Text(
//                                'Desconectar',
//                                style: TextStyle(
//                                    fontWeight: FontWeight.bold,
//                                    color: Colors.black54),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                      onTap: () async {
//                        await FirebaseAuth.instance.signOut();
//                        Navigator.pushNamed(context, '/');
//                      },
//                    ),
//                  ],
//                ),
//              ),
//            ),
//            bottomNavigationBar: BottomNavigationBar(
//              type: BottomNavigationBarType.fixed,
//              items: [
//                BottomNavigationBarItem(
//                  icon: Icon(Icons.person),
//                  title: Container(),
//                ),
//                BottomNavigationBarItem(
//                    icon: Icon(Icons.person_add), title: Container()),
//              ],
//              currentIndex: _selectedIndexBottomNavBar,
//              selectedItemColor: Color(0xff058BC6),
//              unselectedItemColor: Colors.grey,
//              unselectedLabelStyle: TextStyle(color: Colors.grey),
//              onTap: _onItemTapped,
//            ),
//            body: StreamBuilder(
//                stream: usuarioProvider.getUsuarioAsStream(esteUsuario.uid),
//                builder: (context, snapshot) {
//                  if (snapshot.hasError) {
//                    return Column(children: [
//                      Icon(
//                        Icons.error_outline,
//                        color: Colors.red,
//                        size: 60,
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.only(top: 16),
//                        child: Text('Error: ${snapshot.error}'),
//                      )
//                    ]);
//                  } else {
//                    switch (snapshot.connectionState) {
//                      case ConnectionState.none:
//                        return Center(
//                          child: CircularProgressIndicator(),
//                        );
//                        break;
//                      case ConnectionState.waiting:
//                        return Center(
//                          child: CircularProgressIndicator(),
//                        );
//                        break;
//                      case ConnectionState.done:
//                        return Center(
//                          child: CircularProgressIndicator(),
//                        );
//                        break;
//                      case ConnectionState.active:
//                        esteUsuario = Usuario.fromMap(snapshot.data.data);
//
//                        return FutureBuilder(
//                            future: getListaDeUsuarios(usuarioProvider),
//                            builder: (context, snapshot) {
//                              if (snapshot.hasData) {
//                                return Container(
//                                    child: _subTelas
//                                        .elementAt(_selectedIndexBottomNavBar));
//                              } else {
//                                return Center(
//                                    child: CircularProgressIndicator());
//                              }
//                            });
//
//                        break;
//
//                      default:
//                    }
//                  }
//                }),
//          ),
//          StreamBuilder(
//              stream: usuarioProvider.getUsuarioAsStream(esteUsuario.uid),
//              builder: (context, snapshot) {
//                return popUp ?? Container();
//              }),
//        ],
//      ),
//    );
//  }
//
//  Container definirListaDaAba(UsuarioCRUD usuarioProvider, double largura,
//      double altura, List<Usuario> listaDeUsuarios, Usuario esteUsuario) {
//    listaDeUsuarios = listaDeUsuarios.toSet().toList();
//    if (abaEscolhida == 'Feitas') {
//      if (popUpOn && !listaDeUsuarios.contains(_usuarioPopUp)) {
//        popUp = Container();
//        popUpOn = false;
//      }
//      return Container(
//        width: double.infinity,
//        height: 300,
//        child: ListView.builder(
//          itemBuilder: (_, i) {
//            if (popUpOn) {
//              popUp = PopUp(listaDeUsuarios[i], usuarioProvider, largura,
//                  altura, esteUsuario);
//            }
//
//            return Card(
//              child: ListTile(
//                onTap: () {
//                  mostrarPopUp(listaDeUsuarios[i], usuarioProvider, largura,
//                      altura, esteUsuario);
//
//                  setState(() {
//                    _usuarioPopUp = listaDeUsuarios[i];
//                  });
//                },
//                title: Text(listaDeUsuarios[i].nome),
//                leading: CircleAvatar(
//                  backgroundImage: NetworkImage(listaDeUsuarios[i].imagemUrl),
//                ),
//                trailing: Container(
//                  child: largura > 330
//                      ? RaisedButton(
//                          color: Colors.white,
//                          shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(18.0),
//                              side: BorderSide(color: Colors.red)),
//                          child: Text(
//                            'Cancelar solicitação',
//                            style: TextStyle(color: Colors.red),
//                          ),
//                          onPressed: () {
//                            cancelarSolicitacao(
//                                listaDeUsuarios[i], usuarioProvider);
//                          },
//                        )
//                      : RaisedButton(
//                          color: Colors.white,
//                          shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(18.0),
//                              side: BorderSide(color: Colors.red)),
//                          child: Text(
//                            'Cancelar',
//                            style: TextStyle(color: Colors.red),
//                          ),
//                          onPressed: () {
//                            cancelarSolicitacao(
//                                listaDeUsuarios[i], usuarioProvider);
//                          },
//                        ),
//                ),
//              ),
//            );
//          },
//          itemCount: listaDeUsuarios.length,
//        ),
//      );
//    } else if (abaEscolhida == 'Recebidas') {
//      if ((popUpOn && !listaDeUsuarios.contains(_usuarioPopUp)) ||
//          _usuarioPopUp == null) {
//        popUp = Container();
//        popUpOn = false;
//      }
//      return Container(
//        width: double.infinity,
//        height: 300,
//        child: ListView.builder(
//          itemBuilder: (_, i) {
//            if (popUpOn) {
//              popUp = PopUp(listaDeUsuarios[i], usuarioProvider, largura,
//                  altura, esteUsuario);
//            }
//            return Card(
//              child: ListTile(
//                onTap: () {
//                  mostrarPopUp(listaDeUsuarios[i], usuarioProvider, largura,
//                      altura, esteUsuario);
//                  setState(() {
//                    _usuarioPopUp = listaDeUsuarios[i];
//                  });
//                },
//                title: Text(listaDeUsuarios[i].nome),
//                leading: CircleAvatar(
//                  backgroundImage: NetworkImage(listaDeUsuarios[i].imagemUrl),
//                ),
//                trailing: Container(
//                  width: 110,
//                  height: 50,
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.end,
//                    children: [
//                      IconButton(
//                        icon: ImageIcon(
//                          AssetImage('assets/images/aceitar.png'),
//                          size: 50,
//                          color: Color(0xff058BC6),
//                        ),
//                        onPressed: () {
//                          aceitarSolicitacao(
//                              listaDeUsuarios[i], usuarioProvider);
//                        },
//                      ),
//                      SizedBox(
//                        width: 5,
//                      ),
//                      IconButton(
//                        icon: ImageIcon(
//                          AssetImage('assets/images/recusar.png'),
//                          size: 50,
//                          color: Colors.red,
//                        ),
//                        onPressed: () {
//                          rejeitarSolicitacao(
//                              listaDeUsuarios[i], usuarioProvider);
//                          setState(() {
//                            popUp = Container();
//                            popUpOn = false;
//                          });
//                        },
//                      )
//                    ],
//                  ),
//                ),
//              ),
//            );
//          },
//          itemCount: listaDeUsuarios.length,
//        ),
//      );
//    } else if (abaEscolhida == 'Salvos') {
//      if (popUpOn && !listaDeUsuarios.contains(_usuarioPopUp)) {
//        popUp = Container();
//        popUpOn = false;
//        //print('show snackbar');
////        OneContext().showSnackBar(
////            builder: (_) => SnackBar(content: Text('Solicitação de amizade recebida!'))
////        );
//      }
//      return Container(
//        width: double.infinity,
//        height: 300,
//        child: ListView.builder(
//          itemBuilder: (_, i) {
//            if (popUpOn) {
//              popUp = PopUp(listaDeUsuarios[i], usuarioProvider, largura,
//                  altura, esteUsuario);
//            }
//            return !esteUsuario.solicitacoesRecebidas
//                    .contains(listaDeUsuarios[i].uid)
//                ? Card(
//                    child: ListTile(
//                      onTap: () {
//                        mostrarPopUp(listaDeUsuarios[i], usuarioProvider,
//                            largura, altura, esteUsuario);
//                      },
//                      title: Text(listaDeUsuarios[i].nome),
//                      leading: CircleAvatar(
//                        backgroundImage:
//                            NetworkImage(listaDeUsuarios[i].imagemUrl),
//                      ),
//                      trailing: Container(
//                        width: 160,
//                        height: 50,
//                        child: Row(
//                          children: [
//                            !esteUsuario.solicitacoesRecebidas
//                                    .contains(listaDeUsuarios[i].uid)
//                                ? ButtonTheme(
//                                    minWidth: 50,
//                                    height: 30,
//                                    child: RaisedButton(
//                                      color: Color(0xff058BC6),
//                                      shape: RoundedRectangleBorder(
//                                          borderRadius:
//                                              BorderRadius.circular(18.0),
//                                          side: BorderSide(color: Color(0xff058BC6))),
//                                      child: Text(
//                                        'Add',
//                                        style: TextStyle(color: Colors.white),
//                                      ),
//                                      onPressed: () {
//                                        adicionarUsuario(listaDeUsuarios[i],
//                                            usuarioProvider);
//                                      },
//                                    ),
//                                  )
//                                : FlatButton(
//                                    child: Text('Responder'),
//                                    onPressed: () {
//                                      mostrarPopUp(
//                                          listaDeUsuarios[i],
//                                          usuarioProvider,
//                                          largura,
//                                          altura,
//                                          esteUsuario);
//                                    },
//                                  ),
//                            SizedBox(
//                              width: 5,
//                            ),
//                            IconButton(
//                              icon: ImageIcon(
//                                AssetImage('assets/images/recusar.png'),
//                                size: 50,
//                                color: Colors.black,
//                              ),
//                              onPressed: () {
//                                apagarUsuarioSalvo(
//                                    listaDeUsuarios[i], usuarioProvider);
//                              },
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  )
//                : Container();
//          },
//          itemCount: listaDeUsuarios.length,
//        ),
//      );
//    }
//  }
//
//  void selecionarAba(List<Usuario> lista, String aba) {
//    listaDeUsuarios = lista;
//    abaEscolhida = aba;
//  }
//
//  void logout() async {
//    await FirebaseAuth.instance.signOut();
//    Navigator.pushNamed(context, '/');
//  }
//
//  Future<void> aceitarSolicitacao(
//      Usuario usuarioQueSeraAceito, UsuarioCRUD usuarioProvider) async {
//    await aceitacaoEsteUsuario(usuarioQueSeraAceito, usuarioProvider);
//
//    await aceitacaoOutroUsuario(usuarioQueSeraAceito, usuarioProvider);
//  }
//
//  Future aceitacaoEsteUsuario(
//      Usuario usuarioQueSeraAceito, UsuarioCRUD usuarioProvider) async {
//    List<dynamic> solicitacoesRecebidasDesteUsuario =
//        esteUsuario.solicitacoesRecebidas;
//    List<dynamic> contatos = esteUsuario.contatos;
//
//    solicitacoesRecebidasDesteUsuario
//        .removeWhere((element) => element == usuarioQueSeraAceito.uid);
//
//    contatos.add(usuarioQueSeraAceito.uid);
//
//    esteUsuario.setSolicitacoesRecebidas(solicitacoesRecebidasDesteUsuario);
//    esteUsuario.setContatos(contatos);
//
//    await usuarioProvider.updateUsuario(esteUsuario, esteUsuario.uid);
//
//    setState(() {
//      solicitacoesRecebidas
//          .removeWhere((element) => element.uid == usuarioQueSeraAceito.uid);
//    });
//  }
//
//  Future aceitacaoOutroUsuario(
//      Usuario usuarioQueSeraAceito, UsuarioCRUD usuarioProvider) async {
//    List<dynamic> solicitacoesFeitasDoUsuarioAceito =
//        usuarioQueSeraAceito.solicitacoesFeitas;
//    List<dynamic> contatosDoUsuarioAceito = usuarioQueSeraAceito.contatos;
//
//    solicitacoesFeitasDoUsuarioAceito
//        .removeWhere((element) => element == esteUsuario.uid);
//    contatosDoUsuarioAceito.add(esteUsuario.uid);
//
//    usuarioQueSeraAceito
//        .setSolicitacoesFeitas(solicitacoesFeitasDoUsuarioAceito);
//    usuarioQueSeraAceito.setContatos(contatosDoUsuarioAceito);
//
//    await usuarioProvider.updateUsuario(
//        usuarioQueSeraAceito, usuarioQueSeraAceito.uid);
//  }
//
//  Future<void> rejeitarSolicitacao(
//      Usuario usuarioQueSeraRejeitado, UsuarioCRUD usuarioProvider) async {
//    await rejeicaoEsteUsuario(usuarioQueSeraRejeitado, usuarioProvider);
//
//    await rejeicaoOutroUsuario(usuarioQueSeraRejeitado, usuarioProvider);
//  }
//
//  Future rejeicaoEsteUsuario(
//      Usuario usuarioQueSeraRejeitado, UsuarioCRUD usuarioProvider) async {
//    List<dynamic> solicitacoesRecebidasDesteUsuario =
//        esteUsuario.solicitacoesRecebidas;
//
//    solicitacoesRecebidasDesteUsuario
//        .removeWhere((element) => element == usuarioQueSeraRejeitado.uid);
//
//    esteUsuario.setSolicitacoesRecebidas(solicitacoesRecebidasDesteUsuario);
//
//    await usuarioProvider.updateUsuario(esteUsuario, esteUsuario.uid);
//
//    setState(() {
//      solicitacoesRecebidas
//          .removeWhere((element) => element.uid == usuarioQueSeraRejeitado.uid);
//    });
//  }
//
//  Future rejeicaoOutroUsuario(
//      Usuario usuarioQueSeraRejeitado, UsuarioCRUD usuarioProvider) async {
//    List<dynamic> solicitacoesFeitasDoUsuarioRejeitado =
//        usuarioQueSeraRejeitado.solicitacoesFeitas;
//
//    solicitacoesFeitasDoUsuarioRejeitado
//        .removeWhere((element) => element == esteUsuario.uid);
//
//    usuarioQueSeraRejeitado
//        .setSolicitacoesFeitas(solicitacoesFeitasDoUsuarioRejeitado);
//
//    await usuarioProvider.updateUsuario(
//        usuarioQueSeraRejeitado, usuarioQueSeraRejeitado.uid);
//  }
//
//  Future<void> cancelarSolicitacao(
//      Usuario usuarioQueSeraCancelado, UsuarioCRUD usuarioProvider) async {
//    await cancelamentoEsteUsuario(usuarioQueSeraCancelado, usuarioProvider);
//
//    await cancelamentoOutroUsuario(usuarioQueSeraCancelado, usuarioProvider);
//  }
//
//  Future cancelamentoEsteUsuario(
//      Usuario usuarioQueSeraCancelado, UsuarioCRUD usuarioProvider) async {
//    List<dynamic> solicitacoesFeitasDesteUsuario =
//        esteUsuario.solicitacoesFeitas;
//
//    solicitacoesFeitasDesteUsuario
//        .removeWhere((element) => element == usuarioQueSeraCancelado.uid);
//
//    esteUsuario.setSolicitacoesFeitas(solicitacoesFeitasDesteUsuario);
//
//    await usuarioProvider.updateUsuario(esteUsuario, esteUsuario.uid);
//
//    setState(() {
//      solicitacoesFeitas
//          .removeWhere((element) => element.uid == usuarioQueSeraCancelado.uid);
//    });
//  }
//
//  Future cancelamentoOutroUsuario(
//      Usuario usuarioQueSeraCancelado, UsuarioCRUD usuarioProvider) async {
//    List<dynamic> solicitacoesRecebidasDoUsuarioCancelado =
//        usuarioQueSeraCancelado.solicitacoesRecebidas;
//
//    solicitacoesRecebidasDoUsuarioCancelado
//        .removeWhere((element) => element == esteUsuario.uid);
//
//    usuarioQueSeraCancelado
//        .setSolicitacoesRecebidas(solicitacoesRecebidasDoUsuarioCancelado);
//
//    await usuarioProvider.updateUsuario(
//        usuarioQueSeraCancelado, usuarioQueSeraCancelado.uid);
//  }
//
//  Future<void> adicionarUsuario(
//      Usuario usuarioQueSeraAceito, UsuarioCRUD usuarioProvider) async {
//    await atualizarEsteUsuarioAdd(usuarioQueSeraAceito, usuarioProvider);
//
//    await atualizarOutroUsuarioAdd(usuarioQueSeraAceito, usuarioProvider);
//  }
//
//  Future atualizarEsteUsuarioAdd(
//      Usuario usuarioQueSeraAdicionado, UsuarioCRUD usuarioProvider) async {
//    List<dynamic> usuariosSalvosDesteUsuario = esteUsuario.usuariosSalvos;
//    List<dynamic> solicitacoesFeitas = esteUsuario.solicitacoesFeitas;
//
//    usuariosSalvosDesteUsuario
//        .removeWhere((element) => element == usuarioQueSeraAdicionado.uid);
//
//    solicitacoesFeitas.add(usuarioQueSeraAdicionado.uid);
//
//    esteUsuario.setUsuariosSalvos(usuariosSalvosDesteUsuario);
//    esteUsuario.setSolicitacoesFeitas(solicitacoesFeitas);
//
//    await usuarioProvider.updateUsuario(esteUsuario, esteUsuario.uid);
//
//    setState(() {
//      usuariosSalvos.removeWhere(
//          (element) => element.uid == usuarioQueSeraAdicionado.uid);
//    });
//  }
//
//  Future atualizarOutroUsuarioAdd(
//      Usuario usuarioQueSeraAdicionado, UsuarioCRUD usuarioProvider) async {
//    List<dynamic> solicitacoesRecebidasDoUsuarioAceito =
//        usuarioQueSeraAdicionado.solicitacoesRecebidas;
//
//    solicitacoesRecebidasDoUsuarioAceito.add(esteUsuario.uid);
//
//    usuarioQueSeraAdicionado
//        .setSolicitacoesRecebidas(solicitacoesRecebidasDoUsuarioAceito);
//
//    Firestore db = Firestore.instance;
//    db
//        .collection('usuarios')
//        .document(usuarioQueSeraAdicionado.uid)
//        .collection('notifications')
//        .add({
//      'message': '${esteUsuario.nome} adicionou você',
//      'title': 'Nova solicitação de amizade',
//      'date': FieldValue.serverTimestamp(),
//    });
//
//    await usuarioProvider.updateUsuario(
//        usuarioQueSeraAdicionado, usuarioQueSeraAdicionado.uid);
//  }
//
//  Future<void> apagarUsuarioSalvo(
//      Usuario usuarioQueSeraApagado, UsuarioCRUD usuarioProvider) async {
//    List<dynamic> usuariosSalvosDesteUsuario = esteUsuario.usuariosSalvos;
//
//    usuariosSalvosDesteUsuario
//        .removeWhere((element) => element == usuarioQueSeraApagado.uid);
//
//    esteUsuario.setUsuariosSalvos(usuariosSalvosDesteUsuario);
//
//    await usuarioProvider.updateUsuario(esteUsuario, esteUsuario.uid);
//
//    setState(() {
//      usuariosSalvos
//          .removeWhere((element) => element.uid == usuarioQueSeraApagado.uid);
//    });
//  }
//
//  void _onItemTapped(int value) {
//    setState(() {
//      _selectedIndexBottomNavBar = value;
//    });
//  }
//
//  Widget PopUp(Usuario usuario, UsuarioCRUD usuarioProvider, double largura,
//      double altura, Usuario esteUsuario) {
//    return StreamBuilder(
//        stream: usuarioProvider.getUsuarioAsStream(esteUsuario.uid),
//        builder: (context, snapshot) {
//          if (snapshot.hasError) {
//          } else {
//            switch (snapshot.connectionState) {
//              case ConnectionState.none:
//                print('ConnectionState.none');
//                return Center(
//                  child: Text('teste 6'),
//                );
//                //return reload(largura, altura);
//                break;
//              case ConnectionState.waiting:
//                //print('ConnectionState.waiting');
//                return Center(
//                  child: CircularProgressIndicator(),
//                );
//                //return reload(largura, altura);
//                break;
//              case ConnectionState.done:
//                print('ConnectionState.done');
//                return Center(
//                  child: Text('teste 4'),
//                );
//                //return reload(largura, altura);
//                break;
//              case ConnectionState.active:
//                esteUsuario = Usuario.fromMap(snapshot.data.data);
//
//                return Scaffold(
//                    backgroundColor: Colors.black26,
//                    body: Container(
//                      child: Center(
//                        child: Container(
//                          width: largura * 0.8,
//                          height: altura * 0.73,
//                          child: SingleChildScrollView(
//                            child: Column(
//                              children: [
//                                Stack(
//                                  alignment: Alignment.topCenter,
//                                  children: [
//                                    Column(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.spaceEvenly,
//                                      crossAxisAlignment:
//                                          CrossAxisAlignment.center,
//                                      children: [
//                                        Container(
//                                          width: largura * 0.8,
//                                          height: (altura * 0.073),
//                                          color: Colors.transparent,
//                                        ),
//                                        Container(
//                                          width: largura * 0.8,
//                                          height: (altura * 0.073),
//                                          color: Colors.white,
//                                        ),
//                                      ],
//                                    ),
//                                    Stack(
//                                      alignment: Alignment.center,
//                                      children: [
//                                        CircleAvatar(
//                                          backgroundColor: Colors.white,
//                                          radius: altura * 0.073,
//                                        ),
//                                        CircleAvatar(
//                                          backgroundImage:
//                                              NetworkImage(usuario.imagemUrl),
//                                          radius: altura * 0.07,
//                                        ),
//                                      ],
//                                    ),
//                                  ],
//                                ),
//                                Container(
//                                  width: largura * 0.8,
//                                  padding: EdgeInsets.symmetric(
//                                      vertical: altura * 0.02,
//                                      horizontal: largura * 0.02),
//                                  color: Colors.white,
//                                  child: Column(
//                                    children: [
//                                      usuario.mostrarIdade
//                                          ? Text(
//                                              '${usuario.nome}, ${CalculadoraDeIdade.obterIdade(usuario.dataDeNascimento)}',
//                                              textAlign: TextAlign.center,
//                                              style: TextStyle(
//                                                fontSize: 26,
//                                              ),
//                                            )
//                                          : Text(
//                                              '${usuario.nome}',
//                                              textAlign: TextAlign.center,
//                                              style: TextStyle(
//                                                fontSize: 26,
//                                              ),
//                                            ),
//                                      Text('${usuario.profissao}'),
//                                      SizedBox(
//                                        height: 10,
//                                      ),
//                                      Text('${usuario.bio ?? '...'}'),
//                                      SizedBox(
//                                        height: 15,
//                                      ),
////                          definirBotaoAdicionarPopUp(usuario, usuarioProvider,
////                              largura, altura, esteUsuario),
//                                      FutureBuilder(
//                                        future: definirBotaoAdicionarPopUp(
//                                            usuario,
//                                            usuarioProvider,
//                                            largura,
//                                            altura,
//                                            esteUsuario),
//                                        builder: (context, snapshot) {
//                                          var bugSolver;
//                                          if (snapshot.hasData) {
//                                            //botaoPopUp = snapshot.data;
//                                            if (popUpOn) {
//                                              popUp = PopUp(
//                                                  usuario,
//                                                  usuarioProvider,
//                                                  largura,
//                                                  altura,
//                                                  esteUsuario);
//                                            }
////                              popUp = PopUp(
////                                  usuario, usuarioProvider, largura, altura);
//                                            switch (snapshot.connectionState) {
//                                              case ConnectionState.none:
//                                                return Center(
//                                                  child: Text(
//                                                      'none ${snapshot.data}'),
//                                                );
//                                                break;
//                                              case ConnectionState.waiting:
//                                                if (abaEscolhida == 'Salvos') {
//                                                  bugSolver = snapshot.data;
//                                                  print(bugSolver);
//                                                }
//                                                return Center(
//                                                  child: Text(
//                                                      'waiting ${snapshot.data}'),
//                                                );
//                                                break;
//                                              case ConnectionState.done:
//                                                return snapshot.data;
//                                                break;
//                                              case ConnectionState.active:
//                                                return snapshot.data;
//                                                break;
//                                            }
//                                          } else {
//                                            return Text('no data');
//                                          }
//                                        },
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                                Stack(
//                                  alignment: Alignment.bottomCenter,
//                                  children: [
//                                    Column(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.spaceEvenly,
//                                      crossAxisAlignment:
//                                          CrossAxisAlignment.center,
//                                      children: [
//                                        Container(
//                                          width: largura * 0.8,
//                                          height: (altura * 0.07),
//                                          color: Colors.transparent,
//                                        ),
//                                        Container(
//                                          width: largura * 0.8,
//                                          height: (altura * 0.07),
//                                          color: Colors.transparent,
//                                        ),
//                                      ],
//                                    ),
//                                    GestureDetector(
//                                      child: Container(
//                                        width: 70,
//                                        height: 70,
//                                        child: Center(
//                                            child: Text(
//                                          'x',
//                                          style: TextStyle(
//                                              fontWeight: FontWeight.w200,
//                                              fontSize: 36),
//                                        )),
//                                        decoration: BoxDecoration(
//                                            shape: BoxShape.circle,
//                                            color: Colors.white),
//                                      ),
//                                      onTap: () {
//                                        setState(() {
//                                          popUp = Container();
//                                          popUpOn = false;
//                                        });
//                                      },
//                                    ),
//                                  ],
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                      ),
//                    ));
//
//                break;
//              default:
//            }
//          }
//        });
//  }
//
//  void mostrarPopUp(Usuario usuario, UsuarioCRUD usuarioProvider,
//      double largura, double altura, Usuario esteUsuario) {
//    setState(() {
//      popUpOn = true;
//      popUp = PopUp(usuario, usuarioProvider, largura, altura, esteUsuario);
//    });
//  }
//
//  Future<Widget> definirBotaoAdicionarPopUp(
//      Usuario usuario,
//      UsuarioCRUD usuarioProvider,
//      double largura,
//      double altura,
//      Usuario esteUsuario) async {
//    if (esteUsuario.solicitacoesFeitas.contains(usuario.uid)) {
//      return Container(
//        child: RaisedButton(
//          color: Colors.white,
//          shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(18.0),
//              side: BorderSide(color: Colors.red)),
//          child: Text(
//            'Cancelar solicitação',
//            style: TextStyle(color: Colors.red),
//          ),
//          onPressed: () async {
//            await cancelarSolicitacao(usuario, usuarioProvider);
//            mostrarPopUp(
//                usuario, usuarioProvider, largura, altura, esteUsuario);
//          },
//        ),
//      );
//    } else if (esteUsuario.solicitacoesRecebidas.contains(usuario.uid)) {
//      print('aceitar, recusar, bloquear!!!!!!!!!!!');
//      return Container(
//        child: Column(
//          children: [
//            ButtonTheme(
//              minWidth: 150,
//              child: RaisedButton(
//                color: Color(0xff058BC6),
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(18.0),
//                    side: BorderSide(color: Color(0xff058BC6))),
//                child: Text(
//                  'Aceitar',
//                  style: TextStyle(color: Colors.white),
//                ),
//                onPressed: () {
//                  aceitarSolicitacao(usuario, usuarioProvider);
//                  setState(() {
//                    popUp = Container();
//                    popUpOn = false;
//                  });
//                },
//              ),
//            ),
//            ButtonTheme(
//              minWidth: 150,
//              child: RaisedButton(
//                color: Colors.white,
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(18.0),
//                    side: BorderSide(color: Colors.red)),
//                child: Text(
//                  'Recusar',
//                  style: TextStyle(color: Colors.red),
//                ),
//                onPressed: () {
//                  rejeitarSolicitacao(usuario, usuarioProvider);
//                  setState(() {
//                    popUp = Container();
//                    popUpOn = false;
//                  });
//                },
//              ),
//            ),
//            ButtonTheme(
//              minWidth: 150,
//              child: RaisedButton(
//                color: Colors.white,
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(18.0),
//                    side: BorderSide(color: Colors.grey)),
//                child: Text(
//                  'Bloquear',
//                  style: TextStyle(color: Colors.grey),
//                ),
//                onPressed: () {
//                  bloquearUsuario(usuario, usuarioProvider);
//                },
//              ),
//            ),
//          ],
//        ),
//      );
//    } else if (esteUsuario.contatos.contains(usuario.uid)) {
//      return Container(
//        child: Text(
//          'Seu contato',
//          style: TextStyle(color: Color(0xff058BC6), fontWeight: FontWeight.bold),
//        ),
//      );
//    } else if (!esteUsuario.solicitacoesRecebidas.contains(usuario.uid) &&
//        !esteUsuario.contatos.contains(usuario.uid)) {
//      print('enviar, remover');
//      return Container(
//        child: Column(
//          children: [
//            RaisedButton(
//              color: Color(0xff058BC6),
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(18.0),
//                  side: BorderSide(color: Color(0xff058BC6))),
//              child: Text(
//                'Enviar solicitacao',
//                style: TextStyle(color: Colors.white),
//              ),
//              onPressed: () async {
//                await adicionarUsuario(usuario, usuarioProvider);
//                mostrarPopUp(
//                    usuario, usuarioProvider, largura, altura, esteUsuario);
//              },
//            ),
////            RaisedButton(
////              color: Color(0xff058BC6),
////              shape: RoundedRectangleBorder(
////                  borderRadius: BorderRadius.circular(18.0),
////                  side: BorderSide(color: Color(0xff058BC6))),
////              child: Text(
////                'Remover',
////                style: TextStyle(color: Colors.white),
////              ),
////              onPressed: () async {
////                await apagarUsuarioSalvo(usuario, usuarioProvider);
////                setState(() {
////                  popUp = Container();
////                  popUpOn = false;
////                });
////              },
////            ),
//          ],
//        ),
//      );
//    }
//  }
//
//  Future<void> bloquearUsuario(
//      Usuario usuarioBlock, UsuarioCRUD usuarioProvider) async {
//    await atualizarEsteUsuarioBlock(usuarioBlock, usuarioProvider);
//
//    await atualizarOutroUsuarioBlock(usuarioBlock, usuarioProvider);
//  }
//
//  Future atualizarEsteUsuarioBlock(
//      Usuario usuarioBlock, UsuarioCRUD usuarioProvider) async {
//    List<dynamic> usuariosSalvosDesteUsuario = esteUsuario.usuariosSalvos;
//    List<dynamic> usuariosBloqueadosDesteUsuario =
//        esteUsuario.usuariosQueBloqueei;
//    List<dynamic> contatosDesteUsuario = esteUsuario.contatos;
//    List<dynamic> solicitacoesRecebidasDesteUsuario =
//        esteUsuario.solicitacoesRecebidas;
//    List<dynamic> solicitacoesFeitasDesteUsuario =
//        esteUsuario.solicitacoesFeitas;
//
//    solicitacoesFeitasDesteUsuario
//        .removeWhere((element) => element == usuarioBlock.uid);
//    solicitacoesRecebidasDesteUsuario
//        .removeWhere((element) => element == usuarioBlock.uid);
//    usuariosSalvosDesteUsuario
//        .removeWhere((element) => element == usuarioBlock.uid);
//    contatosDesteUsuario.removeWhere((element) => element == usuarioBlock.uid);
//
//    usuariosBloqueadosDesteUsuario.add(usuarioBlock.uid);
//
//    esteUsuario.setUsuariosSalvos(usuariosSalvosDesteUsuario);
//    esteUsuario.setUsuariosQueBloqueei(usuariosBloqueadosDesteUsuario);
//    esteUsuario.setContatos(contatosDesteUsuario);
//    esteUsuario.setSolicitacoesRecebidas(solicitacoesRecebidasDesteUsuario);
//    esteUsuario.setSolicitacoesFeitas(solicitacoesFeitasDesteUsuario);
//
//    await usuarioProvider.updateUsuario(esteUsuario, esteUsuario.uid);
//
//    setState(() {
//      usuariosSalvos.removeWhere((element) => element.uid == usuarioBlock.uid);
//      solicitacoesFeitas.removeWhere((element) => element == usuarioBlock.uid);
//      solicitacoesRecebidas
//          .removeWhere((element) => element == usuarioBlock.uid);
//    });
//  }
//
//  Future atualizarOutroUsuarioBlock(
//      Usuario usuarioBlock, UsuarioCRUD usuarioProvider) async {
//    List<dynamic> usuariosSalvosUsuarioBlock = usuarioBlock.usuariosSalvos;
//    List<dynamic> usuariosQueBloquearamUsuarioBlock =
//        usuarioBlock.usuariosQueTeBloquearam;
//    List<dynamic> contatosUsuarioBlock = usuarioBlock.contatos;
//    List<dynamic> solicitacoesRecebidasUsuarioBlock =
//        usuarioBlock.solicitacoesRecebidas;
//    List<dynamic> solicitacoesFeitasUsuarioBlock =
//        usuarioBlock.solicitacoesFeitas;
//
//    usuariosSalvosUsuarioBlock
//        .removeWhere((element) => element == esteUsuario.uid);
//    contatosUsuarioBlock.removeWhere((element) => element == esteUsuario.uid);
//    solicitacoesRecebidasUsuarioBlock
//        .removeWhere((element) => element == esteUsuario.uid);
//    solicitacoesFeitasUsuarioBlock
//        .removeWhere((element) => element == esteUsuario.uid);
//
//    usuariosQueBloquearamUsuarioBlock.add(esteUsuario.uid);
//
//    usuarioBlock.setUsuariosSalvos(usuariosSalvosUsuarioBlock);
//    usuarioBlock.setUsuariosQueTeBloquearam(usuariosQueBloquearamUsuarioBlock);
//    usuarioBlock.setContatos(contatosUsuarioBlock);
//    usuarioBlock.setSolicitacoesRecebidas(solicitacoesRecebidasUsuarioBlock);
//    usuarioBlock.setSolicitacoesFeitas(solicitacoesFeitasUsuarioBlock);
//
//    await usuarioProvider.updateUsuario(usuarioBlock, usuarioBlock.uid);
//  }
//}
