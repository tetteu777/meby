import 'dart:io';

import 'package:meby/controle/controle.dart';
import 'package:meby/visao/telas/TelaEditarUsuario.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastroFoto.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastroRedesSociais.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:firebase_storage/firebase_storage.dart';

class Uploader extends StatefulWidget {
  File file;

  Uploader({Key key, this.file}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  Controle controle = Get.find();

  Future<void> _startUpload() async {
    String filePath = 'images/${DateTime.now()}.png';

    await controle.firebase.setStorageUploadTask(filePath, widget.file);
    controle.update();

    var dowurl =
        await (await controle.firebase.getStorageUploadTask().onComplete)
            .ref
            .getDownloadURL();
    var url = dowurl.toString();

    controle.usuarioById(controle.uid).setImagemUrl(url);
    controle.update();

    controle.updateUsuario(controle.uid, controle.usuarioById(controle.uid));
  }

  @override
  Widget build(BuildContext context) {
    if (controle.firebase.getStorageUploadTask() != null) {
      return GetBuilder<Controle>(
          init: controle,
          builder: (_) {
            return StreamBuilder<StorageTaskEvent>(
              stream: _.firebase.getStorageUploadTask().events,
              builder: (context, snapshot) {
                var event = snapshot?.data?.snapshot;

                if (event != null) {
                  _.setProgressPercent(
                      event.bytesTransferred / event.totalByteCount);
                } else {
                  _.setProgressPercent(0);
                }

                return Column(
                  children: [
                    if (_.firebase.getStorageUploadTask().isComplete)
                      fotoConfirmada(_),
                    if (_.firebase.getStorageUploadTask().isPaused)
                      FlatButton(
                        child: Icon(Icons.play_arrow),
                        onPressed: _.firebase.getStorageUploadTask().resume,
                      ),
                    if (_.firebase.getStorageUploadTask().isInProgress)
                      FlatButton(
                        child: Icon(Icons.pause),
                        onPressed: _.firebase.getStorageUploadTask().pause,
                      ),
                    LinearProgressIndicator(
                      value: _.progressPercent,
                    ),
                    Text('${(_.progressPercent * 100).toStringAsFixed(0)} %',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff058BC6))),
                  ],
                );
              },
            );
          });
    } else {
      return GetBuilder<Controle>(
          init: controle,
          initState: (_) {},
          builder: (_) {
            return botaoConfirmar(_);
          });
    }
  }

  Text fotoConfirmada(Controle controle) {
    controle.colunaConfirmada = Container();

    return Text(
      'Foto confirmada',
      style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff058BC6)),
    );
  }

  Widget botaoConfirmar(Controle _) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return CircularProgressIndicator();
        } else {
          return Container(
            margin: EdgeInsets.only(left: 40.w, right: 40.w, top: 40.h),
            child: RaisedButton(
              color: Color(0xff058BC6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Color(0xff058BC6)),
              ),
              child: Text(
                'Confirmar esta foto',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                await _startUpload().catchError((error) {
                  print('erro: ${error.toString()}');
                });
                if (_.usuarioById(_.uid).cadastro) {
                  if (_.usuarioById(_.uid).imagemUrl !=
                      'http://content.internetvideoarchive.com/content/photos/1428/06000501_.jpg') {
                    Get.off(TelaCadastroRedesSociais());
                    _.usuarioById(_.uid).setCadastro(false);
                    _.updateUsuario(_.uid, _.usuarioById(_.uid));
                    widget.file = null;
                  } else {}
                } else {
                  Get.off(TelaEditarUsuario());
                  widget.file = null;
                }
              },
            ),
          );
        }
      },
    );
  }
}
