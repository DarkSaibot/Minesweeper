import 'explosao_exception.dart';

class Campo {
  late final int linha;
  late final int coluna;
  final List<Campo> vizinhos = [];

  bool _aberto = false;
  bool _marcado = false;
  bool _minado = false;
  bool _explodido = false;

  Campo({
    required this.linha,
    required this.coluna,
  });

  void adicionarVizinho(Campo vizinho) {
    final deltaLinha = (linha - vizinho.linha).abs();
    final deltaColuna = (coluna - vizinho.coluna).abs();

    if (deltaLinha == 0 && deltaColuna == 0) {
      return;
    }
    if (deltaLinha <= 1 && deltaColuna <= 1) {
      vizinhos.add(vizinho);
    }
  }

  void abrir() {
    if (_aberto) {
      return;
    }

    _aberto = true;

    if (_minado) {
      _explodido = true;
      throw ExplosaoException();
    }

    if (vizinhacaSegura) {
      vizinhos.forEach((vizinho) => vizinho.abrir());
    }
  }

  void relevarBomba() {
    if (_minado) {
      _aberto = true;
    }
  }

  void minar() {
    _minado = true;
  }

  void alternarMarcacao() {
    _marcado = !_marcado;
  }

  void reiniciar() {
    _aberto = false;
    _marcado = false;
    _minado = false;
    _explodido = false;
  }

  bool get minado {
    return _minado;
  }

  bool get explodido {
    return _explodido;
  }

  bool get aberto {
    return _aberto;
  }

  bool get marcado {
    return _marcado;
  }

  bool get resolvido {
    bool minadoEMArcado = minado && marcado;
    bool seguroEAberto = !minado && aberto;
    return minadoEMArcado || seguroEAberto; // O SIMBOLO "||" SIGNIFICA OU!
  }

  bool get vizinhacaSegura {
    return vizinhos.every((vizinho) => !vizinho.minado);
  }

  int get qtdeMinasNaVizinhaca {
    return vizinhos.where((vizinho) => vizinho.minado).length;
  }
}
