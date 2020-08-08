import 'package:meby/controle/controle.dart';
import 'package:meby/modelo/Usuario.dart';
import 'package:meby/visao/telas/TelaEditarUsuario.dart';
import 'package:meby/visao/telas/cadastro/TelaCadastroRedesSociais.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meby/util/Uploader.dart';

class TelaCadastroFoto extends StatelessWidget {
  static const String rota = '/telaCadastroFoto';

  final picker = ImagePicker();

  Controle controle = Get.find();

  Future<void> _escolherImagem(ImageSource source) async {
    final imagemSelecionada =
        await picker.getImage(source: source, maxWidth: 1024, maxHeight: 1024);

    controle.setImagem(File(imagemSelecionada.path));
    controle.update();
  }

  Future<void> _cortarImagem() async {
    File imagemCortada = await ImageCropper.cropImage(
      cropStyle: CropStyle.circle,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      androidUiSettings: AndroidUiSettings(
          backgroundColor: Colors.white,
          toolbarTitle: 'Editar foto',
          hideBottomControls: true),
      sourcePath: controle.imagem.path,
      maxHeight: 400,
      maxWidth: 400,
    );

    controle.setImagem(imagemCortada ?? controle.imagem);
    controle.update();
  }

  void _clear() {
    controle.setImagem(null);
    controle.update();
  }

  @override
  Widget build(BuildContext context) {
    controle.colunaConfirmada = Container();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: Controle.to.usuarioById(Controle.to.uid).cadastro == false
            ? AppBar(
                title: Text(
                  'Foto do perfil',
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.white,
              )
            : null,
        body: GetBuilder<Controle>(
            init: controle,
            initState: (_) {
              Controle.to.imagem = null;

              if (Controle.to.firebase.getStorageUploadTask() != null) {
                Controle.to.firebase.uploadTask = null;
              }
              Controle.to.controleFoto = false;
              Controle.to.progressPercent = null;

            },
            builder: (_) {
              if (_.imagem != null && !_.controleFoto) {
                _cortarImagem();
                _.controleFoto = true;
              }

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 28.h,
                      ),
                      _.usuarioById(_.uid).cadastro == true
                          ? Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(9.w),
                                    ),
                                    color: Color(0xffD9D9D9),
                                  ),
                                  width: 130.w,
                                  height: 17.h,
                                ),
                                Container(
                                  width: (130.w / 7) * 6,
                                  height: 17.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(9.w),
                                      ),
                                      color: Color(0xff058BC6)),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 63.h,
                      ),
                      Container(
                        child: Text(
                          _.imagem == null ? 'Envie a sua melhor foto' : '',
                          style: TextStyle(
                              fontSize: 32.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: _.imagem == null ? 171.h : 110.h,
                      ),
                      _.imagem == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _.controleFoto = false;
                                    _escolherImagem(ImageSource.camera);
                                  },
                                  child: Container(
                                    width: 84.w,
                                    height: 84.w,
                                    child: Container(
                                        width: 36.w,
                                        height: 30.h,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 40,
                                        )),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff058BC6)),
                                  ),
                                ),
                                SizedBox(
                                  height: 63.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    _.controleFoto = false;
                                    _escolherImagem(ImageSource.gallery);
                                  },
                                  child: Container(
                                    width: 84.w,
                                    height: 84.w,
                                    child: Container(
                                        width: 36.w,
                                        height: 30.h,
                                        child: Icon(
                                          Icons.folder,
                                          color: Colors.white,
                                          size: 40,
                                        )),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff058BC6)),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          if (_.imagem != null) ...[
                            Container(
                              width: 300.w,
                              height: 300.w,
                              margin: EdgeInsets.symmetric(horizontal: 57.w),
                              child: CircleAvatar(
                                backgroundImage: FileImage(
                                  _.imagem,
                                ),
                              ),
                            ),
                            _.colunaConfirmada,
                            Uploader(file: _.imagem),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
