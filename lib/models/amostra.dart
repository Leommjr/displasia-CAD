// models/amostra.dart
import 'package:displasia_cad/models/descritor.dart';

import 'imagem.dart';
import 'explicacao.dart';

enum Classificacao { Saudavel, Leve, Moderada, Severa }

enum Confianca { Confiavel, Incerta, Inconclusiva }

class AmostraModel {
  final int id;
  final String nome;
  final List<Imagem> imagens;
  Classificacao classificacao;
  final Explicacao explicacaoPrincipal;
  final List<Explicacao> explicacoesComplementares;
  final List<int> amostrasSimilares;
  Confianca confianca;

  AmostraModel(
      this.id,
      this.nome,
      this.imagens,
      this.classificacao,
      this.explicacaoPrincipal,
      this.explicacoesComplementares,
      this.amostrasSimilares,
      this.confianca);

  static List<AmostraModel> getAmostras() {
    return [
      AmostraModel(
          1,
          'Test',
          [
            Imagem(
                1,
                'TesteImage',
                'https://imgs.search.brave.com/FnWxlkJ58VcPBSYYkjxCnodBmfjDKDr6HgN6o92Dsoc/rs:fit:860:0:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvY29tbW9ucy8z/LzMxL0F0eXBpY2Fs/X21pdG9zaXMuanBn',
                'dog',
                [Descritor(1, "Media", 1.23, TipoDescritor.Morfologico)])
          ],
          Classificacao.Leve,
          Explicacao(
              1,
              "test",
              "http://aaaa",
              """
--- classe predita (severa) ---
anchor:  StdDev_Avr_r <= 27.51 Median_Soliditys <= 0.97 StdDev_StdDev_b > 8.38
Quando estas condições são verdadeiras (0,9% dos casos), o modelo prediz Severa em 100% dos casos.

--- Porque não saudável ---
anchor:  Median_Max_r > 193.25 Avr_Areas <= 939.03
Quando estas condições são verdadeiras (15,3% dos casos), o modelo prediz diferente de Saudável em 100% dos casos;

--- Porque não leve ---
anchor:  Median_Soliditys <= 0.97 StdDev_Min_r > 29.85
Quando estas condições são verdadeiras (14,4% dos casos), o modelo prediz diferente de leve em 100% dos casos.

--- Porque não moderada ---
anchor:  Mode_Extents > 0.56 Avr_StdDev_b > 24.33
Quando estas condições são verdadeiras (14,7% dos casos), o modelo prediz diferente de moderada em 99,1% dos casos.
""",
              TipoExplicacao.Local),
          [
            Explicacao(
                1, "test", "http://aaaa", "explicado", TipoExplicacao.Local)
          ],
          [2, 3],
          Confianca.Confiavel),
      AmostraModel(
          2,
          'Test2',
          [
            Imagem(
                1,
                'TesteImage',
                'https://patologiabucal.com.br/wp-content/uploads/leucoplasia-micro-1030x579.jpg',
                'dog',
                [Descritor(1, "Media", 1.23, TipoDescritor.Morfologico)])
          ],
          Classificacao.Leve,
          Explicacao(
              1, "test", "http://aaaa", "explicado", TipoExplicacao.Local),
          [
            Explicacao(
                1, "test", "http://aaaa", "explicado", TipoExplicacao.Local)
          ],
          [1, 3, 4],
          Confianca.Confiavel),
      AmostraModel(
          3,
          'Test3',
          [
            Imagem(
                1,
                'TesteImage',
                'https://patologiabucal.com.br/wp-content/uploads/leucoplasia-micro-1030x579.jpg',
                'dog',
                [Descritor(1, "Media", 1.23, TipoDescritor.Morfologico)])
          ],
          Classificacao.Leve,
          Explicacao(
              1, "test", "http://aaaa", "explicado", TipoExplicacao.Local),
          [
            Explicacao(
                1, "test", "http://aaaa", "explicado", TipoExplicacao.Local)
          ],
          [2, 1, 4],
          Confianca.Confiavel),
    ];
  }
}
