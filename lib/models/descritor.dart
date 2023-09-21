// models/descritor.dart

enum TipoDescritor { Morfologico, NaoMorfologico }

class Descritor {
  final int id;
  final String nome;
  final double valor;
  final TipoDescritor tipo;

  Descritor(this.id, this.nome, this.valor, this.tipo);
}
