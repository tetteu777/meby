import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meby/modelo/Usuario.dart';

import '../Locator.dart';
import 'Api.dart';

class UsuarioCRUD extends ChangeNotifier {
  Api _api = locator<Api>();

  List<Usuario> usuarios;

  Future<List<Usuario>> getUsuarios() async {
    var result = await _api.getDataCollection();
    usuarios =
        result.documents.map((doc) => Usuario.fromMap(doc.data)).toList();
    return usuarios;
  }

  Stream<QuerySnapshot> getUsuariosAsStream() {
    var result =  _api.streamDataCollection();    
    return result;
  }

  Stream<DocumentSnapshot> getUsuarioAsStream(String id) {
    return _api.streamDataDocument(id);
  }

  Future<Usuario> getUsuarioById(String id) async {
    var doc = await _api.getDocumentById(id);

    if (doc.data == null) {
      return null;
    } else {
      return Usuario.fromMap(doc.data);
    }
  }

  Future removerUsuario(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateUsuario(Usuario data, String id) async {
    await _api.updateDocument(data.toMap(), id);
    return;
  }

  Future addUsuario(Usuario data) async {
    var result = await _api.addDocument(data.toMap());

    return;
  }
}
