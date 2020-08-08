class CalculadoraDeIdade {

  static int obterIdade(String dataDeNascimento) {
    DateTime dt = DateTime.parse(dataDeNascimento);

    return ((DateTime.now().difference(dt).inDays) / 365).toInt();
  }

}