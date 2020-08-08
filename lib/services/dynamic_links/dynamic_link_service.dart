import 'package:meby/controle/controle.dart';
import 'package:meby/modelo/Usuario.dart';
import 'package:meby/visao/telas/TelaPerfilDoContato.dart';
import 'package:meby/visao/telas/TelaQuandoCompartilhar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Locator.dart';
import '../navigation_service.dart';

class DynamicLinkService {
  Future handleDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    _handleDeepLink(data);

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
      _handleDeepLink(dynamicLinkData);
    }, onError: (OnLinkErrorException e) async {
      print('Dynamic Link Failed: ${e.message}');
    });
  }

  Future<void> _handleDeepLink(PendingDynamicLinkData data) async {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      print('_handleDeepLink | deepLink: $deepLink');

      var isUsuario = deepLink.pathSegments.contains('usuario');
      if (isUsuario) {
        var id = deepLink.queryParameters['id'];

        if (id != null) {
          await Controle.to.firebase.obterUsuarioByID(id);
          await Controle.to.firebase.getUsuarioStreamFirestore(id);

          Usuario usuario = Controle.to.usuarioById(id);
          Get.to(TelaQuandoCompartilhar(usuario, Controle.to));

//          print('id: $id');
//          Firestore db = Firestore.instance;
//          FirebaseUser euFirestore;
//          Usuario eu, outro;
//          await FirebaseAuth.instance
//              .currentUser()
//              .then((user) => euFirestore = user);
//
//          await db
//              .collection('usuarios')
//              .document(euFirestore.uid)
//              .get()
//              .then((DocumentSnapshot doc) {
//            eu = Usuario.fromMap(doc.data);
//          });
//
//          await db.collection('usuarios').document(id).get().then((DocumentSnapshot doc) {
//            outro = Usuario.fromMap(doc.data);
//          });
          //TODO: navigator
          //locator<NavigationService>().navigateTo(TelaPerfilDoContato.rota, [outro, eu]);
        }
      }
    }
  }
}
