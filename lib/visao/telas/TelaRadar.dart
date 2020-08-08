//import 'dart:async';
//import 'dart:isolate';
//import 'dart:ui';
//import 'dart:math' as Math;
//
//import 'package:MeetBy/telas/TelaContatos.dart';
//import 'package:MeetBy/util/CalculadoraDeIdade.dart';
//import 'package:async/async.dart';
//import 'package:background_locator/background_locator.dart';
//import 'package:background_locator/location_dto.dart';
//import 'package:background_locator/location_settings.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:connectivity/connectivity.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_database/firebase_database.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:MeetBy/modelo/Usuario.dart';
//import 'package:MeetBy/util/UsuarioCRUD.dart';
//import 'package:location_permissions/location_permissions.dart';
//import 'package:provider/provider.dart';
//import 'package:geolocator/geolocator.dart';
//
//import 'TelaMeuPerfil.dart';
//
//class TelaRadar extends StatefulWidget {
//  static const String rota = '/telaRadar';
//
//  @override
//  _TelaRadarState createState() => _TelaRadarState();
//}
//
//class _TelaRadarState extends State<TelaRadar> {
//  Usuario esteUsuario;
//
//  //List<Usuario> usuarios = List<Usuario>();
//
//  UsuarioCRUD usuarioProvider;
//
//
//
//  bool ehPrimeiraVez = true;
//
//  Widget botaoPopUp;
//  bool popUpOn = false;
//  Widget popUp;
//
//  var fData1, fData2;
//
//  bool masculino = false, feminino = false, ambos = false;
//
//  var _streamController = StreamController<List<Usuario>>.broadcast();
//
//  Stream<List<Usuario>> get _usuariosRadarStream => _streamController.stream;
//
//  bool inicializado = false;
//  var subscription;
//
//  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//  TextEditingController controller = TextEditingController();
//
//  @override
//  void initState() {
//    super.initState();
//
//    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
//    port.listen((dynamic data) async {
//      localizacao = data;
//    });
//    initPlatformState();
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
//  @override
//  void dispose() {
//    _streamController.close();
//    subscription.cancel();
//    super.dispose();
//  }
//
//  updateUsuarios(List<Usuario> lista) {
//    _streamController.sink.add(lista);
//  }
//
//  Future<Stream<Event>> obterMinhaLocalizacao() async {
//    //print('1) obterMinhaLocalizacao');
//    return await FirebaseDatabase.instance
//        .reference()
//        .child('usuarios')
//        .child(esteUsuario.uid)
//        .onValue;
//  }
//
//  Future<void> atualizarEsteUsuario() async {
////    usuarioProvider.getUsuarioAsStream(esteUsuarioAtualizado.uid).listen(
////        (data1) {
////      print('listen 1');
////      esteUsuarioAtualizado = Usuario.fromMap(data1.data);
////      updateUsuarios([data1.data]);
////    }, onError: (erro) {
////      print('erro 12312 ${erro}');
////    }, onDone: () {
////      print('1321321 onDone');
////    });
//
//    await obterMinhaLocalizacao().then((value) {
//      value.listen((data) async {
//        Map usuarioRTDB = data.snapshot.value;
////        print('data1.data = ${data1.data}');
////        print('data1.data.keys = ${data1.data.keys}');
////        print('data1.data.values = ${data1.data.values}');
//
//        // List<Usuario> cheat = List<Usuario>();
//
////        print('usuario RTDB WRITEEEEEE 22222222222');
//        esteUsuario.setLatitude(usuarioRTDB['latitude'].toDouble());
//        esteUsuario.setLongitude(usuarioRTDB['longitude'].toDouble());
//        await obterListaTemporariaUsuariosDoFirestore();
////      print(
////          'esteUsuario => lat:${esteUsuario.latitude}, long: ${esteUsuario.longitude}');
//      }, onError: (erro) {
//        print('erro: ${erro}');
//      }, onDone: () {
//        print('StreamObterMinhaLocalizaçãoConcluida');
//      });
//    });
//
//    //print('2) atualizarEsteUsuario');
//  }
//
//  Future<Stream<Event>> obterUIDsUsuariosProximosRTDB() async {
//    //print('3)ObterUIDsUsuariosProximosRTDB');
//    return await FirebaseDatabase.instance
//        .reference()
//        .child('usuarios')
//        .orderByChild('latitude')
//        .startAt(
//          calcularLatitudeELongitude(esteUsuario, -100).first,
//        )
//        .endAt(
//          calcularLatitudeELongitude(esteUsuario, 100).first,
//        )
//        .onValue;
//  }
//
//  void obterListaTemporariaUsuariosDoFirestore() async {
//    List<Usuario> listaTemporaria = List<Usuario>();
//    await obterUIDsUsuariosProximosRTDB().then((value) {
//      value.listen((data) async {
//        Map usuariosFiltradosRTDB = data.snapshot.value;
//        if (usuariosFiltradosRTDB != null) {
//          await usuariosFiltradosRTDB.forEach((id, coordenadas) async {
//            if (id != esteUsuario.uid) {
////          print(
////              'EU: lat${esteUsuarioAtualizado.latitude}, long${esteUsuarioAtualizado.longitude}');
////          print(
////              'OUTRO: lat${coordenadas['latitude'].toDouble()}, long${coordenadas['longitude'].toDouble()}');
//              await estaPerto(
//                      esteUsuario.latitude,
//                      esteUsuario.longitude,
//                      coordenadas['latitude'].toDouble(),
//                      coordenadas['longitude'].toDouble())
//                  .then((estaPerto) async {
//                if (estaPerto) {
//                  await usuarioProvider.getUsuarioById(id).then((usuario) {
//                    listaTemporaria.add(usuario);
////                      print('add');
////                      print(id);
//                  });
////              await usuarioProvider.getUsuarioAsStream(id).listen((data) {
////                //print(data.data);
////                listaTemporaria.add(Usuario.fromMap(data.data));
////              });
//                }
//              });
//            }
//          });
//          if (!listaTemporaria.isEmpty) {
//            await obterListaUsuariosPerto(listaTemporaria);
//          }
//          listaTemporaria = List<Usuario>();
//        }
//      }, onDone: () {
//        print('on done');
//      }, onError: (erro) {
//        print('erro');
//      });
//    });
//
//    //print('4) obterListaTemporariaUsuariosDoFirestore');
//  }
//
//  Future<void> obterListaUsuariosPerto(List<Usuario> listaTemporaria) async {
//    List<Usuario> listaFinal = listaTemporaria;
//    //print('uid ${listaFinal.first.uid} visivel: ${listaFinal.first.visivel}');
//
//    if (listaFinal != null && listaFinal.isNotEmpty) {
//      listaFinal = await listaFinal.where((usuario) {
//        if (usuario != null) {
//          bool querVerMascEOutroEhMasc =
//              esteUsuario.sexoDoOutro == 'masculino' &&
//                  usuario.sexo == 'masculino';
//          bool querVerFemEOutraEhFem = esteUsuario.sexoDoOutro == 'feminino' &&
//              usuario.sexo == 'feminino';
//          bool querVerTodos = esteUsuario.sexoDoOutro == 'ambos';
//          bool checarDefinicoesGenero =
//              querVerMascEOutroEhMasc || querVerFemEOutraEhFem || querVerTodos;
//
//          bool estaVisivel = usuario.visivel;
//          bool naoEstaBloqueado =
//              !usuario.usuariosQueTeBloquearam.contains(esteUsuario.uid) &&
//                  !usuario.usuariosQueBloqueei.contains(esteUsuario.uid) &&
//                  !esteUsuario.usuariosQueTeBloquearam.contains(usuario.uid) &&
//                  !esteUsuario.usuariosQueBloqueei.contains(usuario);
//
//          return checarDefinicoesGenero && estaVisivel && naoEstaBloqueado;
//        } else {
//          return false;
//        }
//      }).toList();
//    }
//
////    if (listaFinal.isEmpty) {
////      print('************vazia');
////    } else {
////      print('tem gente');
////    }
//    //print('Lista final =====> ${listaFinal}');
//    //print('5) ObterListaUsuariosPerto');
//    //if(listaFinal)
//
//    if (!listaFinal.isEmpty) {
//      updateUsuarios(listaFinal.toSet().toList());
//    } else {
//      updateUsuarios(listaFinal.toSet().toList());
//    }
//  }
//
//  List<Usuario> fora = List<Usuario>();
//
//  @override
//  Widget build(BuildContext context) {
//    usuarioProvider = Provider.of<UsuarioCRUD>(context);
//    esteUsuario = ModalRoute.of(context).settings.arguments;
//
//    double largura = MediaQuery.of(context).size.width;
//    double altura = MediaQuery.of(context).size.height;
//    List<Usuario> lista = List<Usuario>();
//
//    if (!inicializado) {
//      atualizarEsteUsuario();
//      inicializado = true;
//    }
//
//    if (esteUsuario.visivel && ehPrimeiraVez) {
//      _iniciarGeolocator();
//      ehPrimeiraVez = false;
//    } else {
//      //_pararGeolocator();
//    }
//
//    return WillPopScope(
//      onWillPop: () async {
//        return false;
//      },
//      child: StreamBuilder(
//          stream: usuarioProvider.getUsuarioAsStream(esteUsuario.uid),
//          builder: (context, snapshotFirestore) {
//            if (snapshotFirestore.hasError) {
//            } else {
//              switch (snapshotFirestore.connectionState) {
//                case ConnectionState.none:
//                  print('ConnectionState.none');
//                  return Center(
//                    child: Text('teste 6'),
//                  );
//                  //return reload(largura, altura);
//                  break;
//                case ConnectionState.waiting:
//                  //print('ConnectionState.waiting');
//                  return Center(
//                    child: CircularProgressIndicator(),
//                  );
//                  //return reload(largura, altura);
//                  break;
//                case ConnectionState.done:
//                  print('ConnectionState.done');
//                  return Center(
//                    child: Text('teste 4'),
//                  );
//                  //return reload(largura, altura);
//                  break;
//                case ConnectionState.active:
//                  esteUsuario = Usuario.fromMap(snapshotFirestore.data.data);
//
//                  if (esteUsuario.sexoDoOutro == 'masculino') {
//                    masculino = true;
//                  } else if (esteUsuario.sexoDoOutro == 'feminino') {
//                    feminino = true;
//                  } else if (esteUsuario.sexoDoOutro == 'ambos') {
//                    ambos = true;
//                  }
//
//                  return Stack(
//                    children: [
//                      Scaffold(
//                          appBar: AppBar(
//                            backgroundColor: Colors.black,
//                            title: Text('Radar'),
//                            leading: IconButton(
//                              icon: ImageIcon(AssetImage(
//                                  'assets/images/icones_azul_Agenda.png')),
//                              onPressed: () {
////                    setState(() {
////                      isFirstTime = true;
////                    });
//
//                                Navigator.pushNamed(context, TelaContatos.rota);
//                              },
//                            ),
//                          ),
//                          endDrawer: SafeArea(
//                            child: Drawer(
//                              child: Container(
//                                padding: EdgeInsets.all(25),
//                                child: Column(
//                                  children: [
//                                    Container(
//                                      margin: EdgeInsets.only(left: 15),
//                                      child: Column(
//                                        children: [
//                                          Row(
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.start,
//                                            children: [
//                                              Text(
//                                                'Visibilidade',
//                                                style: TextStyle(
//                                                    fontSize: 20,
//                                                    fontWeight:
//                                                        FontWeight.bold),
//                                              ),
//                                              switchVisivel(),
//                                            ],
//                                          ),
//                                          SizedBox(
//                                            height: 40,
//                                          ),
//                                          Container(
//                                            width: double.infinity,
//                                            child: Text(
//                                              'Gênero',
//                                              style: TextStyle(
//                                                  fontSize: 20,
//                                                  fontWeight: FontWeight.bold),
//                                              textAlign: TextAlign.start,
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                    contruirEscolhaDeGenero(
//                                        usuarioProvider, esteUsuario),
//                                  ],
//                                ),
//                              ),
//                            ),
//                          ),
//                          body: Column(
//                            children: [
//                              SizedBox(
//                                height: 10,
//                              ),
//                              Image.network(
//                                'https://www.thiengo.com.br/img/post/normal/jth8tjfslfjg4n407o8no3vgt27854f0eac89f11571598553f57b0608c.jpg',
//                                height: 100,
//                                width: double.infinity,
//                                fit: BoxFit.cover,
//                              ),
//                              Container(
//                                child: Row(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceAround,
//                                  children: [
//                                    Container(width: 100, child: Container()
////                                      TextField(
////                                        controller: controller,
////                                        key: _formKey,
////                                        decoration: InputDecoration(
////                                            border: InputBorder.none,
////                                            hintText: 'Pesquisar'),
////                                      ),
//                                        ),
//                                    GestureDetector(
//                                      onTap: () {
//                                        Navigator.pushNamed(
//                                            context, TelaMeuPerfil.rota,
//                                            arguments: esteUsuario);
//                                      },
//                                      child: CircleAvatar(
//                                        backgroundImage:
//                                            NetworkImage(esteUsuario.imagemUrl),
//                                      ),
//                                    )
//                                  ],
//                                ),
//                              ),
//                              SizedBox(
//                                height: 10,
//                              ),
//                              StreamBuilder(
//                                  stream: _usuariosRadarStream,
//                                  builder: (context, snapshot) {
//                                    if (snapshot.hasError) {
//                                    } else {
//                                      switch (snapshot.connectionState) {
//                                        case ConnectionState.none:
//                                          print('ConnectionState.none');
//                                          return Center(
//                                            child: Text('teste 3'),
//                                          );
//                                          //return reload(largura, altura);
//                                          break;
//                                        case ConnectionState.waiting:
//                                          //print('ConnectionState.waiting');
//                                          return Center(
//                                              child:
//                                                  CircularProgressIndicator());
//                                          //return reload(largura, altura);
//                                          break;
//                                        case ConnectionState.done:
//                                          print('ConnectionState.done');
//                                          return Center(
//                                            child: Text('teste 1'),
//                                          );
//                                          //return reload(largura, altura);
//                                          break;
//                                        case ConnectionState.active:
////
//                                          lista = snapshot.data;
//
//                                          return snapshot.data.length == 0 ||
//                                                  !Usuario.fromMap(
//                                                          snapshotFirestore
//                                                              .data.data)
//                                                      .visivel
//                                              ? Center(
//                                                  child: esteUsuario.visivel ==
//                                                          false
//                                                      ? Column(
//                                                          children: [
//                                                            SizedBox(
//                                                              height: 30,
//                                                            ),
//                                                            Text(
//                                                              'Você está OFF',
//                                                              style: TextStyle(
//                                                                  fontSize: 30,
//                                                                  fontWeight:
//                                                                      FontWeight
//                                                                          .bold,
//                                                                  color: Colors
//                                                                      .black54),
//                                                            ),
//                                                            SizedBox(
//                                                              height: 30,
//                                                            ),
//                                                            switchVisivel(),
//                                                            SizedBox(
//                                                              height: 30,
//                                                            ),
//                                                            Container(
//                                                              padding:
//                                                                  EdgeInsets
//                                                                      .all(30),
//                                                              decoration:
//                                                                  BoxDecoration(
//                                                                border: Border.all(
//                                                                    color: Colors
//                                                                        .black,
//                                                                    width: 1),
//                                                                borderRadius: BorderRadius
//                                                                    .all(Radius
//                                                                        .circular(
//                                                                            30)),
//                                                              ),
//                                                              child: Column(
//                                                                children: [
//                                                                  Text('Aviso'),
//                                                                  SizedBox(
//                                                                    height: 10,
//                                                                  ),
//                                                                  Text(
//                                                                      'Você está invisível'),
//                                                                  Text(
//                                                                      'Fique visível para que sua busca'),
//                                                                  Text(
//                                                                      'fique ativa novamente'),
//                                                                ],
//                                                              ),
//                                                            ),
//                                                          ],
//                                                        )
//                                                      : Column(
//                                                          mainAxisAlignment:
//                                                              MainAxisAlignment
//                                                                  .spaceEvenly,
//                                                          children: [
//                                                            Container(
//                                                              width:
//                                                                  largura * 0.5,
//                                                              padding:
//                                                                  EdgeInsets
//                                                                      .all(20),
//                                                              child: Image(
//                                                                image: AssetImage(
//                                                                    'assets/images/desert.png'),
//                                                                color:
//                                                                    Colors.grey,
//                                                              ),
//                                                            ),
//                                                            Container(
//                                                              margin: EdgeInsets
//                                                                  .all(15),
//                                                              child: Text(
//                                                                'Ninguém aqui',
//                                                                textAlign:
//                                                                    TextAlign
//                                                                        .center,
//                                                                style: TextStyle(
//                                                                    color: Colors
//                                                                        .black54,
//                                                                    fontSize:
//                                                                        24),
//                                                              ),
//                                                            ),
//                                                          ],
//                                                        ),
//                                                )
//                                              : reload(largura, altura,
//                                                  esteUsuario, lista);
//
//                                          break;
//
//                                        default:
//                                      }
//                                    }
//                                  })
//                            ],
//                          )),
//                      StreamBuilder(
//                          stream: _usuariosRadarStream,
//                          builder: (context, snapshot) {
//                            return popUp ?? Container();
//                          }),
//                    ],
//                  );
//                  break;
//                default:
//              }
//            }
//          }),
//    );
//  }
//
//  Switch switchVisivel() {
//    return Switch(
//        value: esteUsuario.visivel,
//        onChanged: (visivelSwitch) async {
//          esteUsuario.setVisivel(visivelSwitch);
////            if (!estaVisivel) {
////              usuariosPerto.length = 0;
////            }
//
//          await usuarioProvider.updateUsuario(esteUsuario, esteUsuario.uid);
//          if (esteUsuario.visivel) {
//            _iniciarGeolocator();
//          } else {
//            _pararGeolocator();
//          }
//        });
//  }
//
//  Container reload(
//      double largura, double altura, Usuario eu, List<Usuario> usuariosPertos) {
//    return Container(
//        child: ListView.builder(
//      shrinkWrap: true,
//      itemBuilder: (_, i) {
//        return Card(
//          child: ListTile(
//            onTap: () {
//              mostrarPopUp(
//                  usuariosPertos[i], usuarioProvider, largura, altura, eu);
//            },
//            title: Text(usuariosPertos[i].nome),
//            leading: CircleAvatar(
//              backgroundImage: NetworkImage(usuariosPertos[i].imagemUrl),
//            ),
//            trailing: Row(
//              mainAxisSize: MainAxisSize.min,
//              children: [
//                FutureBuilder(
//                    future: definirBotaoAdicionar(usuariosPertos[i],
//                        usuarioProvider, largura, altura, eu),
//                    builder: (context, snapshot) {
//                      if (snapshot.hasData) {
//                        botaoPopUp = snapshot.data;
//                        if (popUpOn) {
//                          popUp = PopUp(usuariosPertos[i], usuarioProvider,
//                              largura, altura, eu);
//                        }
//                        fData1 = snapshot.data;
//                        return snapshot.data;
//                      } else {
//                        // print('xxxxxxxxxxxxx');
//                        return fData1 ?? Container();
//                      }
//                    }),
//                FutureBuilder(
//                    future: definirBotaoSalvar(
//                        usuariosPertos, i, usuarioProvider, largura, eu),
//                    builder: (context, snapshot) {
//                      if (snapshot.hasData) {
//                        fData2 = snapshot.data;
//                        return snapshot.data;
//                      } else {
//                        //print('yyyyyyyyyyyy');
//                        return fData2 ?? Container();
//                      }
//                    }),
//              ],
//            ),
//          ),
//        );
//      },
//      itemCount: usuariosPertos.length,
//    ));
//  }
//
//
//
//  Future<bool> estaPerto(double minhaLat, double minhaLong, double outroLat,
//      double outroLong) async {
//    double distanceInMeters = await Geolocator()
//        .distanceBetween(minhaLat, minhaLong, outroLat, outroLong);
//
//    return distanceInMeters <= 100;
//  }
//
////  _obterUsuarios(UsuarioCRUD usuarioProvider) {
////    return this._memoizer.runOnce(() async {
////      await future(usuarioProvider);
////      return 'ok';
////    });
////  }
//
////  Future<String> future(UsuarioCRUD usuarioProvider) async {
////    final FirebaseDatabase realTimeDB = FirebaseDatabase.instance;
////    DatabaseReference usuariosPertoRef;
////
////    if (isFirstTime) {
////      isFirstTime = false;
////
////      timerUpdate = Timer.periodic(Duration(seconds: 10), (Timer t) async {
////        await future(usuarioProvider);
////      });
////    }
////
////    if (esteUsuario.sexoDoOutro == 'masculino') {
////      masculino = true;
////    } else if (esteUsuario.sexoDoOutro == 'feminino') {
////      feminino = true;
////    } else if (esteUsuario.sexoDoOutro == 'ambos') {
////      ambos = true;
////    }
////
////    estaVisivel = esteUsuario.visivel;
////    if (estaVisivel) {
////      _iniciarGeolocator();
////    } else {
////      //_pararGeolocator();
////    }
////
////    await realTimeDB
////        .reference()
////        .child('usuarios')
////        .child(esteUsuario.uid)
////        .once()
////        .then((DataSnapshot dataSnapshot) {
////      Map map = dataSnapshot.value;
////      esteUsuario.setLatitude(map['latitude'].toDouble());
////      esteUsuario.setLongitude(map['longitude'].toDouble());
////    });
////    usuariosPertoRef = await realTimeDB
////        .reference()
////        .child('usuarios')
////        .orderByChild('latitude')
////        .startAt(
////          calcularLatitudeELongitude(esteUsuario, -100).first,
////        )
////        .endAt(
////          calcularLatitudeELongitude(esteUsuario, 100).first,
////        )
////        .once()
////        .then((DataSnapshot dataSnapshot) {
////      Map map = dataSnapshot.value;
////      if (map.length == 1) {
////        setState(() {
////          usuarios = List<Usuario>();
////        });
////      }
////      print('map = ${map}');
////      List<Usuario> usuariosTemp = List<Usuario>();
////      map.forEach((id, coordenadas) async {
////        if (id != esteUsuario.uid) {
////          print('este usuario lat ${esteUsuario.latitude}');
////          print('este usuario long ${esteUsuario.longitude}');
////
////          await estaPerto(
////                  esteUsuario.latitude,
////                  esteUsuario.longitude,
////                  coordenadas['latitude'].toDouble(),
////                  coordenadas['longitude'].toDouble())
////              .then((estaPerto) async {
////            if (estaPerto) {
////              await usuarioProvider.getUsuarioById(id).then((usuarioPerto) {
////                bool querVerMascEOutroEhMasc =
////                    esteUsuario.sexoDoOutro == 'masculino' &&
////                        usuarioPerto.sexo == 'masculino';
////                bool querVerFemEOutraEhFem =
////                    esteUsuario.sexoDoOutro == 'feminino' &&
////                        usuarioPerto.sexo == 'feminino';
////                bool querVerTodos = esteUsuario.sexoDoOutro == 'ambos';
////
////                if (querVerMascEOutroEhMasc ||
////                    querVerFemEOutraEhFem ||
////                    querVerTodos) {
////                  if (usuarioPerto.visivel) {
////                    if (!usuarioPerto.usuariosQueTeBloquearam
////                            .contains(esteUsuario.uid) &&
////                        !usuarioPerto.usuariosQueBloqueei
////                            .contains(esteUsuario.uid) &&
////                        !esteUsuario.usuariosQueTeBloquearam
////                            .contains(usuarioPerto.uid) &&
////                        !esteUsuario.usuariosQueBloqueei
////                            .contains(usuarioPerto)) {
////                      usuarioPerto
////                          .setLatitude(coordenadas['latitude'].toDouble());
////                      usuarioPerto
////                          .setLongitude(coordenadas['longitude'].toDouble());
////                      usuariosTemp.add(usuarioPerto);
////                    }
////                  }
////                }
////              }).then((_) {
////                setState(() {
////                  if (estaVisivel) {
////                    usuarios = usuariosTemp;
////                  } else {
////                    usuarios = List<Usuario>();
////                  }
////                });
////              });
////            }
////          });
////        }
////      });
////    });
////
////    return 'ok';
////  }
//
//  Column contruirEscolhaDeGenero(
//      UsuarioCRUD usuarioProvider, Usuario esteUsuario) {
//    return Column(
//      children: [
//        Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: [
//            Checkbox(
//                value: feminino,
//                onChanged: (value) async {
//                  if (!feminino) {
//                    ambos = false;
//                    feminino = true;
//                    esteUsuario.setSexoDoOutro('feminino');
//                  } else {
//                    feminino = false;
//                    esteUsuario.setSexoDoOutro('nenhum');
//                    esteUsuario.setVisivel(false);
//                  }
//
//                  if (masculino && feminino) {
//                    masculino = false;
//                    feminino = false;
//                    ambos = true;
//                    esteUsuario.setSexoDoOutro('ambos');
//                  }
//
//                  await usuarioProvider.updateUsuario(
//                      esteUsuario, esteUsuario.uid);
//                }),
//            Text('Feminino'),
//          ],
//        ),
//        Row(
//          children: [
//            Checkbox(
//                value: masculino,
//                onChanged: (value) async {
//                  if (!masculino) {
//                    ambos = false;
//                    masculino = true;
//                    esteUsuario.setSexoDoOutro('masculino');
//                  } else {
//                    masculino = false;
//                    esteUsuario.setSexoDoOutro('nenhum');
//                    esteUsuario.setVisivel(false);
//                  }
//
//                  if (masculino && feminino) {
//                    masculino = false;
//                    feminino = false;
//                    ambos = true;
//                    esteUsuario.setSexoDoOutro('ambos');
//                  }
//
//                  await usuarioProvider.updateUsuario(
//                      esteUsuario, esteUsuario.uid);
//                }),
//            Text('Masculino'),
//          ],
//        ),
//        Row(
//          children: [
//            Checkbox(
//                value: ambos,
//                onChanged: (value) async {
//                  if (ambos) {
//                    ambos = false;
//                    esteUsuario.setSexoDoOutro('nenhum');
//                    esteUsuario.setVisivel(false);
//                  } else {
//                    ambos = true;
//                    esteUsuario.setSexoDoOutro('ambos');
//                  }
//
//                  if (masculino) {
//                    masculino = false;
//                  } else if (feminino) {
//                    feminino = false;
//                  }
//
//                  await usuarioProvider.updateUsuario(
//                      esteUsuario, esteUsuario.uid);
//                }),
//            Text('Ambos'),
//          ],
//        )
//      ],
//    );
//  }
//
//  void construirRegrasDosCheckboxes() {
//    if (masculino && feminino) {
//      setState(() {
//        feminino = false;
//        ambos = false;
//      });
//    }
//    if (feminino) {
//      setState(() {
//        masculino = false;
//        ambos = false;
//      });
//    }
//    if (ambos) {
//      setState(() {
//        masculino = false;
//        feminino = false;
//      });
//    }
//  }
//
//  Future<Widget> definirBotaoAdicionar(
//      Usuario usuario,
//      UsuarioCRUD usuarioProvider,
//      double largura,
//      double altura,
//      Usuario eu) async {
//    if (eu.solicitacoesFeitas.contains(usuario.uid)) {
//      return largura > 330
//          ? RaisedButton(
//              color: Colors.white,
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(18.0),
//                  side: BorderSide(color: Colors.red)),
//              child: Text(
//                'Cancelar solicitação',
//                style: TextStyle(color: Colors.red),
//              ),
//              onPressed: () {
//                cancelarSolicitacao(usuario, usuarioProvider, eu);
//              },
//            )
//          : RaisedButton(
//              color: Colors.white,
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(18.0),
//                  side: BorderSide(color: Colors.red)),
//              child: Text(
//                'Cancelar',
//                style: TextStyle(color: Colors.red),
//              ),
//              onPressed: () {
//                cancelarSolicitacao(usuario, usuarioProvider, eu);
//              },
//            );
//    } else if (eu.solicitacoesRecebidas.contains(usuario.uid)) {
//      return Container(
//        child: FlatButton(
//          child: Text('Responder'),
//          onPressed: () {
//            mostrarPopUp(usuario, usuarioProvider, largura, altura, eu);
//          },
//        ),
//      );
//    } else if (eu.contatos.contains(usuario.uid)) {
//      return Container(
//        child: Text(
//          'Seu contato',
//          style: TextStyle(color: Color(0xff058BC6), fontWeight: FontWeight.bold),
//        ),
//      );
//    } else {
//      return ButtonTheme(
//        minWidth: 50,
//        height: 30,
//        child: RaisedButton(
//          color: Color(0xff058BC6),
//          shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(18.0),
//              side: BorderSide(color: Color(0xff058BC6))),
//          child: Text(
//            'Add',
//            style: TextStyle(color: Colors.white),
//          ),
//          onPressed: () async {
//            await adicionarUsuario(usuario, usuarioProvider, eu);
//          },
//        ),
//      );
//    }
//  }
//
//  Future<Widget> definirBotaoAdicionarPopUp(
//      Usuario usuario,
//      UsuarioCRUD usuarioProvider,
//      double largura,
//      double altura,
//      Usuario eu) async {
//    if (eu.solicitacoesFeitas.contains(usuario.uid)) {
//      return Container(
//        child: Column(
//          children: [
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: [
//                Text(
//                  'Status: ',
//                ),
//                Text(
//                  'Pendente',
//                  style: TextStyle(
//                      color: Colors.amber, fontWeight: FontWeight.bold),
//                ),
//              ],
//            ),
//            SizedBox(
//              height: 10,
//            ),
//            RaisedButton(
//              color: Colors.white,
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(18.0),
//                  side: BorderSide(color: Colors.red)),
//              child: Text(
//                'Cancelar solicitação',
//                style: TextStyle(color: Colors.red),
//              ),
//              onPressed: () async {
//                await cancelarSolicitacao(usuario, usuarioProvider, eu);
//                mostrarPopUp(usuario, usuarioProvider, largura, altura, eu);
//              },
//            ),
//          ],
//        ),
//      );
//    } else if (eu.solicitacoesRecebidas.contains(usuario.uid)) {
//      return Container(
//        child: Column(
//          children: [
//            RaisedButton(
//              color: Color(0xff058BC6),
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(18.0),
//                  side: BorderSide(color: Color(0xff058BC6))),
//              child: Text(
//                'Aceitar',
//                style: TextStyle(color: Colors.white),
//              ),
//              onPressed: () {
//                aceitarSolicitacao(usuario, usuarioProvider, eu);
//                setState(() {
//                  popUp = Container();
//                  popUpOn = false;
//                });
//              },
//            ),
//            RaisedButton(
//              color: Colors.white,
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(18.0),
//                  side: BorderSide(color: Colors.red)),
//              child: Text(
//                'Recusar',
//                style: TextStyle(color: Colors.red),
//              ),
//              onPressed: () {
//                rejeitarSolicitacao(usuario, usuarioProvider, eu);
//                setState(() {
//                  popUp = Container();
//                  popUpOn = false;
//                });
//              },
//            ),
//            RaisedButton(
//              color: Colors.white,
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(18.0),
//                  side: BorderSide(color: Colors.grey)),
//              child: Text(
//                'Bloquear',
//                style: TextStyle(color: Colors.grey),
//              ),
//              onPressed: () {
//                bloquearUsuario(usuario, usuarioProvider, eu);
//                popUp = Container();
//                popUpOn = false;
//                setState(() {});
//              },
//            ),
//          ],
//        ),
//      );
//    } else if (eu.contatos.contains(usuario.uid)) {
//      return Container(
//        child: Text(
//          'Seu contato',
//          style: TextStyle(color: Color(0xff058BC6), fontWeight: FontWeight.bold),
//        ),
//      );
//    } else {
//      return Container(
//        child: RaisedButton(
//          color: Color(0xff058BC6),
//          shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(18.0),
//              side: BorderSide(color: Color(0xff058BC6))),
//          child: Text(
//            'Enviar solicitação',
//            style: TextStyle(color: Colors.white),
//          ),
//          onPressed: () async {
//            await adicionarUsuario(usuario, usuarioProvider, eu);
//            mostrarPopUp(usuario, usuarioProvider, largura, altura, eu);
//          },
//        ),
//      );
//    }
//  }
//
//  Future<Widget> definirBotaoSalvar(List<Usuario> usuarios, int i,
//      UsuarioCRUD usuarioProvider, double width, Usuario esteUsuario) async {
//    if (esteUsuario.usuariosSalvos.contains(usuarios[i].uid) &&
//        !esteUsuario.solicitacoesFeitas.contains(usuarios[i].uid) &&
//        !esteUsuario.solicitacoesRecebidas.contains(usuarios[i].uid)) {
//      return IconButton(
//        icon: Icon(Icons.bookmark),
//        onPressed: () {
//          removerUsuarioSalvo(usuarios[i], usuarioProvider, esteUsuario);
//        },
//      );
//    } else if (esteUsuario.usuariosSalvos.contains(usuarios[i].uid) &&
//        esteUsuario.solicitacoesFeitas.contains(usuarios[i].uid)) {
//      return Container();
//    } else if (esteUsuario.contatos.contains(usuarios[i].uid) ||
//        esteUsuario.solicitacoesFeitas.contains(usuarios[i].uid) ||
//        esteUsuario.solicitacoesRecebidas.contains(usuarios[i].uid)) {
//      return Container();
//    } else {
//      return IconButton(
//        icon: Icon(Icons.bookmark_border),
//        onPressed: () {
//          salvarUsuario(usuarios[i], usuarioProvider, esteUsuario);
//        },
//      );
//    }
//  }
//
//  void logout() async {
//    await FirebaseAuth.instance.signOut();
//    Navigator.pushNamed(context, '/');
//  }
//
//  void adicionarUsuario(Usuario novoContato, UsuarioCRUD usuarioProvider,
//      Usuario esteUsuario) async {
//    List<dynamic> solicitacoesFeitas = esteUsuario.solicitacoesFeitas;
//
//    solicitacoesFeitas.add(novoContato.uid);
//
//    esteUsuario.setSolicitacoesFeitas(solicitacoesFeitas);
//
//    await usuarioProvider.updateUsuario(esteUsuario, esteUsuario.uid);
//
//    atualizarUsuarioAdicionado(novoContato, usuarioProvider, esteUsuario);
//  }
//
//  Future<void> atualizarUsuarioAdicionado(Usuario novoContato,
//      UsuarioCRUD usuarioProvider, Usuario esteUsuario) async {
//    List<dynamic> solicitacoesRecebidas = novoContato.solicitacoesRecebidas;
//
//    solicitacoesRecebidas.add(esteUsuario.uid);
//    novoContato.setSolicitacoesRecebidas(solicitacoesRecebidas);
//
//    Firestore db = Firestore.instance;
//    db
//        .collection('usuarios')
//        .document(novoContato.uid)
//        .collection('notifications')
//        .add({
//      'message': '${esteUsuario.nome} adicionou você',
//      'title': 'Nova solicitação de amizade',
//      'date': FieldValue.serverTimestamp(),
//    });
//
//    await usuarioProvider.updateUsuario(novoContato, novoContato.uid);
//  }
//
//  void cancelarSolicitacao(Usuario usuarioCancelado,
//      UsuarioCRUD usuarioProvider, Usuario esteUsuario) async {
//    List<dynamic> solicitacoesFeitas = esteUsuario.solicitacoesFeitas;
//
//    solicitacoesFeitas
//        .removeWhere((element) => element == usuarioCancelado.uid);
//
//    esteUsuario.setSolicitacoesFeitas(solicitacoesFeitas);
//
//    await usuarioProvider.updateUsuario(esteUsuario, esteUsuario.uid);
//
//    atualizarUsuarioCancelado(usuarioCancelado, usuarioProvider, esteUsuario);
//  }
//
//  Future<void> atualizarUsuarioCancelado(Usuario usuarioCancelado,
//      UsuarioCRUD usuarioProvider, Usuario esteUsuario) async {
//    List<dynamic> solicitacoesRecebidas =
//        usuarioCancelado.solicitacoesRecebidas;
//
//    solicitacoesRecebidas.removeWhere((element) => element == esteUsuario.uid);
//    usuarioCancelado.setSolicitacoesRecebidas(solicitacoesRecebidas);
//    await usuarioProvider.updateUsuario(usuarioCancelado, usuarioCancelado.uid);
//  }
//
//  Future<void> salvarUsuario(Usuario usuarioQueVaiSerSalvo,
//      UsuarioCRUD usuarioProvider, Usuario esteUsuario) async {
//    List<dynamic> usuariosSalvos = esteUsuario.usuariosSalvos;
//
//    usuariosSalvos.add(usuarioQueVaiSerSalvo.uid);
//    esteUsuario.setUsuariosSalvos(usuariosSalvos);
//    await usuarioProvider.updateUsuario(esteUsuario, esteUsuario.uid);
//  }
//
//  Future<void> removerUsuarioSalvo(Usuario usuarioSalvoQueVaiSerRemovido,
//      UsuarioCRUD usuarioProvider, Usuario esteUsuario) async {
//    List<dynamic> usuariosSalvos = esteUsuario.usuariosSalvos;
//
//    usuariosSalvos
//        .removeWhere((element) => element == usuarioSalvoQueVaiSerRemovido.uid);
//    esteUsuario.setUsuariosSalvos(usuariosSalvos);
//    await usuarioProvider.updateUsuario(esteUsuario, esteUsuario.uid);
//  }
//
//  Widget PopUp(
//    Usuario usuario,
//    UsuarioCRUD usuarioProvider,
//    double largura,
//    double altura,
//    Usuario eu,
//  ) {
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
//                            backgroundColor: Colors.white,
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
//                    width: largura * 0.8,
//                    padding: EdgeInsets.symmetric(
//                        vertical: altura * 0.02, horizontal: largura * 0.02),
//                    color: Colors.white,
//                    child: Column(
//                      children: [
//                        usuario.mostrarIdade
//                            ? Text(
//                                '${usuario.nome}, ${CalculadoraDeIdade.obterIdade(usuario.dataDeNascimento)}',
//                                textAlign: TextAlign.center,
//                                style: TextStyle(fontSize: 26),
//                              )
//                            : Text(
//                                '${usuario.nome}',
//                                textAlign: TextAlign.center,
//                                style: TextStyle(fontSize: 26),
//                              ),
//                        Text('${usuario.profissao}'),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Text('${usuario.bio ?? '...'}'),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        FutureBuilder(
//                          future: definirBotaoAdicionarPopUp(
//                              usuario, usuarioProvider, largura, altura, eu),
//                          builder: (context, snapshot) {
//                            if (snapshot.hasData) {
//                              return snapshot.data;
//                            } else {
//                              return CircularProgressIndicator();
//                            }
//                          },
//                        ),
//                      ],
//                    ),
//                  ),
//                  Stack(
//                    alignment: Alignment.bottomCenter,
//                    children: [
//                      Column(
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: [
//                          Container(
//                            width: largura * 0.8,
//                            height: (altura * 0.1),
//                            color: Colors.transparent,
//                          ),
//                          Container(
//                            width: largura * 0.8,
//                            height: (altura * 0.1),
//                            color: Colors.transparent,
//                          ),
//                        ],
//                      ),
//                      GestureDetector(
//                        child: Container(
//                          width: 70,
//                          height: 70,
//                          child: Center(
//                              child: Text(
//                            'x',
//                            style: TextStyle(
//                                fontWeight: FontWeight.w200, fontSize: 36),
//                          )),
//                          decoration: BoxDecoration(
//                              shape: BoxShape.circle, color: Colors.white),
//                        ),
//                        onTap: () {
//                          setState(() {
//                            popUp = Container();
//                            popUpOn = false;
//                          });
//                        },
//                      ),
//                    ],
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ));
//  }
//
//  void mostrarPopUp(Usuario usuario, UsuarioCRUD usuarioProvider,
//      double largura, double altura, Usuario eu) {
//    setState(() {
//      popUpOn = true;
//      popUp = PopUp(usuario, usuarioProvider, largura, altura, eu);
//    });
//  }
//
//  Future<void> aceitarSolicitacao(Usuario usuarioQueSeraAceito,
//      UsuarioCRUD usuarioProvider, Usuario eu) async {
//    await aceitacaoEsteUsuario(usuarioQueSeraAceito, usuarioProvider, eu);
//
//    await aceitacaoOutroUsuario(usuarioQueSeraAceito, usuarioProvider, eu);
//  }
//
//  Future aceitacaoEsteUsuario(Usuario usuarioQueSeraAceito,
//      UsuarioCRUD usuarioProvider, Usuario esteUsuario) async {
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
////    setState(() {
////      solicitacoesRecebidas
////          .removeWhere((element) => element.uid == usuarioQueSeraAceito.uid);
////    });
//  }
//
//  Future aceitacaoOutroUsuario(Usuario usuarioQueSeraAceito,
//      UsuarioCRUD usuarioProvider, Usuario esteUsuario) async {
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
//  Future<void> rejeitarSolicitacao(Usuario usuarioQueSeraRejeitado,
//      UsuarioCRUD usuarioProvider, Usuario esteUsuario) async {
//    await rejeicaoEsteUsuario(
//        usuarioQueSeraRejeitado, usuarioProvider, esteUsuario);
//
//    await rejeicaoOutroUsuario(
//        usuarioQueSeraRejeitado, usuarioProvider, esteUsuario);
//  }
//
//  Future rejeicaoEsteUsuario(Usuario usuarioQueSeraRejeitado,
//      UsuarioCRUD usuarioProvider, Usuario esteUsuario) async {
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
////    setState(() {
////      solicitacoesRecebidas
////          .removeWhere((element) => element.uid == usuarioQueSeraRejeitado.uid);
////    });
//  }
//
//  Future rejeicaoOutroUsuario(Usuario usuarioQueSeraRejeitado,
//      UsuarioCRUD usuarioProvider, Usuario esteUsuario) async {
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
//  Future<void> bloquearUsuario(Usuario usuarioBlock,
//      UsuarioCRUD usuarioProvider, Usuario esteUsuario) async {
//    await atualizarEsteUsuarioBlock(usuarioBlock, usuarioProvider, esteUsuario);
//
//    await atualizarOutroUsuarioBlock(
//        usuarioBlock, usuarioProvider, esteUsuario);
//  }
//
//  Future atualizarEsteUsuarioBlock(Usuario usuarioBlock,
//      UsuarioCRUD usuarioProvider, Usuario esteUsuario) async {
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
//  }
//
//  Future atualizarOutroUsuarioBlock(Usuario usuarioBlock,
//      UsuarioCRUD usuarioProvider, Usuario esteUsuario) async {
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
//
//  List<double> calcularLatitudeELongitude(
//      Usuario eu, double distanciaEmMetros) {
//    double coef = distanciaEmMetros * 0.0000089;
//    double latitude = eu.latitude + coef;
//    double longitude = eu.longitude + coef / Math.cos(eu.latitude * 0.018);
//
//    return [latitude, longitude].toList();
//  }
//}
