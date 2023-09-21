// models/explicacao.dart

enum TipoExplicacao { Local, Global, AnaliseDados }

class Explicacao {
  final int id;
  final String nome;
  final String URL;
  final String descricao;
  final TipoExplicacao tipo;

  Explicacao(this.id, this.nome, this.URL, this.descricao, this.tipo);
}
