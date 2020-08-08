import 'package:cloud_firestore/cloud_firestore.dart';

class Api {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  Api(this.path) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Stream<DocumentSnapshot> streamDataDocument(String id){
    return ref.document(id).snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
    //return ref.where('uid', isEqualTo: id).getDocuments();
  }

  Future<void> removeDocument(String id) {
    return ref.document(id).delete();
  }

  Future<void> addDocument(Map data) {
    return ref.document(data['uid']).setData(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.document(id).updateData(data);
  }
}
