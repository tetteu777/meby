import 'package:meby/controle/controle.dart';
import 'package:meby/modelo/Usuario.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TelaBloqueados extends StatelessWidget {
  List<Usuario> usuariosBloqueados = List<Usuario>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Bloqueados'),
      ),
      body: GetBuilder<Controle>(
          init: Controle.to,
          builder: (_) {
            usuariosBloqueados = _.todosUsuarios
                .where((u) =>
                    _.usuarioById(_.uid).usuariosQueBloqueei.contains(u.uid))
                .toList();
            return ListView.builder(
              itemBuilder: (ctx, i) {
                return Card(
                  child: ListTile(
                    title: Text(usuariosBloqueados[i].nome),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(usuariosBloqueados[i].imagemUrl),
                    ),
                    trailing: RaisedButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Color(0xff058BC6))),
                      child: Text(
                        'Desbloquear',
                        style: TextStyle(color: Color(0xff058BC6)),
                      ),
                      onPressed: () {
                        _.desbloquear(usuariosBloqueados[i]);
                      },
                    ),
                  ),
                );
              },
              itemCount: usuariosBloqueados.length,
            );
          }),
    );
  }
}
