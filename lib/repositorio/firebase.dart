import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:meby/controle/controle.dart';
import 'package:meby/modelo/CalculadoraDistancia.dart';
import 'package:meby/modelo/Usuario.dart';
import 'package:meby/util/StreamFirestore.dart';
import 'package:meby/util/StreamRTDB.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class Firebase {
  StorageUploadTask uploadTask;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  FirebaseMessaging get messaging {
    return firebaseMessaging;
  }

  Future<FirebaseAuth> getAuth() async {
    return FirebaseAuth.instance;
  }

  Future<AuthResult> signInWithCredential(AuthCredential authCredential) async {
    final auth = await getAuth();
    final authResult = auth.signInWithCredential(authCredential);
    return authResult;
  }

  Future<FirebaseUser> getUser() async {
    try {
      final user = await FirebaseAuth.instance.currentUser();
      print(user?.uid);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<FirebaseDatabase> getDatabase() async {
    try {
      final database = await FirebaseDatabase.instance;
      return database;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<DatabaseReference> getUsuariosReference() async {
    final db = await getDatabase();
    final ref = db.reference().child('usuarios');
    return ref;
  }

  Future<void> createUsuarioRTDB(String uid, Map data) async {
    final reference = await getUsuariosReference();
    reference.child(uid).set(data);
  }

  Future<Firestore> getFirestore() async {
    try {
      final firestore = await Firestore.instance;
      return firestore;
    } catch (e) {
      print(e.toString());
    }
  }

  StorageReference getStorageReference() {
    final FirebaseStorage _firebaseStorage =
        FirebaseStorage(storageBucket: 'gs://meetby-d42fa.appspot.com');
    return _firebaseStorage.ref();
  }

  Future<void> setStorageUploadTask(String path, File file) async {
    final storageReference = await getStorageReference();
    uploadTask = storageReference.child(path).putFile(file);
  }

  StorageUploadTask getStorageUploadTask() {
    return uploadTask;
  }

  Future<String> getToken() async {
    try {
      final token = await firebaseMessaging.getToken();
      return token;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<DocumentSnapshot> getDocumentSnapshot(String uid) async {
    try {
      final firestore = await getFirestore();
      final collection = await firestore.collection('usuarios');
      final document = await collection.document(uid);
      final snapshot = await document.get();
      return snapshot;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> streamMinhaLocalizacao(Usuario usuario) async {
    try {
      final database = await getDatabase();
      Stream<Event> stream =
          database.reference().child('usuarios').child(usuario.uid).onValue;

      if (Controle.to.streamRTDBMinhaLocalizacao == null) {
        Controle.to.streamRTDBMinhaLocalizacao =
            StreamRTDB(stream.listen((data) {
          Controle.to
              .usuarioById(Controle.to.uid)
              .setLatitude(data.snapshot.value['latitude'].toDouble());
          Controle.to
              .usuarioById(Controle.to.uid)
              .setLongitude(data.snapshot.value['longitude'].toDouble());
        }, onError: (erro) {
          print(erro.toString());
        }, onDone: () {
          print('RealtimeDatabase stream done');
        }));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getUID() async {
    final user = await getUser();
    return user.uid;
  }

  Future<void> getListaUIDUsuariosPerto(Usuario usuario) async {
    CalculadoraDeDistancia cdc = CalculadoraDeDistancia();

    try {
      final database = await getDatabase();
      Stream<Event> stream = await database
          .reference()
          .child('usuarios')
          .orderByChild('latitude')
          .startAt(
            cdc.calcularLatitudeELongitude(usuario, -100).first,
          )
          .endAt(
            cdc.calcularLatitudeELongitude(usuario, 100).first,
          )
          .onValue;

      Controle.to.streamRTDBUsuariosPerto =
          StreamRTDB(stream.listen((data) async {
        print('stream RTDB lat lng usuarios perto');
        Map usuariosFiltradosRTDB = data.snapshot.value;

        for (int i = 0; i < Controle.to.uidsPerto.length; i++) {
          if (!usuariosFiltradosRTDB.containsKey(Controle.to.uidsPerto[i])) {
            for (StreamFirestore streamFirestore
                in Controle.to.usuariosStreamFirestore) {
              if (streamFirestore.uid == Controle.to.uidsPerto[i]) {
                streamFirestore.cancelarStream();
                Controle.to.usuariosStreamFirestore.removeWhere(
                    (StreamFirestore streamFirestore) =>
                        streamFirestore.uid == Controle.to.uidsPerto[i]);
              }
            }
            Controle.to.uidsPerto.removeAt(i);

            Controle.to.update();
          }
        }

        if (usuariosFiltradosRTDB != null) {
          usuariosFiltradosRTDB.forEach((id, coordenadas) async {
            if (id != usuario.uid) {
              final estaPerto = await cdc.estaPerto(
                  usuario.latitude,
                  usuario.longitude,
                  coordenadas['latitude'].toDouble(),
                  coordenadas['longitude'].toDouble());
              if (estaPerto) {
                if (!Controle.to.uidsPerto.contains(id)) {
                  Controle.to.uidsPerto.add(id);
                  if (!Controle.to.usuariosStreamFirestore
                      .contains(StreamFirestore(id, null))) {
                    getUsuarioStreamFirestore(id);
                  }
                  Controle.to.update();
                }
              }
            }
          });
        }
      }, onError: (erro) {
        print(erro.toString());
      }, onDone: () {
        print('RealtimeDatabase stream done');
      }));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateUsuario(String uid, Map data) async {
    try {
      final firestore = await getFirestore();
      final collection = await firestore.collection('usuarios');
      final document = await collection.document(uid);
      document.updateData(data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> removerUsuarioFirestore(String uid) async {
    try {
      final firestore = await getFirestore();
      final collection = await firestore.collection('usuarios');
      final document = await collection.document(uid);
      document.delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> removerUsuarioRTDB(String uid) async {
    try {
      final reference = await getUsuariosReference();
      await reference.child(uid).remove();

    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> removerUsuarioAuth(String uid) async {
    try {
      final user = await getUser();
      await user.delete();

    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addNovoUsuario(String uid, Map data) async {
    try {
      final firestore = await getFirestore();
      final collection = await firestore.collection('usuarios');
      final document = await collection.document(uid);
      document.setData(data);
    } catch (e) {
      print(e.toString());
    }
  }

//  void obterUsuariosPertoRealTimeDatabase(Usuario usuario) async {
//  //  final uidsPerto = await getListaUIDUsuariosPerto(usuario);
////    for (String usuarioId in uidsPerto) {
////      //obterUsuarioRealTimeDatabaseById(usuarioId);
////    }
//  }

//  void obterUsuariosPertoFirestore(Usuario usuario) async {
//    final uidsPerto = await getListaUIDUsuariosPerto(usuario);
//    for (String usuarioId in uidsPerto) {
//      obterUsuarioFirestoreByUID(usuarioId);
//    }
//  }

  Future<Usuario> obterUsuarioFirestoreByUID(String id) async {
    final snapshot = await getDocumentSnapshot(id);
    if (snapshot == null) {
      Get.snackbar('Erro', 'Não foi possível conectar ao Firestore');
    } else {
      if (snapshot.data == null) {
        return null;
      } else {
        return Usuario.fromMap(snapshot.data);
      }
    }
  }

  Future<void> obterUsuarioByID(String id) async {
    final usuario = await obterUsuarioFirestoreByUID(id);

    if (Controle.to.todosUsuarios.contains(usuario)) {
      Controle.to.todosUsuarios
          .removeWhere((element) => element.uid == usuario.uid);
    }
    Controle.to.todosUsuarios.add(usuario);
    await streamMinhaLocalizacao(usuario);
  }

  Future<bool> usuarioEstaCadastrado(String id) async {
    final usuario = await obterUsuarioFirestoreByUID(id);

    return usuario != null;
  }

  Future<void> enviarNotificacao(
      Usuario esteUsuario, Usuario novoContato) async {
    final firestore = await getFirestore();

    firestore
        .collection('usuarios')
        .document(novoContato.uid)
        .collection('notifications')
        .add({
      'message': '${esteUsuario.nome} adicionou você',
      'title': 'Nova solicitação',
      'date': FieldValue.serverTimestamp(),
    });
  }

  Future<void> getUsuarioStreamFirestore(String id) async {
    final firestore = await getFirestore();
    final collection = await firestore.collection('usuarios');
    final document = await collection.document(id);

    StreamFirestore streamFirestore = StreamFirestore(
      id,
      document.snapshots().listen(
        (data) {
          final usuario = Usuario.fromMap(data.data);
          Controle.to.atualizarUsuarioFirestore(usuario);
          //Controle.to.firebase.obterUsuarioByID(id);
        },
        onError: (erro) {
          print(erro.toString());
        },
        onDone: () {
          print('Stream usuario done');
        },
      ),
    );

    if (!Controle.to.usuariosStreamFirestore.contains(streamFirestore)) {
      Controle.to.usuariosStreamFirestore.add(streamFirestore);
    }
  }

  Future<void> getUsuarioDaMinhaAgendaFirestore(String id) async {
    final celulares = await Controle.to.obterContatosDaAgendaNativa();


    final firestore = await getFirestore();
    final collection = await firestore.collection('usuarios');
    final document = await collection.where('whatsapp', arrayContainsAny: celulares);
    final length = await document.snapshots().length;

    for (int i = 0; i < length; i++) {
      StreamFirestore streamFirestore = StreamFirestore(
        id,
        document.snapshots().listen(
              (data) {
            final usuario = Usuario.fromMap(data.documents[i].data);
            Controle.to.atualizarUsuarioFirestore(usuario);
            //Controle.to.firebase.obterUsuarioByID(id);
          },
          onError: (erro) {
            print(erro.toString());
          },
          onDone: () {
            print('Stream usuario done');
          },
        ),
      );

      if (!Controle.to.usuariosStreamFirestore.contains(streamFirestore)) {
        Controle.to.usuariosStreamFirestore.add(streamFirestore);
      }
    }
  }
  
}
