//import 'dart:async';
//import 'dart:io';
//
//import 'package:MeetBy/widgets/ListaDeContatos.dart';
//import 'package:connectivity/connectivity.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:MeetBy/modelo/Usuario.dart';
//import 'package:MeetBy/telas/TelaMeuPerfil.dart';
//import 'package:MeetBy/telas/TelaRadar.dart';
//import 'package:MeetBy/util/UsuarioCRUD.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:provider/provider.dart';
//
//class TelaContatos extends StatefulWidget {
//  static const String rota = '/telaContatos';
//
//  static var _textController = StreamController<String>.broadcast();
//
//  static Stream<String> get textStream => _textController.stream;
//
//  @override
//  _TelaContatosState createState() => _TelaContatosState();
//}
//
//class _TelaContatosState extends State<TelaContatos> {
//  ListaDeContatos _listaDeContatos;
//
//  Usuario esteUsuario;
//  List<Usuario> contatos = List<Usuario>();
//  List<Usuario> contatosBackup = List<Usuario>();
//
//  String filtro;
//
//  Widget popUp;
//  bool popUpOn = false;
//
//  static UsuarioCRUD usuarioProvider;
//
//  double largura, altura;
//
//  var subscription;
//  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//
//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//      FlutterLocalNotificationsPlugin();
//  var initializationSettingsAndroid;
//  var initializationSettingsIOS;
//  var initializationSettings;
//
//  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//  Future onDidReceiveLocalNotification(
//      int id, String title, String body, String payload) async {
//    await showDialog(
//        context: context,
//        builder: (BuildContext context) => CupertinoAlertDialog(
//              title: Text(title),
//              content: Text(body),
//              actions: <Widget>[
//                CupertinoDialogAction(
//                  isDefaultAction: true,
//                  child: Text('Ok'),
//                  onPressed: () async {
//                    Navigator.of(context, rootNavigator: true).pop();
//                    await Navigator.pushNamed(context, TelaContatos.rota);
//                  },
//                )
//              ],
//            ));
//  }
//
//  @override
//  void initState() {
//    _listaDeContatos = ListaDeContatos(contatos, esteUsuario);
//
//    subscription = Connectivity()
//        .onConnectivityChanged
//        .listen((ConnectivityResult result) {
//      if (result == ConnectivityResult.mobile) {
//        print('3g');
//      } else if (result == ConnectivityResult.wifi) {
//        print('wifi');
//      } else {
//        _showDialog(context, 'Sem internet',
//            'Conecte-se ao wifi ou 3g para poder usar as funcionalidades do aplicativo');
//      }
//    });
//
//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        print("onMessage: $message");
//      },
//      onBackgroundMessage: myBackgroundMessageHandler,
//      onLaunch: (Map<String, dynamic> message) async {
//        print("onLaunch: $message");
//      },
//      onResume: (Map<String, dynamic> message) async {
//        print("onResume: $message");
//      },
//    );
//
//    if (Platform.isIOS) {
//      _firebaseMessaging.requestNotificationPermissions(
//        const IosNotificationSettings(
//            alert: true, badge: true, provisional: false, sound: true),
//      );
//    }
//
//    initializationSettingsAndroid =
//        new AndroidInitializationSettings('app_icon');
//    initializationSettingsIOS = new IOSInitializationSettings(
//        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//    initializationSettings = new InitializationSettings(
//        initializationSettingsAndroid, initializationSettingsIOS);
//    flutterLocalNotificationsPlugin.initialize(initializationSettings,
//        onSelectNotification: onSelectNotification);
//  }
//
//  Future onSelectNotification(String payload) async {
//    if (payload != null) {
//      debugPrint('Notification payload: $payload');
//    }
//
//    await Navigator.pushNamed(context, TelaContatos.rota);
//
//    super.initState();
//  }
//
//  static Future<dynamic> myBackgroundMessageHandler(
//      Map<String, dynamic> message) {
//    if (message.containsKey('data')) {
//      // Handle data message
//      final dynamic data = message['data'];
//    }
//
//    if (message.containsKey('notification')) {
//      // Handle notification message
//      final dynamic notification = message['notification'];
//    }
//
//    // Or do other work.
//  }
//
//  void _showDialog(BuildContext context, String titulo, String conteudo) {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // retorna um objeto do tipo Dialog
//        return AlertDialog(
//          title: new Text(titulo),
//          content: new Text(conteudo),
//          actions: <Widget>[
//            // define os botões na base do dialogo
//            new FlatButton(
//              child: new Text("Fechar"),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }
//
//  updateText(String text) {
//    TelaContatos._textController.sink.add(text);
//    print('1');
//  }
//
//  @override
//  void dispose() {
//    TelaContatos._textController.close();
//    ListaDeContatos.popUpController.close();
//    subscription.cancel();
//    super.dispose();
//  }
//
//  void controlarClick(String click) {
//    switch (click) {
//      case 'Convidar um amigo':
//        break;
//      case 'Compartilhar':
//        break;
//      case 'Atualizar':
//        showNotification();
//        break;
//      default:
//    }
//  }
//
//  void showNotification() async {
//    await _demoNotification();
//  }
//
//  Future<void> _demoNotification() async {
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'channel_ID', 'channel_name', 'chanell_description',
//        importance: Importance.Max,
//        priority: Priority.High,
//        ticker: 'test ticker');
//
//    var iOSChannelSpecifics = IOSNotificationDetails();
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSChannelSpecifics);
//
//    await flutterLocalNotificationsPlugin.show(0, 'Hello buddy',
//        'A message from flutter buddy', platformChannelSpecifics,
//        payload: 'test payload');
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    usuarioProvider = Provider.of<UsuarioCRUD>(context);
//    largura = MediaQuery.of(context).size.width;
//    altura = MediaQuery.of(context).size.height;
//
//    return WillPopScope(
//      onWillPop: () async {
//        return false;
//      },
//      child: Stack(
//        children: [
//          Scaffold(
//            appBar: AppBar(
//              backgroundColor: Colors.black,
//              title: Text('Contatos'),
//              automaticallyImplyLeading: false,
//              actions: [
//                PopupMenuButton(
//                    onSelected: controlarClick,
//                    itemBuilder: (BuildContext context) {
//                      return {'Convidar um amigo', 'Compartilhar', 'Atualizar'}
//                          .map((String escolha) {
//                        return PopupMenuItem(
//                          value: escolha,
//                          child: Text(escolha),
//                        );
//                      }).toList();
//                    })
//              ],
//            ),
//            body: FutureBuilder(
//                future: getFirebaseUser(),
//                builder: (context, snapshot) {
//                  if (snapshot.hasData) {
//                    return StreamBuilder(
//                        stream: usuarioProvider
//                            .getUsuarioAsStream(snapshot.data.uid),
//                        builder: (context, snapshot) {
//                          if (snapshot.hasError) {
//                            return Column(children: [
//                              Icon(
//                                Icons.error_outline,
//                                color: Colors.red,
//                                size: 60,
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.only(top: 16),
//                                child: Text('Error: ${snapshot.error}'),
//                              )
//                            ]);
//                          } else {
//                            switch (snapshot.connectionState) {
//                              case ConnectionState.none:
//                                print('2');
//                                return Center(
//                                    child: CircularProgressIndicator());
//                                break;
//                              case ConnectionState.waiting:
//                                print('3');
//                                return Center(
//                                    child: CircularProgressIndicator());
//                                break;
//                              case ConnectionState.done:
//                                print('4');
//                                return Center(
//                                    child: CircularProgressIndicator());
//                                break;
//                              case ConnectionState.active:
//                                print('5');
//                                esteUsuario =
//                                    Usuario.fromMap(snapshot.data.data);
//                                contatos = contatos
//                                    .where((contato) => esteUsuario.contatos
//                                        .contains(contato.uid))
//                                    .toList();
//                                _listaDeContatos.setContatos(contatos);
//                                _listaDeContatos.setEsteUsuario(esteUsuario);
//
//                                return FutureBuilder(
//                                    future: getListaDeUsuarios(usuarioProvider),
//                                    builder: (context, snapshot) {
//                                      if (snapshot.hasData) {
//                                        return Center(
//                                          child: Column(
//                                            children: [
//                                              Container(
//                                                child: Row(
//                                                  mainAxisAlignment:
//                                                      MainAxisAlignment
//                                                          .spaceAround,
//                                                  children: [
//                                                    Container(
//                                                      padding:
//                                                          EdgeInsets.symmetric(
//                                                              vertical: 20),
//                                                      width: 250,
//                                                      child: Material(
//                                                        elevation: 5.0,
//                                                        shadowColor:
//                                                            Colors.black,
//                                                        borderRadius:
//                                                            BorderRadius.all(
//                                                                Radius.circular(
//                                                                    50)),
//                                                        child: TextField(
////                                                          onChanged: (String
////                                                          text) {
////                                                            updateText(text);
////                                                            print('6');
////                                                          },
//                                                          decoration: InputDecoration(
//                                                              border:
//                                                                  InputBorder
//                                                                      .none,
//                                                              focusedBorder:
//                                                                  InputBorder
//                                                                      .none,
//                                                              enabledBorder:
//                                                                  InputBorder
//                                                                      .none,
//                                                              errorBorder:
//                                                                  InputBorder
//                                                                      .none,
//                                                              disabledBorder:
//                                                                  InputBorder
//                                                                      .none,
//                                                              prefixIcon: Icon(
//                                                                  Icons.search),
//                                                              hintText:
//                                                                  'Pesquisar'),
//                                                        ),
//                                                      ),
//                                                    ),
//                                                    GestureDetector(
//                                                      onTap: () {
//                                                        Navigator.pushNamed(
//                                                            context,
//                                                            TelaMeuPerfil.rota,
//                                                            arguments:
//                                                                esteUsuario);
//                                                      },
//                                                      child: CircleAvatar(
//                                                        radius: 25,
//                                                        backgroundImage:
//                                                            NetworkImage(
//                                                                esteUsuario
//                                                                    .imagemUrl),
//                                                      ),
//                                                    )
//                                                  ],
//                                                ),
//                                              ),
//                                              _listaDeContatos,
//                                            ],
//                                          ),
//                                        );
//                                      } else {
//                                        return Center(
//                                          child: CircularProgressIndicator(),
//                                        );
//                                      }
//                                    });
//
//                                break;
//
//                              default:
//                            }
//                          }
//                        });
//                  } else {
//                    return Center(
//                      child: CircularProgressIndicator(),
//                    );
//                  }
//                }),
//            floatingActionButton: FloatingActionButton(
//                child: ImageIcon(
//                  AssetImage('assets/images/iconepesquisa.png'),
//                  size: 50,
//                ),
//                onPressed: () {
//                  Navigator.pushNamed(context, TelaRadar.rota,
//                      arguments: esteUsuario);
//                }),
//          ),
//          StreamBuilder(
//              stream: ListaDeContatos.popUp,
//              builder: (context, snapshot) {
//                if (snapshot.hasError) {
//                  return Container();
//                } else {
//                  if (snapshot.connectionState != ConnectionState.active) {
//                    return Container();
//                  } else {
//                    print('snapshot1 ${snapshot.data}');
//                    if (ListaDeContatos.popUpOn) {
//                      popUp = PopUp(snapshot.data);
//                    }
//
//                    return popUp;
//                  }
//                }
//              }),
//        ],
//      ),
//    );
//  }
//
//  Future<FirebaseUser> getFirebaseUser() async {
//    return await FirebaseAuth.instance.currentUser();
//  }
//
//  Future<String> future(UsuarioCRUD usuarioProvider) async {
//    FirebaseUser firebaseUser = await getFirebaseUser();
//    usuarioProvider.getUsuarioAsStream(firebaseUser.uid);
//
//    return 'ok';
//  }
//
//  Future<String> getListaDeUsuarios(UsuarioCRUD usuarioProvider) async {
//    for (String usuarioId in esteUsuario.contatos) {
//      await usuarioProvider.getUsuarioById(usuarioId).then((value) {
//        if (!contatos.contains(value)) {
//          contatos.add(value);
//        }
//      });
//      contatosBackup = contatos;
//    }
//
//    return 'ok';
//  }
//
//  void logout() async {
//    await FirebaseAuth.instance.signOut();
//    Navigator.pushNamed(context, '/');
//  }
//
//  Widget PopUp(Usuario usuario) {
//    return Scaffold(
//        backgroundColor: Colors.black26,
//        body: Container(
//          child: Center(
//            child: Container(
//              width: largura * 0.8,
//              height: altura * 0.73,
//              child: Column(
//                children: [
//                  Stack(
//                    alignment: Alignment.topCenter,
//                    children: [
//                      Column(
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: [
//                          Container(
//                            width: largura * 0.8,
//                            height: (altura * 0.073),
//                            color: Colors.transparent,
//                          ),
//                          Container(
//                            width: largura * 0.8,
//                            height: (altura * 0.073),
//                            color: Colors.white,
//                          ),
//                        ],
//                      ),
//                      Stack(
//                        alignment: Alignment.center,
//                        children: [
//                          CircleAvatar(
//                            backgroundColor: Colors.red,
//                            radius: altura * 0.073,
//                          ),
//                          CircleAvatar(
//                            backgroundImage: NetworkImage(usuario.imagemUrl),
//                            radius: altura * 0.07,
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                  Container(
//                    padding: EdgeInsets.symmetric(
//                        vertical: altura * 0.02, horizontal: largura * 0.02),
//                    color: Colors.white,
//                    child: Column(
//                      children: [
//                        Text(
//                          '${usuario.nome}',
//                          textAlign: TextAlign.center,
//                          style: TextStyle(fontSize: 26),
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Text(
//                          'Tem certeza que deseja excluir ${usuario.nome} de sua agenda?',
//                          textAlign: TextAlign.center,
//                          style: TextStyle(
//                              fontWeight: FontWeight.bold,
//                              color: Colors.black54),
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          children: [
//                            RaisedButton(
//                              color: Colors.grey,
//                              shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(18.0),
//                                  side: BorderSide(color: Colors.grey)),
//                              child: Text(
//                                'Não',
//                                style: TextStyle(color: Colors.white),
//                              ),
//                              onPressed: () {
//                                setState(() {
//                                  popUp = Container();
//                                });
//
//                                ListaDeContatos.popUpOn = false;
//                              },
//                            ),
//                            RaisedButton(
//                              color: Colors.white,
//                              shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(18.0),
//                                  side: BorderSide(color: Colors.red)),
//                              child: Text(
//                                'Excluir',
//                                style: TextStyle(color: Colors.red),
//                              ),
//                              onPressed: () async {
//                                await removerContato(usuario, usuarioProvider);
//                                setState(() {
//                                  popUp = Container();
//                                });
//                                ListaDeContatos.popUpOn = false;
//                              },
//                            )
//                          ],
//                        ),
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ));
//  }
//
//  void mostrarPopUp(Usuario usuario) {
//    setState(() {
//      popUpOn = true;
//      popUp = PopUp(usuario);
//    });
//  }
//
//  Future<void> removerContato(
//      Usuario contato, UsuarioCRUD usuarioProvider) async {
//    await removerDesteUsuario(contato, usuarioProvider);
//    await removerDoOutroUsuario(contato, usuarioProvider);
//  }
//
//  Future removerDesteUsuario(
//      Usuario contato, UsuarioCRUD usuarioProvider) async {
//    List<dynamic> contatosIds = esteUsuario.contatos;
//    contatosIds.removeWhere((element) => element == contato.uid);
//    esteUsuario.setContatos(contatosIds);
//
//    List<dynamic> salvosIds = esteUsuario.usuariosSalvos;
//    esteUsuario.setUsuariosSalvos(salvosIds);
//    salvosIds.removeWhere((element) => element == contato.uid);
//
//    await usuarioProvider.updateUsuario(esteUsuario, esteUsuario.uid);
//
//    setState(() {
//      contatos.removeWhere((element) => element.uid == contato.uid);
//    });
//  }
//
//  Future removerDoOutroUsuario(
//      Usuario contato, UsuarioCRUD usuarioProvider) async {
//    List<dynamic> contatosIdsOutroUsuario = contato.contatos;
//    contatosIdsOutroUsuario
//        .removeWhere((element) => element == esteUsuario.uid);
//    contato.setContatos(contatosIdsOutroUsuario);
//    await usuarioProvider.updateUsuario(contato, contato.uid);
//  }
//}
