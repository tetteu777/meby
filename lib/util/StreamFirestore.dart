import 'dart:async';

import 'package:equatable/equatable.dart';

class StreamFirestore extends Equatable {
  String uid;
  StreamSubscription streamSubscription;

  StreamFirestore(this.uid, this.streamSubscription);

  @override
  // TODO: implement props
  List<Object> get props => [uid];

  void cancelarStream(){
    streamSubscription.cancel();
  }
}
