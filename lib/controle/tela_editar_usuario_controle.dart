import 'package:flutter/material.dart';

class TelaEditarUsuarioControle {
  TextEditingController nomeController;
  TextEditingController profissaoController;
  TextEditingController bioController;

  TelaEditarUsuarioControle(String nome, String profissao, String bio) {
    nomeController = TextEditingController(text: nome);
    profissaoController = TextEditingController(text: profissao);
    bioController = TextEditingController(text: bio);
  }
}
