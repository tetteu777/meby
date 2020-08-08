import "package:equatable/equatable.dart";

class Usuario extends Equatable {
  String _uid;

  String _fcmToken;
  List<dynamic> _notificacoes;


  String _nome;
  String _profissao;
  String _bio;
  String _imagemUrl;
  DateTime _dataDeNascimento;

  String _sexo;
  String _sexoDoOutro;

  String _instagram,
      _facebook,
      _email,
      _whatsapp,
      _twitter,
      _linkedin,
      _youtube,
      _spotify,
      _tiktok;

  List<dynamic> _solicitacoesFeitas;
  List<dynamic> _solicitacoesRecebidas;

  List<dynamic> _usuariosSalvos;

  List<dynamic> _usuariosQueBloqueei, _usuariosQueTeBloquearam;

  List<dynamic> _contatos;

  double _latitude, _longitude;
  bool _visivel;

  bool _mostrarIdade;

  bool _cadastro;
  bool _tutorialBusca;
  bool _primeiroContato;

  Usuario(
      {uid,
      fcmToken,
      notificacoes,
      nome,
      profissao,
      bio,
      imagemUrl,
      dataDeNascimento,
      sexo,
      sexoDoOutro,
      instagram,
      facebook,
      email,
      whatsapp,
      twitter,
      linkedin,
      youtube,
      spotify,
      tiktok,
      contatos,
      solicitacoesFeitas,
      solicitacoesRecebidas,
      usuariosSalvos,
      latitude,
      longitude,
      visivel,
      usuariosQueBloqueei,
      usuariosQueTeBloquearam,
      mostrarIdade,
      cadastro,
      tutorialBusca,
      primeiroContato})
      : _uid = uid,
        _fcmToken = fcmToken,
        _notificacoes = notificacoes,
        _nome = nome,
        _bio = bio,
        _imagemUrl = imagemUrl,
        _dataDeNascimento = dataDeNascimento,
        _sexo = sexo,
        _sexoDoOutro = sexoDoOutro,
        _instagram = instagram,
        _facebook = facebook,
        _email = email,
        _whatsapp = whatsapp,
        _twitter = twitter,
        _linkedin = linkedin,
        _youtube = youtube,
        _spotify = spotify,
        _tiktok = tiktok,
        _contatos = contatos,
        _solicitacoesFeitas = solicitacoesFeitas,
        _solicitacoesRecebidas = solicitacoesRecebidas,
        _usuariosSalvos = usuariosSalvos,
        _latitude = latitude,
        _longitude = longitude,
        _visivel = visivel,
        _usuariosQueBloqueei = usuariosQueBloqueei,
        _usuariosQueTeBloquearam = usuariosQueTeBloquearam,
        _mostrarIdade = mostrarIdade,
        _cadastro = cadastro,
        _tutorialBusca = tutorialBusca,
        _primeiroContato = primeiroContato;

  Usuario.fromMap(Map snapshot)
      : _uid = snapshot == null ? '' : snapshot['uid'],
        _fcmToken = snapshot == null ? '' : snapshot['fcmToken'],
        _notificacoes = snapshot == null ? null : snapshot['notificacoes'],
        _nome = snapshot == null ? '' : snapshot['nome'],
        _profissao = snapshot == null ? '' : snapshot['profissao'],
        _bio = snapshot == null ? '' : snapshot['bio'],
        _imagemUrl = snapshot == null ? '' : snapshot['imagemUrl'],
        _dataDeNascimento = snapshot['dataDeNascimento'] == null
            ? null
            : DateTime.parse(snapshot['dataDeNascimento']),
        _sexo = snapshot == null ? '' : snapshot['sexo'],
        _sexoDoOutro = snapshot == null ? '' : snapshot['sexoDoOutro'],
        _instagram = snapshot == null ? '' : snapshot['instagram'],
        _facebook = snapshot == null ? '' : snapshot['facebook'],
        _email = snapshot == null ? '' : snapshot['email'],
        _whatsapp = snapshot == null ? '' : snapshot['whatsapp'],
        _twitter = snapshot == null ? '' : snapshot['twitter'],
        _linkedin = snapshot == null ? '' : snapshot['linkedin'],
        _youtube = snapshot == null ? '' : snapshot['youtube'],
        _spotify = snapshot == null ? '' : snapshot['spotify'],
        _tiktok = snapshot == null ? '' : snapshot['tiktok'],
        _contatos = snapshot == null ? null : snapshot['contatos'],
        _solicitacoesFeitas =
            snapshot == null ? null : snapshot['solicitacoesFeitas'],
        _solicitacoesRecebidas =
            snapshot == null ? null : snapshot['solicitacoesRecebidas'],
        _usuariosSalvos = snapshot == null ? null : snapshot['usuariosSalvos'],
        _latitude = snapshot == null ? null : snapshot['latitude'],
        _longitude = snapshot == null ? null : snapshot['longitude'],
        _visivel = snapshot == null ? null : snapshot['visivel'],
        _usuariosQueBloqueei =
            snapshot == null ? null : snapshot['usuariosQueBloqueei'],
        _usuariosQueTeBloquearam =
            snapshot == null ? null : snapshot['usuariosQueTeBloquearam'],
        _mostrarIdade = snapshot == null ? null : snapshot['mostrarIdade'],
        _cadastro = snapshot == null ? null : snapshot['cadastro'],
        _tutorialBusca = snapshot == null ? null : snapshot['tutorialBusca'],
        _primeiroContato = snapshot == null ? null : snapshot['primeiroContato'];

  toMap() {
    return {
      'uid': _uid,
      'fcmToken': _fcmToken,
      'notificacoes': _notificacoes,
      'nome': _nome,
      'profissao': _profissao,
      'bio': _bio,
      'imagemUrl': _imagemUrl,
      'dataDeNascimento': _dataDeNascimento == null
          ? _dataDeNascimento
          : _dataDeNascimento.toString(),
      'sexo': _sexo,
      'sexoDoOutro': _sexoDoOutro,
      'instagram': _instagram,
      'facebook': _facebook,
      'email': _email,
      'whatsapp': _whatsapp,
      'twitter': _twitter,
      'linkedin': _linkedin,
      'youtube': _youtube,
      'spotify': _spotify,
      'tiktok': _tiktok,
      'contatos': _contatos,
      'solicitacoesFeitas': _solicitacoesFeitas,
      'solicitacoesRecebidas': _solicitacoesRecebidas,
      'usuariosSalvos': _usuariosSalvos,
      'latitude': _latitude,
      'longitude': _longitude,
      'visivel': _visivel,
      'usuariosQueBloqueei': _usuariosQueBloqueei,
      'usuariosQueTeBloquearam': _usuariosQueTeBloquearam,
      'mostrarIdade': _mostrarIdade,
      'cadastro': _cadastro,
      'tutorialBusca': _tutorialBusca,
      'primeiroContato': _primeiroContato,
    };
  }

  void verificarEtapaDoCadastro() {
    //TODO: Navigator
    if (_nome == null) {
      //Navigator.pushNamed(context, TelaCadastroNome.rota);
    } else if (_profissao == null) {
      //Navigator.pushNamed(context, TelaCadastroProfissao.rota);
    } else if (_bio == null) {
      //Navigator.pushNamed(context, TelaCadastroBio.rota);
    } else if (_imagemUrl == null) {
      //Navigator.pushNamed(context, TelaCadastroFoto.rota);
    } else if (_sexo == null) {
      //Navigator.pushNamed(context, TelaCadastroSexo.rota);
    } else if (_dataDeNascimento == null) {
      //Navigator.pushNamed(context, TelaCadastroDataDeNascimento.rota);
    } else if (_whatsapp == null) {
      //Navigator.pushNamed(context, TelaCadastroRedesSociais.rota);
    } else {
      //Navigator.pushNamed(context, TelaContatos.rota);
    }
  }

  void setPrimeiroContato(bool status) {
    _primeiroContato = status;
  }

  void setTutorialBusca(bool status) {
    _tutorialBusca = status;
  }

  void setNotificacoes(List<dynamic> notificacoes) {
    this._notificacoes = notificacoes;
  }

  void setFcmToken(String token) {
    this._fcmToken = token;
  }

  void setNome(String nome) {
    this._nome = nome;
  }

  void setProfissao(String profissao) {
    this._profissao = profissao;
  }

  void setBio(String bio) {
    this._bio = bio;
  }

  void setImagemUrl(String url) {
    this._imagemUrl = url;
  }

  void setSexo(String sexo) {
    this._sexo = sexo;
  }

  void setSexoDoOutro(String sexoDoOutro) {
    this._sexoDoOutro = sexoDoOutro;
  }

  void setDataDeNascimento(DateTime data) {
    this._dataDeNascimento = data;
  }

  void setInstagram(String instagram) {
    this._instagram = instagram;
  }

  void setFacebook(String facebook) {
    this._facebook = facebook;
  }

  void setEmail(String email) {
    this._email = email;
  }

  void setWhatsapp(String whatsapp) {
    this._whatsapp = whatsapp;
  }

  void setTwitter(String twitter) {
    this._twitter = twitter;
  }

  void setLinkedin(String linkedin) {
    this._linkedin = linkedin;
  }

  void setYoutube(String youtube) {
    this._youtube = youtube;
  }

  void setSpotify(String spotify) {
    this._spotify = spotify;
  }

  void setTiktok(String tiktok) {
    this._tiktok = tiktok;
  }

  void setContatos(List<dynamic> contatos) {
    this._contatos = contatos;
  }

  void setSolicitacoesRecebidas(List<dynamic> recebidas) {
    this._solicitacoesRecebidas = recebidas;
  }

  void setSolicitacoesFeitas(List<dynamic> feitas) {
    this._solicitacoesFeitas = feitas;
  }

  void setUsuariosSalvos(List<dynamic> usuariosSalvos) {
    this._usuariosSalvos = usuariosSalvos;
  }

  void setLatitude(double latitude) {
    this._latitude = latitude;
  }

  void setLongitude(double longitude) {
    this._longitude = longitude;
  }

  void setVisivel(bool visivel) {
    this._visivel = visivel;
  }

  void setUsuariosQueBloqueei(List<dynamic> usuariosQueBloqueei) {
    this._usuariosQueBloqueei = usuariosQueBloqueei;
  }

  void setUsuariosQueTeBloquearam(List<dynamic> usuariosQueTeBloquearam) {
    this._usuariosQueTeBloquearam = usuariosQueTeBloquearam;
  }

  void setMostrarIdade(bool mostrarIdade) {
    this._mostrarIdade = mostrarIdade;
  }

  void setCadastro(bool cadastro) {
    this._cadastro = cadastro;
  }


  bool get primeiroContato {
    return this._primeiroContato;
  }

  bool get tutorialBusca {
    return this._tutorialBusca;
  }

  String get uid {
    return this._uid;
  }

  String get fcmToken {
    return this._fcmToken;
  }

  List<dynamic> get notificacoes {
    return this._notificacoes ?? List<dynamic>();
  }

  String get nome {
    return _nome;
  }

  String get profissao {
    return _profissao;
  }

  String get bio {
    return _bio ?? '';
  }

  String get imagemUrl {
    return _imagemUrl ??
        'http://content.internetvideoarchive.com/content/photos/1428/06000501_.jpg';
  }

  String get sexo {
    return _sexo ?? 'masculino';
  }

  String get sexoDoOutro {
    return _sexoDoOutro ?? 'nenhum';
  }

  DateTime get dataDeNascimento {
    return _dataDeNascimento;
  }

  String get instagram {
    return _instagram;
  }

  String get facebook {
    return _facebook;
  }

  String get email {
    return _email;
  }

  String get whatsapp {
    return _whatsapp;
  }

  String get twitter {
    return _twitter;
  }

  String get linkedin {
    return _linkedin;
  }

  String get youtube {
    return _youtube;
  }

  String get spotify {
    return _spotify;
  }

  String get tiktok {
    return _tiktok;
  }

  List<dynamic> get contatos {
    return _contatos ?? List<dynamic>();
  }

  List<dynamic> get solicitacoesRecebidas {
    return _solicitacoesRecebidas ?? List<dynamic>();
  }

  List<dynamic> get solicitacoesFeitas {
    return _solicitacoesFeitas ?? List<dynamic>();
  }

  List<dynamic> get usuariosSalvos {
    return _usuariosSalvos ?? List<dynamic>();
  }

  double get latitude {
    return _latitude ?? 0;
  }

  double get longitude {
    return _longitude ?? 0;
  }

  bool get visivel {
    return _visivel ?? false;
  }

  List<dynamic> get usuariosQueBloqueei {
    return _usuariosQueBloqueei ?? List<dynamic>();
  }

  List<dynamic> get usuariosQueTeBloquearam {
    return _usuariosQueTeBloquearam ?? List<dynamic>();
  }

  bool get mostrarIdade {
    return _mostrarIdade ?? true;
  }

  bool get cadastro {
    return _cadastro ?? false;
  }

  @override
  // TODO: implement props
  List<Object> get props => [_uid];
}
