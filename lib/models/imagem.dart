// models/imagem.dart
import 'descritor.dart';

class Imagem {
  final int id;
  final String nome;
  final String URL;
  final String tipo;
  final List<Descritor> descritores;

  Imagem(this.id, this.nome, this.URL, this.tipo, this.descritores);
}
