import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class StreamRTDB {

  StreamSubscription<Event> streamSubscription;

  StreamRTDB(this.streamSubscription);

  Future<void> cancelarStream() async {
    await streamSubscription.cancel();
  }

}