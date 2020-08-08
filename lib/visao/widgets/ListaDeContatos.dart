//import 'dart:async';
//
//import 'package:MeetBy/modelo/Usuario.dart';
//import 'package:MeetBy/telas/TelaContatos.dart';
//import 'package:MeetBy/telas/TelaPerfilDoContato.dart';
//import 'package:MeetBy/util/UsuarioCRUD.dart';
//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:provider/provider.dart';
//import 'package:share/share.dart';
//
//class ListaDeContatos extends StatefulWidget {
//  @override
//  _ListaDeContatosState createState() => _ListaDeContatosState();
//  List<Usuario> contatos;
//  Usuario esteUsuario;
//
//  //uso isso para identificar a stream
//  static bool popUpOn = false;
//
//  ListaDeContatos(List<Usuario> contatos, Usuario esteEsuario) {
//    this.contatos = contatos;
//    this.esteUsuario = esteEsuario;
//  }
//
//  static var popUpController = StreamController<Usuario>.broadcast();
//
//  static Stream<Usuario> get popUp => popUpController.stream;
//
//  void setEsteUsuario(Usuario usuario) {
//    esteUsuario = usuario;
//  }
//
//  void setContatos(List<Usuario> lista) {
//    contatos = lista;
//  }
//}
//
//class _ListaDeContatosState extends State<ListaDeContatos> {
//  updatePopUp(Usuario usuarioPopUp) {
//    ListaDeContatos.popUpOn = true;
//    ListaDeContatos.popUpController.sink.add(usuarioPopUp);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    UsuarioCRUD usuarioProvider = Provider.of<UsuarioCRUD>(context);
//    return StreamBuilder(
//        stream: TelaContatos.textStream,
//        builder: (context, snapshot) {
////          print('snapshot3 ${snapshot.data}');
//          if (snapshot.hasError) {
//            print('snapshot4 ${snapshot.data}');
//            return Center(
//              child: Text('Erro na pesquisa'),
//            );
//          } else {
////            print('snapshot5 ${snapshot.data}');
//            return contruirLista(context, usuarioProvider, snapshot.data);
//          }
//        });
//  }
//
//  Container contruirLista(
//      BuildContext context, UsuarioCRUD usuarioProvider, String filtro) {
//    List<Usuario> contatos;
//    if (filtro == null || filtro == '') {
//      contatos = widget.contatos;
//    } else {
//      contatos = widget.contatos
//          .where((usuario) => usuario.nome.toLowerCase().contains(filtro))
//          .toList();
//    }
//
//    contatos.sort((a, b) => a.nome.compareTo(b.nome));
//
//    String primeiraLetra = '#';
//    String primeiraLetraAnterior = '#';
//
//    return Container(
//      width: double.infinity,
//      height: 300,
//      child: contatos.length > 0
//          ? ListView.builder(
//              itemBuilder: (_, i) {
//                primeiraLetra = contatos[i].nome.substring(0, 1);
//
//                if (!contatos[i].nome.startsWith(primeiraLetraAnterior)) {
//                  primeiraLetraAnterior = primeiraLetra;
//                  return Column(
//                    children: [
//                      Container(
//                        color: Colors.black12,
//                        width: double.infinity,
//                        child: Container(
//                          padding:
//                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                          child: Text(
//                            primeiraLetra.toUpperCase(),
//                            style: TextStyle(
//                                color: Colors.black54,
//                                fontWeight: FontWeight.bold),
//                          ),
//                        ),
//                      ),
//                      Card(
//                        child: Slidable(
//                          key: Key(contatos[i].uid),
//                          actionPane: SlidableDrawerActionPane(),
//                          actionExtentRatio: 0.25,
//                          actions: [
//                            IconSlideAction(
//                              caption: 'Compartilhar',
//                              color: Color(0xff058BC6),
//                              iconWidget: ImageIcon(
//                                AssetImage('assets/images/compartilhar.png'),
//                                size: 30,
//                                color: Colors.white,
//                              ),
//                              onTap: () => compartilhar(context, contatos[i]),
//                            ),
//                          ],
//                          secondaryActions: [
//                            IconSlideAction(
//                              caption: 'Excluir',
//                              color: Colors.red,
//                              iconWidget: ImageIcon(
//                                AssetImage(
//                                    'assets/images/icones_azul_Deletar.png'),
//                                size: 30,
//                                color: Colors.white,
//                              ),
//                              onTap: () {
//                                updatePopUp(contatos[i]);
//                              },
//                            ),
//                          ],
//                          child: ListTile(
//                            onTap: () {
//                              Navigator.pushNamed(
//                                  context, TelaPerfilDoContato.rota,
//                                  arguments: [contatos[i], widget.esteUsuario]);
//                            },
//                            title: Text(contatos[i].nome),
//                            leading: CircleAvatar(
//                              backgroundImage:
//                                  NetworkImage(contatos[i].imagemUrl),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ],
//                  );
//                } else {
//                  return Card(
//                    child: Slidable(
//                      key: Key(contatos[i].uid),
//                      actionPane: SlidableDrawerActionPane(),
//                      actionExtentRatio: 0.25,
//                      actions: [
//                        IconSlideAction(
//                          caption: 'Compartilhar',
//                          color: Color(0xff058BC6),
//                          iconWidget: ImageIcon(
//                            AssetImage('assets/images/compartilhar.png'),
//                            size: 30,
//                            color: Colors.white,
//                          ),
//                          onTap: () => compartilhar(context, contatos[i]),
//                        ),
//                      ],
//                      secondaryActions: [
//                        IconSlideAction(
//                          caption: 'Excluir',
//                          color: Colors.red,
//                          iconWidget: ImageIcon(
//                            AssetImage('assets/images/icones_azul_Deletar.png'),
//                            size: 30,
//                            color: Colors.white,
//                          ),
//                          onTap: () {
//                            updatePopUp(contatos[i]);
//                          },
//                        ),
//                      ],
//                      child: ListTile(
//                        onTap: () {
//                          Navigator.pushNamed(context, TelaPerfilDoContato.rota,
//                              arguments: [contatos[i], widget.esteUsuario]);
//                        },
//                        title: Text(contatos[i].nome),
//                        leading: CircleAvatar(
//                          backgroundImage: NetworkImage(contatos[i].imagemUrl),
//                        ),
//                      ),
//                    ),
//                  );
//                }
//              },
//              itemCount: contatos.length,
//            )
//          : Column(
//              children: [
//                Align(
//                  alignment: Alignment.topLeft,
//                  child: Container(
//                      color: Colors.black12,
//                      width: double.infinity,
//                      height: 30,
//                      child: Container(
//                          padding:
//                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                          child: Text(
//                            'Sem contatos',
//                            style: TextStyle(
//                                color: Colors.black54,
//                                fontWeight: FontWeight.bold),
//                          ))),
//                ),
//                Row(
//                  children: [
//                    ImageIcon(
//                      AssetImage('assets/images/compartilhar.png'),
//                      size: 30,
//                      color: Color(0xff058BC6),
//                    ),
//                    Text('Convidar amigos')
//                  ],
//                ),
//                Row(
//                  children: [],
//                ),
//              ],
//            ),
//    );
//  }
//
//  void compartilhar(BuildContext context, Usuario contato) {
//    final String text = 'Veja esta pessoa: ${contato.nome}';
//
//    createLink(contato.uid)
//        .then((url) => Share.share('$text\n$url', subject: text));
//  }
//
//  Future<String> createLink(String id) async {
//    final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
//      uriPrefix: 'https://meetby.page.link',
//      link: Uri.parse('http://matheusneumann.surge.sh/usuario?id=$id'),
//      androidParameters: AndroidParameters(packageName: 'com.me.by'),
//    );
//
//    final Uri dynamicUrl = await dynamicLinkParameters.buildUrl();
//    return dynamicUrl.toString();
//  }
//}
