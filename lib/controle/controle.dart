import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:meby/modelo/Usuario.dart';
import 'package:meby/repositorio/facebook.dart';
import 'package:meby/repositorio/firebase.dart';
import 'package:meby/repositorio/google.dart';
import 'package:meby/services/dynamic_links/dynamic_link_service.dart';
import 'package:meby/util/StreamFirestore.dart';
import 'package:meby/util/StreamRTDB.dart';
import 'package:meby/visao/telas/TelaContatos2.dart';
import 'package:meby/visao/telas/TelaMeuPerfil2.dart';
import 'package:meby/visao/telas/TelaRadar2.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastroDataDeNascimento.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastroFoto.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastroNome.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastroProfissao.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastroRedesSociais.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastroSexo.dart';
import 'package:meby/visao/telas/login/TelaLogin.dart';
import 'package:connectivity/connectivity.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:share/share.dart';

import 'tela_editar_usuario_controle.dart';

class Controle extends GetxController {
  static Controle get to => Get.find();
  GetStorage getStorage = GetStorage();

  bool semInternet = false;

  bool isUserEmailVerified = false;

  //suporte
  List<bool> mostrar = List<bool>();

  //Controle streams

  List<StreamFirestore> usuariosStreamFirestore = List<StreamFirestore>();
  StreamRTDB streamRTDBMinhaLocalizacao;
  StreamRTDB streamRTDBUsuariosPerto;

  Firebase firebase = Firebase();
  Facebook facebook = Facebook();
  Google google = Google();

  String uid;
  List<String> uidsPerto = List<String>();

  List<Usuario> todosUsuarios = List<Usuario>();
  List<Usuario> contatos = List<Usuario>();
  List<Usuario> usuariosPerto = List<Usuario>();

  List<Usuario> contatosPendentes = List<Usuario>();

  TelaEditarUsuarioControle telaEditarUsuarioControle;

  DynamicLinkService dynamicLinkService = DynamicLinkService();

  var conectividadeListener;

  //Tela Login
  String botaoLoadingLogin = 'Entrar';
  bool multipleClickGoogle = false;
  bool multipleClickFace = false;

  //Tela Cadastro
  bool esconderSenhaCadastro = true;
  bool esconderConfSenhaCadastro = true;
  String botaoLoadingCadastro = 'Continuar';

  //Tela Cadastro Nome
  TextEditingController nomeTextController;

  //Tela Cadastro Profissão
  TextEditingController profissaoTextController;

  //Tela Cadastro BIO
  TextEditingController bioTextController;

  //Tela suporte
  int telaSuporteEscolhida = 0;

  //Tela cadastro sexo
  Color botaoFemininoCorFundo = Colors.white;
  Color botaoMasculinoCorFundo = Colors.white;
  Color botaoFemininoCorTexto = Color(0xff989898);
  Color botaoMasculinoCorTexto = Color(0xff989898);

  //Tela cadastro foto
  File imagem;
  double progressPercent;
  var colunaConfirmada;
  bool controleFoto = false;

  //Tela cadastro redes sociais
  String instagram = 'i';
  String fb = 'f';
  String email = 'e';
  String whatsapp = 'w';
  String twitter = 't';
  String linkedin = 'l';
  String youtube = 'y';
  String spotify = 's';

  final instagramTextController = TextEditingController();
  final facebookTextController = TextEditingController();
  final whatsappTextController = TextEditingController();
  final twitterTextController = TextEditingController();
  final linkedinTextController = TextEditingController();
  final youtubeTextController = TextEditingController();
  final spotifyTextController = TextEditingController();
  final tiktokTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();

  //Tela meu perfil
  int selectedIndex = 0;
  int solicitacoesIndex = 0;

  //Tela Radar
  var geolocator = Geolocator();
  var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.best, distanceFilter: 0);
  StreamSubscription<Position> positionStream;

  //LocationDto localizacao;
  //DateTime ultimaVezQueFoiVisto;
  //bool geolocatorIsRunning = false;
  //static const String isolateName = "LocatorIsolate";
  //ReceivePort port = ReceivePort();
  //final AsyncMemoizer memoizer = AsyncMemoizer();

  bool masculino = false, feminino = false, ambos = false;

  //Tela contatos
  bool pesquisarOn = false;
  String textoPesquisa;

  //Notifications
  var initializationSettingsAndroid;
  var initializationSettingsIOS;
  var initializationSettings;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() async {
    dynamicLinkService.handleDynamicLinks();
    inicializarNotificacoes();
    await getStorage.initStorage;

    firebase.getUser().then((firebaseUser) async {
      if (firebaseUser == null) {
        Timer(Duration(seconds: 2), () {
          Get.off(TelaLogin());
        });

        print('deslogado');
      } else {
        setUID(firebaseUser.uid);
        await prepararParaLogin();
        print(uid);
        //Get.off(TelaContatos2());
      }
    });

    mostrar = [
      false,
      false,
      false,
      false,
      false,
      false,
    ];

    super.onInit();
  }

  @override
  void onClose() {
//    for (StreamFirestore sf in usuariosStreamFirestore) {
//      sf.cancelarStream();
//    }
//    streamRTDBMinhaLocalizacao.cancelarStream();
//    streamRTDBUsuariosPerto.cancelarStream();
    super.onClose();
  }

  Future<void> prepararParaLogin({String nome, String email}) async {
    bool usuarioEstaCadastrado =
        await Controle.to.firebase.usuarioEstaCadastrado(Controle.to.uid);

    final fcmToken = await Controle.to.firebase.getToken();

    if (usuarioEstaCadastrado) {
      await Controle.to.firebase.obterUsuarioByID(Controle.to.uid);
    }
    await Controle.to.firebase.getUsuarioStreamFirestore(Controle.to.uid);

    Usuario u = usuarioById(Controle.to.uid);

    if (u != null) {
      Controle.to.usuarioById(Controle.to.uid).setFcmToken(fcmToken);

      await Controle.to.updateUsuario(
          Controle.to.uid, Controle.to.usuarioById(Controle.to.uid));

      verificarEtapaCadastro();
    } else {
      emailTextController.text = email;
      await Controle.to.criarUsuario(
          Controle.to.uid,
          Usuario(
                  uid: Controle.to.uid,
                  fcmToken: fcmToken,
                  tutorialBusca: true,
                  primeiroContato: true,
                  cadastro: true,
                  nome: nome,
                  email: email)
              .toMap());
      //TODO: mudar nome do método
      await Controle.to.firebase.obterUsuarioByID(Controle.to.uid);

      await Controle.to.firebase.getUsuarioStreamFirestore(Controle.to.uid);
      //await Controle.to.obterMeuUsuario();
      Get.off(TelaCadastroNome());
    }
  }

  Future<void> prepararParaLoginEmail(String email) async {
    bool usuarioEstaCadastrado =
        await Controle.to.firebase.usuarioEstaCadastrado(Controle.to.uid);

    final fcmToken = await Controle.to.firebase.getToken();
    emailTextController.text = email;
    if (usuarioEstaCadastrado) {
      await Controle.to.firebase.getUsuarioStreamFirestore(Controle.to.uid);
      await Controle.to.firebase.obterUsuarioByID(Controle.to.uid);
    }

    Usuario u = usuarioById(Controle.to.uid);
    botaoLoadingLogin = 'Entrar';
    update();
    if (u != null) {
      Controle.to.usuarioById(Controle.to.uid).setFcmToken(fcmToken);
      await Controle.to.updateUsuario(
          Controle.to.uid, Controle.to.usuarioById(Controle.to.uid));

      verificarEtapaCadastro();
    } else {
      Get.defaultDialog(
          title: 'Ops...',
          middleText: 'Procuramos aqui e não encontramos o seu cadastro.');
    }
  }

  void verificarEtapaCadastro() {
    if (Controle.to.usuarioById(Controle.to.uid).nome == null) {
      Get.off(TelaCadastroNome());
    } else if (Controle.to.usuarioById(Controle.to.uid).sexo == null) {
      Get.off(TelaCadastroSexo());
    } else if (Controle.to.usuarioById(Controle.to.uid).dataDeNascimento ==
        null) {
      Get.off(TelaCadastroDataDeNascimento());
    } else if (Controle.to.usuarioById(Controle.to.uid).profissao == null) {
      Get.off(TelaCadastroProfissao());
    } else if (Controle.to.usuarioById(Controle.to.uid).imagemUrl == null) {
      Get.off(TelaCadastroFoto());
    } else if (Controle.to.usuarioById(Controle.to.uid).whatsapp == null) {
      Get.off(TelaCadastroRedesSociais());
    } else {
      Get.off(TelaContatos2());
    }
  }

  void setProgressPercent(double valor) {
    progressPercent = valor;
  }

  void setImagem(File image) {
    imagem = image;
  }

  void setBotaoFemCorFundo(Color color) {
    botaoFemininoCorFundo = color;
    update();
  }

  Usuario usuarioById(String id) {
    Usuario usuario;
    if (todosUsuarios.isNotEmpty) {
      try {
        usuario = todosUsuarios.firstWhere((u) => u.uid == id);
      } catch (e) {
        print(e.toString());
      }
      return usuario;
    } else {
      return null;
    }
  }

  void atualizarUsuarioFirestore(Usuario atualizado) {
    todosUsuarios.removeWhere((u) => u.uid == atualizado.uid);
    todosUsuarios.add(atualizado);

    usuarioById(atualizado.uid).setLatitude(atualizado.latitude);
    usuarioById(atualizado.uid).setLongitude(atualizado.longitude);
    update();
  }

  void setBotaoMascCorFundo(Color color) {
    botaoMasculinoCorFundo = color;
    update();
  }

  void setBotaoFemCorTexto(Color color) {
    botaoFemininoCorTexto = color;
    update();
  }

  void setBotaoMascCorTexto(Color color) {
    botaoMasculinoCorTexto = color;
    update();
  }

  void inicializarNotificacoes() {
    firebase.messaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        if (Controle.to.uid == null) {
          final user = await Controle.to.firebase.getUser();
          if (user != null) {
            Controle.to.setUID(user.uid);
          }
        }

        if (Controle.to.uid != null) {
          Map notification = message['notification'];
          showSimpleNotification(
            Text('${notification['title']}, ${notification['body']}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            position: NotificationPosition.bottom,
            background: Color(0xff058BC6),
            duration: Duration(seconds: 5),
            elevation: 10,
          );
        }
        print('111111');
      },
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print('2222222');
        if (Controle.to.uid == null) {
          final user = await Controle.to.firebase.getUser();
          if (user != null) {
            Controle.to.setUID(user.uid);
          }
        }

        if (Controle.to.uid != null) {
          Get.to(TelaMeuPerfil2(
            fromShare: true,
          ));
        }
      },
      onResume: (Map<String, dynamic> message) async {
        print('3333333333');
        if (Controle.to.uid == null) {
          final user = await Controle.to.firebase.getUser();
          if (user != null) {
            Controle.to.setUID(user.uid);
          }
        }

        if (Controle.to.uid != null) {
          Get.to(TelaMeuPerfil2(
            fromShare: true,
          ));
        }
      },
    );

    if (Platform.isIOS) {
      firebase.messaging.requestNotificationPermissions(
        const IosNotificationSettings(
            alert: true, badge: true, provisional: false, sound: true),
      );
    }

    initializationSettingsAndroid =
        new AndroidInitializationSettings('ic_stat_ic_notification');
    initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    await showDialog(
        context: Get.context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Ok'),
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true).pop();
                    Get.off(TelaContatos2());
                  },
                )
              ],
            ));
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('Notification payload: $payload');
    }

    Get.off(TelaRadar2());
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) {
    print('4444444444');
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  void facebookk() async {
//    final authCredential = await facebook.getAuthCredential();
//    final authResult = await firebase.signInWithCredential(authCredential);
//
//    if (authResult != null) {
//      uid = authResult.user.uid;
//    } else {
//      print('Facebook auth result é null');
//    }
//    await obterMeuUsuario();
//    if (usuario != null) {
//      final token = await firebase.getToken();
//      usuario.setFcmToken(token);
//      updateUsuario(uid, usuario);
//      update();
//      usuario.verificarEtapaDoCadastro();
//    } else {
//      firebase.addNovoUsuario(uid, usuario.toMap());
//      //TODO: navigate to TelaCadastroNome.rota
//    }
  }

  Future<List<String>> obterContatosDaAgendaNativa() async {
    Iterable<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);

    List<String> celulares = List<String>();

    for (Contact c in contacts) {
      for (Item phone in c.phones) {
        celulares.add(phone.value);
      }
    }

    return celulares;
  }

  Future<void> resetarSenha(Usuario usuario) async {
    final auth = await firebase.getAuth();
    auth.sendPasswordResetEmail(email: usuario.email);
  }

  void ativarConectividadeListener() {
    conectividadeListener = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        semInternet = false;
      } else if (result == ConnectivityResult.wifi) {
        semInternet = false;
      } else {
        semInternet = true;
      }
    });
  }

  Future<void> obterMeuUsuario() async {
    uid = await firebase.getUID();
    await firebase.obterUsuarioByID(uid);
    update();
  }

//  Future<void> obterMeusContatos() async {
//    List<Usuario> lista = List<Usuario>();
//    for (String usuarioID in usuario.contatos) {
//      final usuario = await firebase.obterUsuarioByID(usuarioID);
//      lista.add(usuario);
//    }
//    contatos = lista;
//    update();
//  }

//  Future<void> obterSolicitacoesRecebidas() async {
//    List<Usuario> lista = List<Usuario>();
//    for (String uid in usuario.solicitacoesRecebidas) {
//      final usuario = await firebase.obterUsuarioByID(uid);
//      lista.add(usuario);
//    }
//    solicitacoesRecebidas = lista;
//    update();
//  }

//  Future<void> obterSolicitacoesFeitas() async {
//    List<Usuario> lista = List<Usuario>();
//    for (String uid in usuario.solicitacoesFeitas) {
//      final usuario = await firebase.obterUsuarioByID(uid);
//      lista.add(usuario);
//    }
//    solicitacoesFeitas = lista;
//    update();
//  }

//  Future<void> obterUsuariosSalvos() async {
//    List<Usuario> lista = List<Usuario>();
//    for (String uid in usuario.usuariosSalvos) {
//      final usuario = await firebase.obterUsuarioByID(uid);
//      lista.add(usuario);
//    }
//    salvos = lista;
//    update();
//  }

  Future<void> updateUsuario(String uid, Usuario usuario) async {
    await firebase.updateUsuario(uid, usuario.toMap());
    update();
  }

  void setUID(String id) {
    uid = id;
    update();
  }

  Future<void> criarUsuario(String id, Map data) async {
    await firebase.addNovoUsuario(uid, data);
    await firebase.createUsuarioRTDB(id, {'latitude': 0, 'longitude': 0});
  }

  Future<void> iniciarGeolocator() async {
    await Geolocator().checkGeolocationPermissionStatus();

    positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) async {
      final reference = await firebase.getUsuariosReference();

      firebase.getUser().then((firebaseUser) async {
        if (firebaseUser != null) {
          reference.child(firebaseUser.uid).update(
              {'latitude': position.latitude, 'longitude': position.longitude});
        }
      });

      print(position == null
          ? 'Unknown'
          : position.latitude.toString() +
              ', ' +
              position.longitude.toString());
    });
  }

  void pararGeolocator() {
    if (positionStream != null) {
      positionStream.cancel();
    }
  }

  void adicionarUsuario(Usuario novoContato) async {
    await firebase.obterUsuarioByID(novoContato.uid);

    final contato = usuarioById(novoContato.uid);

    List<dynamic> solicitacoesFeitas = usuarioById(uid).solicitacoesFeitas;

    solicitacoesFeitas.add(contato.uid);

    usuarioById(uid).setSolicitacoesFeitas(solicitacoesFeitas);

    await updateUsuario(uid, usuarioById(uid));

    await atualizarUsuarioAdicionado(contato);
  }

  Future<void> atualizarUsuarioAdicionado(Usuario novoContato) async {
    List<dynamic> solicitacoesRecebidas = novoContato.solicitacoesRecebidas;

    solicitacoesRecebidas.add(usuarioById(uid).uid);
    novoContato.setSolicitacoesRecebidas(solicitacoesRecebidas);

    await firebase.enviarNotificacao(usuarioById(uid), novoContato);

    await updateUsuario(novoContato.uid, novoContato);
  }

  void cancelarSolicitacao(Usuario usuarioCancelado) async {
    await firebase.obterUsuarioByID(usuarioCancelado.uid);

    final contato = usuarioById(usuarioCancelado.uid);

    List<dynamic> solicitacoesFeitas = usuarioById(uid).solicitacoesFeitas;

    solicitacoesFeitas.removeWhere((element) => element == contato.uid);

    usuarioById(uid).setSolicitacoesFeitas(solicitacoesFeitas);

    await updateUsuario(uid, usuarioById(uid));

    await atualizarUsuarioCancelado(contato);
  }

  Future<void> atualizarUsuarioCancelado(Usuario usuarioCancelado) async {
    List<dynamic> solicitacoesRecebidas =
        usuarioCancelado.solicitacoesRecebidas;

    solicitacoesRecebidas
        .removeWhere((element) => element == usuarioById(uid).uid);
    usuarioCancelado.setSolicitacoesRecebidas(solicitacoesRecebidas);
    await updateUsuario(usuarioCancelado.uid, usuarioCancelado);
  }

  Future<void> salvarUsuario(Usuario usuarioQueVaiSerSalvo) async {
    await firebase.obterUsuarioByID(usuarioQueVaiSerSalvo.uid);

    final contato = usuarioById(usuarioQueVaiSerSalvo.uid);

    List<dynamic> usuariosSalvos = usuarioById(uid).usuariosSalvos;

    usuariosSalvos.add(contato.uid);
    usuarioById(uid).setUsuariosSalvos(usuariosSalvos);
    updateUsuario(uid, usuarioById(uid));
  }

  Future<void> removerUsuarioSalvo(
      Usuario usuarioSalvoQueVaiSerRemovido) async {
    await firebase.obterUsuarioByID(usuarioSalvoQueVaiSerRemovido.uid);

    final contato = usuarioById(usuarioSalvoQueVaiSerRemovido.uid);

    List<dynamic> usuariosSalvos = usuarioById(uid).usuariosSalvos;

    usuariosSalvos.removeWhere((element) => element == contato.uid);
    usuarioById(uid).setUsuariosSalvos(usuariosSalvos);
    updateUsuario(uid, usuarioById(uid));
  }

  Future<void> aceitarSolicitacao(Usuario usuarioQueSeraAceito) async {
    await firebase.obterUsuarioByID(usuarioQueSeraAceito.uid);

    final contato = usuarioById(usuarioQueSeraAceito.uid);

    await aceitacaoEsteUsuario(contato);

    await aceitacaoOutroUsuario(contato);
  }

  Future aceitacaoEsteUsuario(Usuario usuarioQueSeraAceito) async {
    List<dynamic> solicitacoesRecebidasDesteUsuario =
        usuarioById(uid).solicitacoesRecebidas;
    List<dynamic> contatos = usuarioById(uid).contatos;

    solicitacoesRecebidasDesteUsuario
        .removeWhere((element) => element == usuarioQueSeraAceito.uid);

    contatos.add(usuarioQueSeraAceito.uid);

    usuarioById(uid)
        .setSolicitacoesRecebidas(solicitacoesRecebidasDesteUsuario);
    usuarioById(uid).setContatos(contatos);

    await updateUsuario(uid, usuarioById(uid));
  }

  Future aceitacaoOutroUsuario(Usuario usuarioQueSeraAceito) async {
    List<dynamic> solicitacoesFeitasDoUsuarioAceito =
        usuarioQueSeraAceito.solicitacoesFeitas;
    List<dynamic> contatosDoUsuarioAceito = usuarioQueSeraAceito.contatos;

    solicitacoesFeitasDoUsuarioAceito
        .removeWhere((element) => element == usuarioById(uid).uid);
    contatosDoUsuarioAceito.add(usuarioById(uid).uid);

    usuarioQueSeraAceito
        .setSolicitacoesFeitas(solicitacoesFeitasDoUsuarioAceito);
    usuarioQueSeraAceito.setContatos(contatosDoUsuarioAceito);

    await updateUsuario(usuarioQueSeraAceito.uid, usuarioQueSeraAceito);
  }

  Future<void> rejeitarSolicitacao(Usuario usuarioQueSeraRejeitado) async {
    await firebase.obterUsuarioByID(usuarioQueSeraRejeitado.uid);

    final contato = usuarioById(usuarioQueSeraRejeitado.uid);
    await rejeicaoEsteUsuario(contato);

    await rejeicaoOutroUsuario(contato);
  }

  Future rejeicaoEsteUsuario(Usuario usuarioQueSeraRejeitado) async {
    List<dynamic> solicitacoesRecebidasDesteUsuario =
        usuarioById(uid).solicitacoesRecebidas;

    solicitacoesRecebidasDesteUsuario
        .removeWhere((element) => element == usuarioQueSeraRejeitado.uid);

    usuarioById(uid)
        .setSolicitacoesRecebidas(solicitacoesRecebidasDesteUsuario);

    await updateUsuario(uid, usuarioById(uid));
  }

  Future rejeicaoOutroUsuario(Usuario usuarioQueSeraRejeitado) async {
    List<dynamic> solicitacoesFeitasDoUsuarioRejeitado =
        usuarioQueSeraRejeitado.solicitacoesFeitas;

    solicitacoesFeitasDoUsuarioRejeitado
        .removeWhere((element) => element == usuarioById(uid).uid);

    usuarioQueSeraRejeitado
        .setSolicitacoesFeitas(solicitacoesFeitasDoUsuarioRejeitado);

    await updateUsuario(usuarioQueSeraRejeitado.uid, usuarioQueSeraRejeitado);
  }

  Future<void> bloquearUsuario(Usuario usuarioBlock) async {
    await firebase.obterUsuarioByID(usuarioBlock.uid);

    final contato = usuarioById(usuarioBlock.uid);
    await atualizarEsteUsuarioBlock(contato);

    await atualizarOutroUsuarioBlock(contato);
  }

  Future atualizarEsteUsuarioBlock(Usuario usuarioBlock) async {
    List<dynamic> usuariosSalvosDesteUsuario = usuarioById(uid).usuariosSalvos;
    List<dynamic> usuariosBloqueadosDesteUsuario =
        usuarioById(uid).usuariosQueBloqueei;
    List<dynamic> contatosDesteUsuario = usuarioById(uid).contatos;
    List<dynamic> solicitacoesRecebidasDesteUsuario =
        usuarioById(uid).solicitacoesRecebidas;
    List<dynamic> solicitacoesFeitasDesteUsuario =
        usuarioById(uid).solicitacoesFeitas;

    solicitacoesFeitasDesteUsuario
        .removeWhere((element) => element == usuarioBlock.uid);
    solicitacoesRecebidasDesteUsuario
        .removeWhere((element) => element == usuarioBlock.uid);
    usuariosSalvosDesteUsuario
        .removeWhere((element) => element == usuarioBlock.uid);
    contatosDesteUsuario.removeWhere((element) => element == usuarioBlock.uid);

    usuariosBloqueadosDesteUsuario.add(usuarioBlock.uid);

    usuarioById(uid).setUsuariosSalvos(usuariosSalvosDesteUsuario);
    usuarioById(uid).setUsuariosQueBloqueei(usuariosBloqueadosDesteUsuario);
    usuarioById(uid).setContatos(contatosDesteUsuario);
    usuarioById(uid)
        .setSolicitacoesRecebidas(solicitacoesRecebidasDesteUsuario);
    usuarioById(uid).setSolicitacoesFeitas(solicitacoesFeitasDesteUsuario);

    await updateUsuario(uid, usuarioById(uid));
  }

  Future atualizarOutroUsuarioBlock(Usuario usuarioBlock) async {
    List<dynamic> usuariosSalvosUsuarioBlock = usuarioBlock.usuariosSalvos;
    List<dynamic> usuariosQueBloquearamUsuarioBlock =
        usuarioBlock.usuariosQueTeBloquearam;
    List<dynamic> contatosUsuarioBlock = usuarioBlock.contatos;
    List<dynamic> solicitacoesRecebidasUsuarioBlock =
        usuarioBlock.solicitacoesRecebidas;
    List<dynamic> solicitacoesFeitasUsuarioBlock =
        usuarioBlock.solicitacoesFeitas;

    usuariosSalvosUsuarioBlock
        .removeWhere((element) => element == usuarioById(uid).uid);
    contatosUsuarioBlock
        .removeWhere((element) => element == usuarioById(uid).uid);
    solicitacoesRecebidasUsuarioBlock
        .removeWhere((element) => element == usuarioById(uid).uid);
    solicitacoesFeitasUsuarioBlock
        .removeWhere((element) => element == usuarioById(uid).uid);

    usuariosQueBloquearamUsuarioBlock.add(usuarioById(uid).uid);

    usuarioBlock.setUsuariosSalvos(usuariosSalvosUsuarioBlock);
    usuarioBlock.setUsuariosQueTeBloquearam(usuariosQueBloquearamUsuarioBlock);
    usuarioBlock.setContatos(contatosUsuarioBlock);
    usuarioBlock.setSolicitacoesRecebidas(solicitacoesRecebidasUsuarioBlock);
    usuarioBlock.setSolicitacoesFeitas(solicitacoesFeitasUsuarioBlock);

    await updateUsuario(usuarioBlock.uid, usuarioBlock);
  }

  Future<void> removerContato(Usuario contato) async {
    await firebase.obterUsuarioByID(contato.uid);

    final c = usuarioById(contato.uid);
    await removerDesteUsuario(c);
    await removerDoOutroUsuario(c);
  }

  Future removerDesteUsuario(Usuario contato) async {
    List<dynamic> contatosIds = usuarioById(uid).contatos;
    contatosIds.removeWhere((element) => element == contato.uid);
    usuarioById(uid).setContatos(contatosIds);

    List<dynamic> salvosIds = usuarioById(uid).usuariosSalvos;
    usuarioById(uid).setUsuariosSalvos(salvosIds);
    salvosIds.removeWhere((element) => element == contato.uid);

    updateUsuario(uid, usuarioById(uid));

    contatos.removeWhere((element) => element.uid == contato.uid);
  }

  Future removerDoOutroUsuario(Usuario contato) async {
    List<dynamic> contatosIdsOutroUsuario = contato.contatos;
    contatosIdsOutroUsuario
        .removeWhere((element) => element == usuarioById(uid).uid);
    contato.setContatos(contatosIdsOutroUsuario);

    updateUsuario(contato.uid, contato);
    update();
  }

  void compartilhar(Usuario contato) {
    final String text = 'Confira o perfil de: ${contato.nome}';

    createLink(contato.uid)
        .then((url) => Share.share('$text\n\n$url', subject: text));
  }

  Future<String> createLink(String id) async {
    final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
      uriPrefix: 'https://meetby.page.link',
      link: Uri.parse('http://matheusneumann.surge.sh/usuario?id=$id'),
      androidParameters: AndroidParameters(packageName: 'com.me.by'),
    );

    final Uri dynamicUrl = await dynamicLinkParameters.buildUrl();
    return dynamicUrl.toString();
  }

  void convidar(Usuario usuario) {
    final String text =
        'Seja um dos meus contatos no meby, um app simples, prático e seguro para add novos contatos! Para baixar, acesse https://meby.app.';

    createLink(usuario.uid)
        .then((url) => Share.share('$text\n$url', subject: 'Convite meby'));
  }

  Future<String> convidarCreateLink(String id) async {
    final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
      uriPrefix: 'https://meetby.page.link',
      link: Uri.parse('http://matheusneumann.surge.sh/usuario?id=$id'),
      androidParameters: AndroidParameters(packageName: 'com.me.by'),
    );

    final Uri dynamicUrl = await dynamicLinkParameters.buildUrl();
    return dynamicUrl.toString();
  }

  Future<void> logout() async {
    pararGeolocator();
    final firebaseAuth = await firebase.getAuth();
    await firebaseAuth.signOut();
  }

  Future<void> desbloquear(Usuario usuarioDesbloqueado) async {
    await firebase.obterUsuarioByID(usuarioDesbloqueado.uid);

    final c = usuarioById(usuarioDesbloqueado.uid);
    List<dynamic> usuariosBloqueadosDesteUsuario =
        usuarioById(uid).usuariosQueBloqueei;
    List<dynamic> usuariosQueBloquearamOutroUsuario = c.usuariosQueTeBloquearam;

    usuariosBloqueadosDesteUsuario.removeWhere((element) => element == c.uid);
    usuariosQueBloquearamOutroUsuario
        .removeWhere((element) => element == usuarioById(uid).uid);

    usuarioById(uid).setUsuariosQueBloqueei(usuariosBloqueadosDesteUsuario);
    c.setUsuariosQueTeBloquearam(usuariosQueBloquearamOutroUsuario);

//      usuariosBloqueados
//          .removeWhere((element) => element.uid == usuarioDesbloqueado.uid);

    updateUsuario(uid, usuarioById(uid));
    updateUsuario(c.uid, c);
  }

  obterMeusContatos() async {
    for (String id in usuarioById(uid).contatos) {
      await firebase.getUsuarioStreamFirestore(id);
    }
  }

  Future<void> excluirConta(Usuario usuario) async {
    for (String id in usuario.contatos) {
      await removerDoOutroUsuario(usuarioById(id));
    }

    await firebase.removerUsuarioFirestore(uid);
    await firebase.removerUsuarioRTDB(uid);
    await firebase.removerUsuarioAuth(uid);
  }

  Future<void> limparControle() async {
    pararGeolocator();
    usuariosStreamFirestore = List<StreamFirestore>();
    streamRTDBMinhaLocalizacao = null;
    firebase = Firebase();
    facebook = Facebook();
    google = Google();
    uid = null;
    uidsPerto = List<String>();
    todosUsuarios = List<Usuario>();
    contatos = List<Usuario>();
    usuariosPerto = List<Usuario>();
    contatosPendentes = List<Usuario>();

    telaEditarUsuarioControle = null;
    conectividadeListener = null;
    dynamicLinkService = DynamicLinkService();
    telaSuporteEscolhida = 0;
    botaoFemininoCorFundo = Colors.white;
    botaoMasculinoCorFundo = Colors.white;
    botaoFemininoCorTexto = Color(0xff058BC6);
    botaoMasculinoCorTexto = Color(0xff058BC6);
    imagem = null;
    progressPercent = null;
    colunaConfirmada = null;
    controleFoto = false;
    selectedIndex = 0;
    solicitacoesIndex = 0;
    geolocator = Geolocator();
    locationOptions =
        LocationOptions(accuracy: LocationAccuracy.best, distanceFilter: 0);
    positionStream = null;
    masculino = false;
    feminino = false;
    ambos = false;
    pesquisarOn = false;
    textoPesquisa = null;
    initializationSettingsAndroid = null;
    initializationSettingsIOS = null;
    initializationSettings = null;
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    imagem = null;
    botaoFemininoCorTexto = Color(0xff989898);
    botaoMasculinoCorTexto = Color(0xff989898);

    profissaoTextController = TextEditingController();

    dynamicLinkService.handleDynamicLinks();
    inicializarNotificacoes();
    await getStorage.initStorage;
  }
}
